# /verify-req — Verificar requerimiento contra el codigo real

Antes de implementar un requerimiento, verifica que todo lo que se asume EXISTE realmente en el codigo. Previene alucinaciones cruzando el requerimiento con el estado real del proyecto.

## Uso
```
/verify-req "agregar campo email a tabla clientes"
/verify-req "endpoint POST /api/orders debe validar stock"
/verify-req "el form de ventas debe calcular IVA automaticamente"
/verify-req                → Verifica el ultimo requerimiento discutido
```

## Instrucciones

### Paso 1: Descomponer el requerimiento

Extrae TODAS las suposiciones implicitas del requerimiento. Para cada una, marca si es algo que DEBE EXISTIR o algo que SE VA A CREAR.

Ejemplo: "agregar campo email a tabla clientes"
```
Suposiciones:
  [DEBE EXISTIR] Tabla "clientes" existe en la BD
  [DEBE EXISTIR] Hay un modelo/clase/entity para clientes
  [DEBE EXISTIR] Hay un form/vista que muestra clientes
  [SE VA A CREAR] Campo "email" en la tabla
  [SE VA A CREAR] Validacion de email
  [VERIFICAR]     ¿Ya existe un campo email? ¿Se llama diferente?
```

### Paso 2: Verificar CADA suposicion

Para cada "DEBE EXISTIR", busca en el codigo real:

1. **Tablas/entidades**: Busca en migraciones, schemas, modelos ORM, archivos SQL
   - `grep -r "CREATE TABLE" sql/ migrations/`
   - `grep -r "class.*Customer\|TCustomer\|clientes" src/`
   - Lee el schema actual de la BD si hay acceso

2. **Endpoints/rutas**: Busca en routers, controllers, handlers
   - `grep -r "POST.*orders\|@Post.*orders\|router.*orders" src/`

3. **Forms/vistas**: Busca formularios, componentes, pages
   - `grep -r "frmClientes\|ClienteForm\|CustomerPage" src/`

4. **Funciones/metodos**: Busca la funcion que se menciona
   - `grep -r "calcularIVA\|calculateTax\|CalcIVA" src/`

5. **Campos/propiedades**: Busca el campo especifico
   - `grep -r "email\|correo\|e_mail" src/ sql/`

### Paso 3: Generar reporte de verificacion

```
## Verificacion de requerimiento

### Requerimiento
"[texto original]"

### Suposiciones verificadas

| # | Suposicion | Estado | Evidencia |
|---|-----------|--------|-----------|
| 1 | Tabla "clientes" existe | ✅ EXISTE | sql/migrations/001_create_clientes.sql:3 |
| 2 | Modelo TCliente existe | ✅ EXISTE | src/models/Cliente.pas:12 |
| 3 | Form de clientes existe | ✅ EXISTE | src/forms/frmClientes.pas |
| 4 | Campo email no existe aun | ✅ CONFIRMADO | No se encontro en schema |
| 5 | Hay validacion de formato | ❌ NO EXISTE | No hay funcion de validacion de email |

### Nombres reales en el codigo
⚠️ IMPORTANTE — usa estos nombres exactos, NO inventes otros:

| Concepto | Nombre REAL en el codigo | Ubicacion |
|----------|--------------------------|-----------|
| Tabla | CLIENTES (no "customers") | sql/schema.sql:45 |
| Modelo | TCliente (no "TCustomer") | src/models/Cliente.pas:12 |
| Form | TfrmClientes | src/forms/frmClientes.pas:1 |
| DataModule | TdmClientes | src/datamodules/dmClientes.pas:8 |
| PK | CLIENTE_ID (INTEGER) | sql/schema.sql:46 |

### Dependencias encontradas
- frmClientes usa dmClientes (linea 5: uses uDmClientes)
- dmClientes tiene qryClientes con SELECT * FROM CLIENTES
- El grid muestra: CLIENTE_ID, NOMBRE, TELEFONO, DIRECCION (no tiene EMAIL)

### Plan de implementacion verificado
1. ✅ Crear migracion: ALTER TABLE CLIENTES ADD EMAIL VARCHAR(100)
2. ✅ Agregar campo al TdmClientes.qryClientes
3. ✅ Agregar TDBEdit al TfrmClientes.pas
4. ⚠️ CREAR funcion ValidarEmail (no existe — hay que crearla)
5. ✅ Actualizar TCliente con property Email

### Riesgos detectados
- ⚠️ La tabla CLIENTES tiene 15,000 registros — ALTER TABLE sera rapido pero verificar
- ⚠️ No hay .env.example documentando la BD — el connection string esta en dmConexion.pas:23
```

### Paso 4: Pedir confirmacion

SIEMPRE pregunta al usuario:
```
¿Los nombres y ubicaciones son correctos? ¿Procedo con la implementacion?
```

NO implementes nada hasta que el usuario confirme.

## Reglas criticas

1. **NUNCA asumas que algo existe sin buscarlo primero**
   - NO: "La tabla customers probablemente tiene un campo id..."
   - SI: "Busque en sql/schema.sql y la tabla se llama CLIENTES, PK es CLIENTE_ID"

2. **Usa los nombres REALES del codigo, no los del requerimiento**
   - El usuario dice "clientes" pero la tabla puede ser "CUSTOMERS" o "tbl_cliente"
   - El usuario dice "email" pero el campo puede ser "CORREO" o "E_MAIL"

3. **Si algo no existe, dilo claramente**
   - NO: "Voy a modificar la funcion calcularTotal..."
   - SI: "No encontre ninguna funcion calcularTotal. ¿Se llama diferente, o hay que crearla?"

4. **Verifica las relaciones entre archivos**
   - Si vas a editar un form, verifica que uses/ imports apuntan a los archivos correctos
   - Si vas a editar una tabla, verifica que foreign keys no se rompan

5. **Muestra la ruta EXACTA y linea**
   - NO: "El modelo de clientes..."
   - SI: "src/models/Cliente.pas:12 — class TCliente"
