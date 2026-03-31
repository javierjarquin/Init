# /data-integrity — Auditoria de integridad de datos

Analiza la integridad de datos del sistema a nivel de base de datos, servicios e importaciones. Detecta duplicados, constraints faltantes, validaciones ausentes y riesgos de corrupcion de datos.

## Uso
```
/data-integrity all              → Auditoria completa de todas las tablas
/data-integrity {table}          → Solo una tabla especifica (customers, vehicles, products, etc.)
/data-integrity import           → Solo el modulo de importacion
/data-integrity report           → Genera reporte en docs/audit/
```

## Instrucciones

### 1. Analisis de constraints en la base de datos

Para cada tabla de negocio, verificar en `docs/data-model/schema.sql` y `supabase/migrations/`:

- **UNIQUE constraints**: Que campos tienen restriccion de unicidad?
- **NOT NULL**: Que campos obligatorios no tienen NOT NULL?
- **FOREIGN KEYS**: Todas las relaciones estan protegidas con FK?
- **CHECK constraints**: Valores permitidos en enums estan validados?
- **Partial indexes**: Para columnas nullable, existen partial unique indexes con `WHERE col IS NOT NULL`?
- **Scope tenant_id**: Todos los UNIQUE constraints de tablas multi-tenant incluyen `tenant_id`?

**Tablas criticas a auditar:**
| Tabla | Campos clave de unicidad |
|-------|-------------------------|
| customers | (tenant_id, phone), (tenant_id, email), (tenant_id, rfc) |
| vehicles | (tenant_id, vin), (tenant_id, plates) |
| products | (tenant_id, internal_code), (tenant_id, oem_code), (tenant_id, barcode) |
| suppliers | (tenant_id, rfc) |
| service_catalog | (tenant_id, code) |
| brands | (name) |
| models | (brand_id, name, engine, year_from) |
| service_orders | (tenant_id, folio) |
| purchase_orders | (tenant_id, folio) |
| quotes | (tenant_id, folio) |
| invoices | (tenant_id, folio) |

### 2. Analisis de validacion en servicios (capa de aplicacion)

Para cada servicio `create*()` en `src/modules/*/services/`, verificar:

- Existe un check de duplicados ANTES del insert?
- El mensaje de error es amigable en espanol?
- Se verifica solo para campos que tienen valor (skip null/empty)?
- Se usa `.maybeSingle()` para el check?

**Servicios a auditar:**
- `src/modules/customers/services/customer.service.ts` → createCustomer()
- `src/modules/customers/services/vehicle.service.ts` → createVehicle()
- `src/modules/inventory/services/product.service.ts` → createProduct()
- `src/modules/suppliers/services/supplier.service.ts` → createSupplier()
- `src/modules/catalog/services/service-catalog.service.ts` → createService()
- `src/modules/catalog/services/brand.service.ts` → createBrand()
- `src/modules/catalog/services/model.service.ts` → createModel()

### 3. Analisis de validacion en importaciones

Para cada entidad en `src/modules/import/services/import-processor.service.ts`, verificar:

- Se validan campos obligatorios?
- Se verifican duplicados contra la DB antes de insertar?
- Se verifican duplicados DENTRO del mismo CSV (filas repetidas)?
- El error reporta numero de fila y campo?
- Los mensajes son amigables en espanol?

**Entidades a auditar:** brands, models, customers, vehicles, products, suppliers, services

### 4. Deteccion de datos duplicados existentes

Si hay acceso a la base de datos, ejecutar queries para detectar duplicados ya existentes:

```sql
-- Clientes con telefono duplicado
SELECT tenant_id, phone, COUNT(*) FROM customers GROUP BY tenant_id, phone HAVING COUNT(*) > 1;

-- Vehiculos con VIN duplicado
SELECT tenant_id, vin, COUNT(*) FROM vehicles WHERE vin IS NOT NULL GROUP BY tenant_id, vin HAVING COUNT(*) > 1;

-- Vehiculos con placas duplicadas
SELECT tenant_id, plates, COUNT(*) FROM vehicles WHERE plates IS NOT NULL GROUP BY tenant_id, plates HAVING COUNT(*) > 1;

-- Productos con codigo interno duplicado
SELECT tenant_id, internal_code, COUNT(*) FROM products WHERE internal_code IS NOT NULL GROUP BY tenant_id, internal_code HAVING COUNT(*) > 1;

-- Proveedores con RFC duplicado
SELECT tenant_id, rfc, COUNT(*) FROM suppliers WHERE rfc IS NOT NULL GROUP BY tenant_id, rfc HAVING COUNT(*) > 1;

-- Marcas con nombre duplicado
SELECT name, COUNT(*) FROM brands GROUP BY name HAVING COUNT(*) > 1;
```

### 5. Validacion de reglas de negocio

Verificar coherencia operativa:

- **Precios**: Ningun precio de venta puede ser <= 0
- **Stock**: stock_minimo no puede ser mayor que stock_maximo
- **Folios**: No pueden existir folios vacios o null en OS, OC, presupuestos, facturas
- **Vehiculos**: Ano del vehiculo debe estar entre 1900 y ano_actual + 2
- **Clientes**: No pueden tener nombre vacio
- **Ordenes de servicio**: No pueden tener customer_id o vehicle_id null
- **Inventario**: available_qty no puede ser negativo
- **Presupuestos**: No pueden tener total negativo
- **Pagos**: No pueden exceder el total de la OS

### 6. Defensa en profundidad (defense-in-depth)

Verificar que cada entidad tiene proteccion en las 3 capas:

| Capa | Descripcion | Como verificar |
|------|-------------|----------------|
| **DB** | UNIQUE constraint / partial index | Revisar schema.sql y migraciones |
| **Service** | Check pre-insert en create*() | Revisar servicios |
| **Import** | Check pre-insert en processEntity() | Revisar import-processor |

Resultado esperado: cada campo critico debe tener proteccion en las 3 capas.

## Formato de salida

```markdown
# Reporte de Integridad de Datos — [fecha]

## Resumen ejecutivo
- X tablas auditadas
- X campos protegidos en las 3 capas
- X gaps encontrados (criticidad alta/media/baja)

## Detalle por tabla

### customers
| Campo | DB Constraint | Service Check | Import Check | Estado |
|-------|--------------|---------------|-------------|--------|
| phone | OK | OK | OK | PROTEGIDO |
| email | OK | OK | OK | PROTEGIDO |

## Acciones requeridas
1. [CRITICO] Descripcion...
2. [MEDIO] Descripcion...

## Datos duplicados existentes
(resultados de las queries)
```

## Cuando ejecutar

- Antes de cada release a produccion
- Despues de agregar nuevas tablas o columnas
- Despues de importaciones masivas de datos
- Cuando se reporta un bug de "registro duplicado"
- Como parte de la auditoria mensual
