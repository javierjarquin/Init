# /deploy-dev — Deploy to development environment

Prepara y despliega los cambios al entorno de desarrollo remoto.

## Uso
```
/deploy-dev              → Commit + push + PR a development
/deploy-dev --skip-tests → Sin correr tests antes
```

## Instrucciones

1. **Pre-checks**:
   - `git status` para ver cambios pendientes
   - Correr unit tests (a menos que se use `--skip-tests`)
   - Si hay E2E specs modificados, correr esos specs

2. **Commit**:
   - `git add` solo archivos relevantes (no binarios, reportes ni archivos basura)
   - Commit message según convención del proyecto (conventional commits)
   - NO incluir archivos sensibles (.env, credentials, etc.)

3. **Push + PR**:
   - `git push -u origin {BRANCH}`
   - `gh pr create --base development` con resumen de cambios
   - Mostrar URL del PR

4. **Verificar deploy** (si hay health check configurado):
   - Verificar health endpoint del entorno dev
   - Si falla, revisar si el lockfile está actualizado

## URLs dev
> Configurar en CLAUDE.md → sección URLs
