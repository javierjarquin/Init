---
name: create-migration
description: Crea una migracion de base de datos segura con rollback, indices, constraints y validacion. Usa cuando el usuario pida "crea migracion para X" o "agrega columna Y".
---

# Skill: Create Migration (Safe)

Generar migraciones reversibles, idempotentes y sin downtime.

## Cuando activar

- "crea migracion para agregar tabla X"
- "agrega columna Y a tabla Z"
- "necesito indice en columna X"
- "quita la columna Y"

## Reglas inviolables

1. **NUNCA `db reset`** — siempre `db push` o migracion incremental
2. **NUNCA `DROP TABLE` sin backup confirmado**
3. **Siempre rollback** (`down()` o archivo `.rollback.sql`)
4. **Idempotente** — `CREATE TABLE IF NOT EXISTS`, `ADD COLUMN IF NOT EXISTS`
5. **No destructivo en tablas con datos** — usa el patron expand/contract

## Proceso

### 1. Entender el cambio

Antes de codear:
- Que tabla(s) afecta?
- Tiene datos en prod? (CRITICO para escoger estrategia)
- Hay codigo que depende del schema viejo?
- Downtime aceptable o zero-downtime?

### 2. Escoger patron

#### Caso A: Tabla nueva
Simple — `CREATE TABLE IF NOT EXISTS`.

#### Caso B: Agregar columna nullable
Simple — `ADD COLUMN x TYPE`.

#### Caso C: Agregar columna NOT NULL con datos existentes
Patron expand/contract:
```sql
-- Paso 1 (migracion N): ADD COLUMN nullable + DEFAULT
ALTER TABLE users ADD COLUMN status TEXT DEFAULT 'active';

-- Paso 2 (deploy N+1): codigo escribe en ambas
-- Backfill datos viejos
UPDATE users SET status = 'active' WHERE status IS NULL;

-- Paso 3 (migracion N+2): ADD NOT NULL constraint
ALTER TABLE users ALTER COLUMN status SET NOT NULL;
```

#### Caso D: Renombrar columna con trafico
```sql
-- Paso 1: ADD nueva columna
ALTER TABLE users ADD COLUMN email_new TEXT;
-- Copiar datos
UPDATE users SET email_new = email;
-- Codigo lee de ambas, escribe en ambas
-- Paso 2 (siguiente release): DROP columna vieja
ALTER TABLE users DROP COLUMN email;
ALTER TABLE users RENAME email_new TO email;
```

#### Caso E: Agregar indice
```sql
-- PostgreSQL: CONCURRENTLY para no bloquear
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_users_email ON users(email);
```

#### Caso F: Cambiar tipo de columna
Casi siempre requiere expand/contract. NUNCA `ALTER COLUMN TYPE` directo en tabla grande.

### 3. Generar con la herramienta del proyecto

**Drizzle:**
```bash
# Modificar schema.ts
pnpm drizzle-kit generate    # crea SQL incremental
# Revisar el SQL generado
pnpm drizzle-kit push        # aplica (dev) o via migrate en prod
```

**Prisma:**
```bash
# Modificar schema.prisma
pnpm prisma migrate dev --name descripcion
# Revisar SQL en prisma/migrations/
```

**Supabase CLI:**
```bash
npx supabase migration new descripcion
# editar el SQL
npx supabase db push
```

### 4. Validar

```bash
# Aplicar local
pnpm db:push  # o equivalente

# Regenerar tipos TS
pnpm db:generate  # drizzle-kit generate types
# o: npx supabase gen types typescript --local > src/types/database.ts

# Typecheck
pnpm exec tsc --noEmit

# Ejecutar tests
pnpm test
```

### 5. Plan de rollback

Siempre documentar:
```sql
-- rollback.sql
DROP INDEX IF EXISTS idx_users_email;
-- o
ALTER TABLE users DROP COLUMN status;
```

### 6. Checklist pre-commit

- [ ] Migracion corre limpia en DB vacia
- [ ] Migracion corre limpia en DB con datos
- [ ] Rollback funciona
- [ ] Types TS regenerados y commiteados
- [ ] Tests pasan
- [ ] Codigo nuevo NO rompe con schema viejo (si es expand/contract)

## Anti-patrones

- ❌ `DROP TABLE` en prod sin backup confirmado de las ultimas 24h
- ❌ `UPDATE` masivo sin WHERE o con transaccion larga
- ❌ Indice no CONCURRENTLY en tabla grande (bloquea writes)
- ❌ Migracion que asume version especifica del codigo
- ❌ Cambio de tipo directo en columna con muchos datos
- ❌ `NOT NULL` sin DEFAULT en columna nueva de tabla con datos

## Delegacion

- Diseno del cambio de schema: `@db-expert`
- Seguridad del cambio (acceso a datos): `@security-auditor`
