---
name: add-endpoint
description: Agrega un endpoint REST a un modulo existente con DTO Zod, guard de auth, validacion, tests unit. Usa cuando pidan "agrega endpoint para X" sin tocar el resto del modulo.
---

# Skill: Add Endpoint

Crear un endpoint aislado en un modulo existente. Mas chico que `create-feature` (no toca DB ni UI).

## Cuando activar

- "agrega endpoint GET /orders/:id/summary"
- "necesito un POST /users/:id/reset-password"
- "crea el endpoint para exportar facturas a CSV"

## Cuando NO activar

- Si requiere tabla nueva → usa `create-feature`
- Si requiere UI → usa `create-feature`
- Si es un CRUD completo → usa `create-feature`

## Proceso

### 1. Clarificar con el usuario

- **Metodo HTTP** y path (sigue convencion REST del proyecto)
- **Input:** query params, path params, body
- **Output:** estructura exacta
- **Auth:** publico / user / rol especifico
- **Side effects:** solo lectura / escribe / dispara notificacion
- **Rate limit:** aplica?

### 2. Ubicar el modulo

Lee el modulo destino (`apps/api/src/modules/x/`) y detecta:
- Framework (NestJS Controller / Next API route / Express router)
- Patron de DTOs (Zod / class-validator)
- Patron de guards (Passport / custom)
- Como se registran rutas

### 3. Implementar

**Paso A — DTO en `packages/schemas/`** (o equivalente)
```ts
export const EndpointInputSchema = z.object({ ... });
export const EndpointOutputSchema = z.object({ ... });
export type EndpointInput = z.infer<typeof EndpointInputSchema>;
```

**Paso B — Controller/Handler**
```ts
// NestJS ejemplo
@Post(':id/action')
@UseGuards(AuthGuard, RoleGuard)
@Roles('admin')
async action(
  @Param('id') id: string,
  @Body(new ZodValidationPipe(EndpointInputSchema)) body: EndpointInput,
  @CurrentUser() user: User,
): Promise<EndpointOutput> {
  return this.service.action(id, body, user);
}
```

**Paso C — Service**
- Logica de negocio aqui, NO en controller
- Filtrar por `company_id` / tenant
- Transacciones con `withTransaction()` si hay multiples writes
- Tirar errores tipados (no strings)

**Paso D — Tests unit**
```ts
describe('XService.action', () => {
  it('deberia hacer X cuando Y', async () => { ... });
  it('deberia fallar con 403 si rol incorrecto', async () => { ... });
  it('deberia fallar con 404 si no existe', async () => { ... });
  it('deberia ser idempotente', async () => { ... });  // si aplica
});
```

**Paso E — Registrar ruta**
- Asegurar que el controller esta en el `module.ts`
- Si hay OpenAPI/Swagger, agregar tags + ejemplos

**Paso F — Hook en frontend (opcional)**
Solo si el usuario lo pide. Si no, queda el endpoint listo para consumir.

### 4. Verificar

```bash
pnpm lint
pnpm exec tsc --noEmit
pnpm test -- --grep "x.service"

# Probar manual
curl -X POST http://localhost:3001/api/v1/... \
  -H "Authorization: Bearer $TOKEN" \
  -d '{...}'
```

### 5. Commit

```
feat(api): agregar endpoint POST /x/:id/action

- DTO Zod en packages/schemas
- Handler con guards de auth + rol
- Tests unit cubriendo happy path + 403 + 404
```

## Checklist

- [ ] DTO input validado con Zod
- [ ] DTO output tipado
- [ ] Guards de auth aplicados
- [ ] Filtro multi-tenant (`company_id`)
- [ ] Tests: happy path + auth fail + not found + validacion fail
- [ ] Error responses estructuradas `{ error: { code, message } }`
- [ ] OpenAPI actualizado (si aplica)
- [ ] Rate limit si es endpoint publico/costoso

## Anti-patrones

- ❌ Logica de negocio en controller
- ❌ Raw SQL sin parametrizar
- ❌ Devolver campos sensibles (password, hash, tokens)
- ❌ Trust del rol via body (validar desde JWT siempre)
- ❌ No paginar listas
