---
name: ship-it
description: Pre-flight completo antes de commit/push/deploy — lint, typecheck, tests, build, security scan, commit bien formado. Usa antes de cerrar tarea o crear PR.
---

# Skill: Ship It

Checklist de "listo para mergear" que NO se salta. Es barato correrlo, caro saltarselo.

## Cuando activar

- "ya termine, haz commit"
- "esto ya esta, sube el PR"
- "deploy a dev"
- Antes de cualquier `git push`

## Secuencia obligatoria

### 1. Estado del repo
```bash
git status
git diff --stat
```
- Todo lo que deberia estar cambiado esta cambiado?
- Hay archivos que NO deberian estar en el commit (.env, logs, secretos)?

### 2. Lint
```bash
pnpm lint
```
Si falla: arreglar (no `--fix` automatico en cambios grandes — revisar cada uno).

### 3. Type check
```bash
pnpm exec tsc --noEmit
```
Si falla: arreglar. Nunca `// @ts-ignore` sin comentario explicando por que.

### 4. Tests unit
```bash
pnpm test
```
Si falla: arreglar o reportar al usuario si el bug es preexistente.

### 5. Tests E2E (si aplicaron cambios de UI o flujos)
```bash
pnpm test:e2e
```
Si solo hubo cambios de backend/infra, saltar y decirlo al usuario.

### 6. Build
```bash
pnpm build
```
Catch errores que no aparecen en dev.

### 7. Security quick scan
```bash
# Secrets en el diff
git diff | grep -iE 'password|secret|api[_-]?key|token' | grep -v test

# Deps vulnerables
pnpm audit --audit-level high
```

### 8. Revisar diff final
```bash
git diff --staged
```
- Cada cambio tiene razon de estar ahi?
- Hay `console.log` olvidados?
- Hay TODOs sin issue asociado?
- Hay codigo comentado sin razon?

### 9. Commit message

Formato obligatorio:
```
<type>: <resumen en 50 chars, imperativo>

<body explicando POR QUE, no QUE — el diff ya muestra el que>

[Refs: #123]
```

Types: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, `perf`, `ci`.

Regla: **nunca** commit genericos como "updates", "fixes", "wip".

### 10. Stage explicito
```bash
git add src/modules/x/...  # archivos especificos
# NO: git add -A o git add .
```

### 11. Commit
```bash
git commit  # usar editor si el mensaje es largo
```

Si hay pre-commit hook que falla: NO usar `--no-verify`. Arreglar la causa.

### 12. Push

```bash
git push origin feature/x
```
- NUNCA push --force a main/master
- Push --force-with-lease si necesitas force en rama propia

### 13. PR (si aplica)

Usar template del proyecto. Llenar:
- **Resumen:** que cambia y por que
- **Test plan:** que validar manualmente
- **Screenshots:** si hay UI
- **Breaking changes:** si los hay
- **Closes #X** si cierra issue

## Red flags que ABORTAN el ship

- 🚫 Tests fallando
- 🚫 Types fallando
- 🚫 Secretos en el diff
- 🚫 Archivos `.env` staged
- 🚫 Migraciones destructivas sin backup confirmado
- 🚫 `any` nuevo sin justificar
- 🚫 Commits WIP mezclados
- 🚫 TODO:FIXME sin issue
- 🚫 Tests `.skip` / `.only` olvidados

## Para deploy a prod

Si esto es merge a `main` / deploy a prod, agregar:

- [ ] PR revisado por alguien mas (o solo flag)
- [ ] Tests E2E contra staging pasaron
- [ ] Backup de DB reciente confirmado
- [ ] Rollback plan documentado
- [ ] Feature flag disponible si es risky
- [ ] Monitoreo listo para observar post-deploy

## Delegacion

- Security scan detallado: `@security-auditor`
- Performance check: `@performance-profiler`
- Code review: `@reviewer`
