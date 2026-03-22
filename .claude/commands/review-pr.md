# /review-pr — Review a Pull Request

Revisa un PR como lo haría un senior developer: seguridad, performance, convenciones y lógica.

## Uso
```
/review-pr 90         → Revisar PR #90
/review-pr            → Revisar el PR de la branch actual
```

## Instrucciones

1. **Obtener el diff**:
   ```
   gh pr diff {number}
   ```
   O si no se da número: `gh pr view --json number` de la branch actual.

2. **Revisar en 5 dimensiones**:

   ### Seguridad
   - SQL injection (queries sin parametrizar)
   - XSS (inputs no sanitizados en frontend)
   - Secrets hardcodeados
   - RBAC bypass (endpoints sin protección de roles)
   - Datos sensibles expuestos en logs o responses

   ### Performance
   - N+1 queries
   - Queries sin índice
   - Loops con await (debería ser Promise.all)
   - Payloads grandes sin paginación
   - Missing cache donde aplica

   ### Convenciones del proyecto
   - Convenciones definidas en CLAUDE.md
   - Commit messages siguen conventional commits
   - Error handling consistente
   - Tests para código nuevo

   ### Lógica de negocio
   - ¿El cambio hace lo que dice que hace?
   - ¿Hay edge cases no cubiertos?
   - ¿Se rompe algún flujo existente?

   ### Calidad de código
   - Nombres descriptivos
   - Sin código muerto
   - Sin console.log en producción
   - Error handling adecuado
   - DRY — sin duplicación innecesaria

3. **Generar reporte**:
   - ✅ Approved / ⚠️ Changes Requested / ❌ Blocked
   - Lista de hallazgos por categoría con severidad
   - Sugerencias concretas con archivo y línea

4. **Opcionalmente** comentar en GitHub:
   ```
   gh pr review {number} --approve --body "mensaje"
   gh pr review {number} --request-changes --body "mensaje"
   ```
