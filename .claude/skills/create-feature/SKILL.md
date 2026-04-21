---
name: create-feature
description: Crea una feature end-to-end — schema DB, migracion, endpoint API con DTOs Zod, hook frontend, componente UI, tests. Usa cuando el usuario pida "agrega la feature de X" o "crea el modulo de X".
---

# Skill: Create Feature (End-to-End)

Flujo para crear una feature completa cruzando todas las capas del stack.

## Cuando activar

- "agrega la feature de clientes"
- "crea el modulo de citas"
- "necesito un CRUD de proveedores"
- "agrega endpoint para listar ordenes con filtros"

## Proceso

### 1. Confirmar alcance (obligatorio antes de codear)

Pregunta al usuario:
1. **Nombre del recurso** (singular + plural)
2. **Campos** principales (nombre, tipo, required)
3. **Relaciones** con otros recursos
4. **Operaciones**: solo CRUD o hay acciones custom?
5. **Permisos**: quien puede hacer que?
6. **Multi-tenant**: filtra por `company_id`?

### 2. Detectar stack del proyecto

Lee `CLAUDE.md` y `package.json` para confirmar:
- ORM (Drizzle / Prisma / otro)
- Framework API (NestJS / Next API routes / Express)
- Framework UI (Next.js / otro)
- Testing (Vitest / Jest)

### 3. Implementacion en orden

**Paso A — Schema DB** (`packages/db/schema/` o equivalente)
- Definir tabla con Drizzle/Prisma
- Incluir `company_id`, `created_at`, `updated_at`, UUID PK
- Indices en columnas de busqueda frecuente
- Relaciones con FK

**Paso B — Migracion**
- Generar con `drizzle-kit generate` o `prisma migrate dev`
- Revisar SQL generado antes de aplicar
- Aplicar con `db push` (nunca `db reset`)

**Paso C — Schemas Zod** (`packages/schemas/`)
- `CreateXSchema`, `UpdateXSchema` (partial), `XResponseSchema`
- Usar en frontend y backend

**Paso D — API endpoints** (`apps/api/src/modules/x/`)
- Module + Controller + Service + DTOs
- REST idiomatico (GET/POST/PATCH/DELETE)
- Validar con Zod pipe
- Filtrar por `company_id` (RLS + explicit)
- Paginar listas
- Tests unit del service

**Paso E — React Query hooks** (`apps/web/hooks/`)
- `useX()` — lista
- `useXById(id)` — detalle
- `useCreateX()` — mutation
- `useUpdateX()` — mutation
- `useDeleteX()` — mutation con confirmacion

**Paso F — UI** (`apps/web/app/...` o `components/features/x/`)
- Lista (tabla con paginacion, filtros, sort)
- Detalle (readonly + edit mode)
- Formulario create/edit (React Hook Form + Zod resolver)
- Delete con confirmacion
- Loading/empty/error states
- Labels y textos en espanol (si aplica)

**Paso G — Tests E2E** (`e2e/flows/x.spec.ts`)
- Flujo create → list → detail → edit → delete
- Con usuario de test adecuado al rol

### 4. Verificacion pre-commit

```bash
pnpm lint
pnpm exec tsc --noEmit
pnpm test
pnpm test:e2e
```

### 5. Commit estructurado

```
feat: agregar feature de {recurso}

- Schema + migracion en packages/db
- Endpoints CRUD en apps/api/src/modules/{recurso}
- Hooks React Query en apps/web/hooks
- UI completa en apps/web/app/{recurso}
- Tests unit + E2E del flujo completo
```

## Anti-patrones a evitar

- ❌ Saltar tests porque "es simple"
- ❌ No filtrar por tenant (RLS no es suficiente — siempre explicito)
- ❌ UI sin loading/empty/error states
- ❌ Endpoints sin DTOs
- ❌ Migracion con `DROP` sin rollback
- ❌ Feature en un solo commit gigante — mejor 3-5 commits por capa

## Delegacion a subagentes

- Schema/migracion: `@db-expert`
- API design: `@api-architect`
- UI review: `@frontend-reviewer`
- Seguridad: `@security-auditor` (si maneja datos sensibles)
- E2E tests: `@e2e-runner`
