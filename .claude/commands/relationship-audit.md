# /relationship-audit — Auditoria de relaciones entre tablas

Analiza la integridad referencial del sistema: foreign keys, registros huerfanos, dependencias circulares, impacto de cascadas y validacion en capa de servicios.

## Uso
```
/relationship-audit all              → Auditoria completa de todas las relaciones
/relationship-audit orphans          → Solo detectar registros huerfanos
/relationship-audit fk-coverage      → Validar cobertura de foreign keys
/relationship-audit cascade          → Analisis de impacto de cascadas
/relationship-audit service-layer    → Validar checks de FK en servicios
/relationship-audit report           → Genera reporte en docs/audit/
```

## Instrucciones

### 1. Inventario de Foreign Keys

Listar TODAS las foreign keys existentes en el schema `shared` y `public`:

```sql
-- FKs en shared schema
SELECT
  tc.table_name AS tabla_hija,
  kcu.column_name AS columna_fk,
  ccu.table_name AS tabla_padre,
  ccu.column_name AS columna_referenciada,
  rc.update_rule,
  rc.delete_rule
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
  ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
  ON ccu.constraint_name = tc.constraint_name AND ccu.table_schema = tc.table_schema
JOIN information_schema.referential_constraints rc
  ON rc.constraint_name = tc.constraint_name AND rc.constraint_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema IN ('shared', 'public')
ORDER BY tc.table_name, kcu.column_name;
```

Verificar que cada FK tenga la politica correcta:
| Relacion | delete_rule esperada | Razon |
|----------|---------------------|-------|
| bookings → clients | RESTRICT o SET NULL | No borrar citas al borrar cliente |
| bookings → services | RESTRICT | No borrar servicio con citas activas |
| bookings → professionals | SET NULL | Profesional puede desvincularse |
| payments → bookings | RESTRICT o SET NULL | Historial financiero debe preservarse |
| professional_services → professionals | CASCADE | Limpiar al borrar profesional |
| professional_services → services | CASCADE | Limpiar al borrar servicio |
| client_memberships → clients | CASCADE | Borrar subs al borrar cliente |
| client_memberships → memberships | RESTRICT | No borrar plan con subs activas |
| client_packages → clients | CASCADE | Borrar paquetes al borrar cliente |
| client_packages → service_packages | RESTRICT | No borrar paquete con asignaciones |
| commissions → bookings | SET NULL | Preservar historial de comisiones |
| commissions → professionals | RESTRICT | No borrar profesional con comisiones |
| invoices → clients | RESTRICT | No borrar cliente con facturas |
| stock_movements → products | RESTRICT | No borrar producto con movimientos |
| gift_card_redemptions → gift_cards | RESTRICT | No borrar tarjeta con redenciones |
| schedule* → professionals | CASCADE | Limpiar agenda al borrar profesional |
| reviews → bookings | SET NULL | Preservar reviews |
| survey_responses → surveys | CASCADE | Borrar respuestas al borrar encuesta |
| subscriptions → tenants | CASCADE | Borrar sub al borrar tenant |
| subscriptions → plans | RESTRICT | No borrar plan con suscripciones |

### 2. Foreign Keys faltantes

Verificar que las siguientes relaciones EXISTAN como FK en la base de datos.
Para cada tabla hija, verificar que la columna `*_id` tiene un FK constraint:

**Tablas criticas:**
```
shared.bookings:
  - client_id → shared.clients(id)
  - service_id → shared.services(id)
  - professional_id → shared.professionals(id)
  - location_id → shared.locations(id)

shared.payments:
  - booking_id → shared.bookings(id)
  - client_id → shared.clients(id)

shared.invoices:
  - client_id → shared.clients(id)
  - booking_id → shared.bookings(id)

shared.professional_services:
  - professional_id → shared.professionals(id)
  - service_id → shared.services(id)

shared.schedules:
  - professional_id → shared.professionals(id)

shared.schedule_breaks:
  - schedule_id → shared.schedules(id)

shared.schedule_exceptions:
  - professional_id → shared.professionals(id)

shared.client_memberships:
  - client_id → shared.clients(id)
  - membership_id → shared.memberships(id)

shared.client_packages:
  - client_id → shared.clients(id)
  - package_id → shared.service_packages(id)

shared.package_usages:
  - client_package_id → shared.client_packages(id)
  - booking_id → shared.bookings(id)

shared.commission_rules:
  - professional_id → shared.professionals(id)
  - service_id → shared.services(id)

shared.commissions:
  - booking_id → shared.bookings(id)
  - professional_id → shared.professionals(id)

shared.gift_card_redemptions:
  - gift_card_id → shared.gift_cards(id)

shared.stock_movements:
  - product_id → shared.products(id)

shared.reviews:
  - client_id → shared.clients(id)
  - booking_id → shared.bookings(id)

shared.survey_responses:
  - survey_id → shared.surveys(id)
  - client_id → shared.clients(id)
  - booking_id → shared.bookings(id)

shared.waitlist:
  - client_id → shared.clients(id)
  - service_id → shared.services(id)
  - professional_id → shared.professionals(id)

shared.notifications:
  - booking_id → shared.bookings(id)

shared.services:
  - category_id → shared.service_categories(id)

shared.professionals:
  - user_id → shared.users(id)

shared.restaurant_reservations:
  - booking_id → shared.bookings(id)
  - table_id → shared.restaurant_tables(id)

shared.attendance:
  - booking_id → shared.bookings(id)
  - client_id → shared.clients(id)

shared.health_records:
  - client_id → shared.clients(id)

shared.work_orders:
  - client_id → shared.clients(id)

shared.cases:
  - client_id → shared.clients(id)

public.subscriptions:
  - tenant_id → public.tenants(id)
  - plan_id → public.plans(id)

public.platform_audit_logs:
  - admin_id → public.super_admin_users(id)
```

Para cada relacion, ejecutar:
```sql
SELECT EXISTS (
  SELECT 1 FROM information_schema.table_constraints tc
  JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
  WHERE tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema = 'shared'
    AND tc.table_name = '{tabla_hija}'
    AND kcu.column_name = '{columna_fk}'
) AS fk_exists;
```

### 3. Deteccion de registros huerfanos

Para cada relacion FK, detectar registros hijos que apuntan a padres inexistentes:

```sql
-- Bookings con client_id huerfano
SELECT b.id, b.booking_number, b.client_id
FROM shared.bookings b
LEFT JOIN shared.clients c ON b.client_id = c.id
WHERE b.client_id IS NOT NULL AND c.id IS NULL
LIMIT 50;

-- Bookings con service_id huerfano
SELECT b.id, b.booking_number, b.service_id
FROM shared.bookings b
LEFT JOIN shared.services s ON b.service_id = s.id
WHERE b.service_id IS NOT NULL AND s.id IS NULL
LIMIT 50;

-- Bookings con professional_id huerfano
SELECT b.id, b.booking_number, b.professional_id
FROM shared.bookings b
LEFT JOIN shared.professionals p ON b.professional_id = p.id
WHERE b.professional_id IS NOT NULL AND p.id IS NULL
LIMIT 50;

-- Payments con booking_id huerfano
SELECT p.id, p.amount, p.booking_id
FROM shared.payments p
LEFT JOIN shared.bookings b ON p.booking_id = b.id
WHERE p.booking_id IS NOT NULL AND b.id IS NULL
LIMIT 50;

-- Payments con client_id huerfano
SELECT p.id, p.amount, p.client_id
FROM shared.payments p
LEFT JOIN shared.clients c ON p.client_id = c.id
WHERE p.client_id IS NOT NULL AND c.id IS NULL
LIMIT 50;

-- Professional_services con professional_id huerfano
SELECT ps.professional_id, ps.service_id
FROM shared.professional_services ps
LEFT JOIN shared.professionals p ON ps.professional_id = p.id
WHERE p.id IS NULL
LIMIT 50;

-- Professional_services con service_id huerfano
SELECT ps.professional_id, ps.service_id
FROM shared.professional_services ps
LEFT JOIN shared.services s ON ps.service_id = s.id
WHERE s.id IS NULL
LIMIT 50;

-- Client_memberships con client_id huerfano
SELECT cm.id, cm.client_id, cm.membership_id
FROM shared.client_memberships cm
LEFT JOIN shared.clients c ON cm.client_id = c.id
WHERE c.id IS NULL
LIMIT 50;

-- Client_packages con client_id huerfano
SELECT cp.id, cp.client_id, cp.package_id
FROM shared.client_packages cp
LEFT JOIN shared.clients c ON cp.client_id = c.id
WHERE c.id IS NULL
LIMIT 50;

-- Commissions con professional_id huerfano
SELECT co.id, co.professional_id, co.booking_id
FROM shared.commissions co
LEFT JOIN shared.professionals p ON co.professional_id = p.id
WHERE co.professional_id IS NOT NULL AND p.id IS NULL
LIMIT 50;

-- Invoices con client_id huerfano
SELECT i.id, i.invoice_number, i.client_id
FROM shared.invoices i
LEFT JOIN shared.clients c ON i.client_id = c.id
WHERE i.client_id IS NOT NULL AND c.id IS NULL
LIMIT 50;

-- Stock_movements con product_id huerfano
SELECT sm.id, sm.product_id, sm.quantity
FROM shared.stock_movements sm
LEFT JOIN shared.products p ON sm.product_id = p.id
WHERE p.id IS NULL
LIMIT 50;

-- Schedules con professional_id huerfano
SELECT s.id, s.professional_id, s.day_of_week
FROM shared.schedules s
LEFT JOIN shared.professionals p ON s.professional_id = p.id
WHERE p.id IS NULL
LIMIT 50;

-- Services con category_id huerfano
SELECT s.id, s.name, s.category_id
FROM shared.services s
LEFT JOIN shared.service_categories sc ON s.category_id = sc.id
WHERE s.category_id IS NOT NULL AND sc.id IS NULL
LIMIT 50;

-- Professionals con user_id huerfano
SELECT p.id, p.name, p.user_id
FROM shared.professionals p
LEFT JOIN shared.users u ON p.user_id = u.id
WHERE p.user_id IS NOT NULL AND u.id IS NULL
LIMIT 50;
```

**Criterio:** Cualquier resultado > 0 filas es un problema que requiere correccion.

### 4. Analisis de impacto de cascadas

Para cada tabla padre, calcular cuantos registros hijos se verian afectados por un DELETE:

```sql
-- Impacto de borrar un cliente
SELECT
  c.id, c.name,
  (SELECT COUNT(*) FROM shared.bookings b WHERE b.client_id = c.id) AS bookings,
  (SELECT COUNT(*) FROM shared.payments p WHERE p.client_id = c.id) AS payments,
  (SELECT COUNT(*) FROM shared.invoices i WHERE i.client_id = c.id) AS invoices,
  (SELECT COUNT(*) FROM shared.client_memberships cm WHERE cm.client_id = c.id) AS memberships,
  (SELECT COUNT(*) FROM shared.client_packages cp WHERE cp.client_id = c.id) AS packages,
  (SELECT COUNT(*) FROM shared.reviews r WHERE r.client_id = c.id) AS reviews,
  (SELECT COUNT(*) FROM shared.waitlist w WHERE w.client_id = c.id) AS waitlist
FROM shared.clients c
ORDER BY (
  (SELECT COUNT(*) FROM shared.bookings b WHERE b.client_id = c.id) +
  (SELECT COUNT(*) FROM shared.payments p WHERE p.client_id = c.id)
) DESC
LIMIT 10;

-- Impacto de borrar un profesional
SELECT
  p.id, p.name,
  (SELECT COUNT(*) FROM shared.bookings b WHERE b.professional_id = p.id) AS bookings,
  (SELECT COUNT(*) FROM shared.professional_services ps WHERE ps.professional_id = p.id) AS services,
  (SELECT COUNT(*) FROM shared.schedules s WHERE s.professional_id = p.id) AS schedules,
  (SELECT COUNT(*) FROM shared.commissions co WHERE co.professional_id = p.id) AS commissions,
  (SELECT COUNT(*) FROM shared.commission_rules cr WHERE cr.professional_id = p.id) AS rules
FROM shared.professionals p
ORDER BY (SELECT COUNT(*) FROM shared.bookings b WHERE b.professional_id = p.id) DESC
LIMIT 10;

-- Impacto de borrar un servicio
SELECT
  s.id, s.name,
  (SELECT COUNT(*) FROM shared.bookings b WHERE b.service_id = s.id) AS bookings,
  (SELECT COUNT(*) FROM shared.professional_services ps WHERE ps.service_id = s.id) AS professionals,
  (SELECT COUNT(*) FROM shared.waitlist w WHERE w.service_id = s.id) AS waitlist
FROM shared.services s
ORDER BY (SELECT COUNT(*) FROM shared.bookings b WHERE b.service_id = s.id) DESC
LIMIT 10;
```

### 5. Validacion en capa de servicios

Para cada servicio con metodos `create*()`, verificar que se valida la existencia de las entidades referenciadas ANTES del INSERT:

| Servicio | Metodo | FKs a validar | Como verificar |
|----------|--------|---------------|----------------|
| BookingsService | create() | client_id, service_id, professional_id, location_id | Buscar SELECT/findOne antes del INSERT |
| PaymentsService | create() | booking_id, client_id | Buscar validacion de existencia |
| InvoicingService | create() | client_id, booking_id | Buscar NotFoundException |
| CommissionsService | createRule() | professional_id, service_id | Buscar SELECT id FROM antes de INSERT |
| PackagesService | create() | service_ids[], product_ids[] | Buscar COUNT vs length validation |
| PackagesService | assignToClient() | package_id, client_id | Buscar findOne + SELECT id |
| MembershipsService | assignToClient() | membership_id, client_id | Buscar findOne + SELECT id |
| GiftCardsService | redeem() | gift_card_id | Buscar validacion de existencia |
| SurveysService | submitResponse() | survey_id, booking_id, client_id | Buscar validacion |
| WaitlistService | addToWaitlist() | client_id, service_id, professional_id | Buscar validacion |
| InventoryService | addStockMovement() | product_id | Buscar findOne previo |
| ReviewsService | create() | booking_id, client_id | Buscar validacion |

**Criterio:** Cada FK en un INSERT debe tener una validacion previa que lanza NotFoundException si no existe.

### 6. Grafo de dependencias

Generar un grafo de dependencias entre tablas basado en las FKs:

```
Nivel 0 (sin dependencias): users, service_categories, plans, tenants, super_admin_users, restaurant_tables
Nivel 1: professionals(→users), services(→categories), locations, memberships, service_packages, surveys, gift_cards, products
Nivel 2: schedules(→prof), clients, subscriptions(→tenants,plans), commission_rules(→prof,svc)
Nivel 3: bookings(→clients,svc,prof,loc), professional_services(→prof,svc), client_memberships(→clients,memberships)
Nivel 4: payments(→bookings,clients), invoices(→clients,bookings), commissions(→bookings,prof), waitlist(→clients,svc,prof), reviews(→bookings,clients), notifications(→bookings), attendance(→bookings,clients), restaurant_reservations(→bookings), schedule_exceptions(→prof)
Nivel 5: package_usages(→client_packages,bookings), gift_card_redemptions(→gift_cards), stock_movements(→products), survey_responses(→surveys,clients,bookings), schedule_breaks(→schedules)
```

**Uso:** El orden inverso (5→0) es el orden seguro para DELETE. El orden directo (0→5) es el orden seguro para INSERT/migration.

### 7. Validacion RLS + FK

Cuando USE_RLS=true, verificar que las FK entre tablas del schema `shared` funcionan correctamente con las politicas RLS:

```sql
-- Verificar que todas las FKs en shared apuntan a tablas dentro de shared (no cross-schema)
SELECT
  tc.table_name, kcu.column_name,
  ccu.table_schema AS target_schema, ccu.table_name AS target_table
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage ccu ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'shared'
  AND ccu.table_schema != 'shared';
-- Resultado esperado: 0 filas (todas las FKs deben ser intra-schema)

-- Verificar que tablas hija y padre tienen el mismo tenant_id en sus registros
-- (si no, RLS filtraria al padre y romperia la FK logica)
SELECT 'bookings→clients' AS rel,
  COUNT(*) AS mismatches
FROM shared.bookings b
JOIN shared.clients c ON b.client_id = c.id
WHERE b.tenant_id != c.tenant_id

UNION ALL

SELECT 'bookings→services',
  COUNT(*)
FROM shared.bookings b
JOIN shared.services s ON b.service_id = s.id
WHERE b.tenant_id != s.tenant_id

UNION ALL

SELECT 'bookings→professionals',
  COUNT(*)
FROM shared.bookings b
JOIN shared.professionals p ON b.professional_id = p.id
WHERE b.professional_id IS NOT NULL AND b.tenant_id != p.tenant_id

UNION ALL

SELECT 'payments→bookings',
  COUNT(*)
FROM shared.payments p
JOIN shared.bookings b ON p.booking_id = b.id
WHERE p.booking_id IS NOT NULL AND p.tenant_id != b.tenant_id

UNION ALL

SELECT 'invoices→clients',
  COUNT(*)
FROM shared.invoices i
JOIN shared.clients c ON i.client_id = c.id
WHERE i.client_id IS NOT NULL AND i.tenant_id != c.tenant_id;
-- Resultado esperado: TODOS con 0 mismatches
```

## Formato de salida

```markdown
# Reporte de Relaciones entre Tablas — [fecha]

## Resumen ejecutivo
- X foreign keys encontradas
- X relaciones esperadas vs Y existentes (cobertura: Z%)
- X registros huerfanos detectados
- X relaciones con politica de cascade incorrecta

## Inventario de FKs
| Tabla hija | Columna FK | Tabla padre | ON DELETE | ON UPDATE | Estado |
|------------|-----------|-------------|-----------|-----------|--------|

## FKs faltantes
| Tabla hija | Columna | Tabla padre esperada | Riesgo |
|------------|---------|---------------------|--------|

## Registros huerfanos
| Relacion | Cantidad | Ejemplo IDs | Severidad |
|----------|----------|-------------|-----------|

## Impacto de cascadas
| Tabla padre | Tabla hija | Registros afectados | Politica actual | Politica recomendada |
|-------------|-----------|---------------------|-----------------|---------------------|

## Validacion en servicios
| Servicio | Metodo | FKs validadas | FKs NO validadas | Estado |
|----------|--------|--------------|------------------|--------|

## RLS + FK
| Relacion | Mismatches tenant_id | Estado |
|----------|---------------------|--------|

## Acciones requeridas
1. [CRITICO] Descripcion...
2. [MEDIO] Descripcion...
```

## Cuando ejecutar

- Despues de agregar nuevas tablas o relaciones
- Antes de cada release a produccion
- Despues de migraciones de datos (bulk import, schema changes)
- Cuando se reporta un error de "registro no encontrado" inesperado
- Despues de ejecutar la migracion RLS
- Como parte de la auditoria mensual junto con `/data-integrity`
