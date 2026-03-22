# /status — Project status dashboard

Muestra el estado actual del proyecto: servidores, tests, deploys, PRs abiertos.

## Instrucciones

Ejecutar en paralelo y mostrar tabla resumen:

1. **Servidores** (leer URLs de CLAUDE.md):
   - Local API: health check
   - Local Web: HTTP status
   - Dev API: health check
   - Dev Web: HTTP status
   - Prod API: health check
   - Prod Web: HTTP status

2. **Git**:
   - Branch actual
   - Commits ahead/behind de development y main
   - Archivos modificados sin commit

3. **PRs abiertos**:
   ```bash
   gh pr list --state open
   ```

4. **Issues abiertos** (top 5 por prioridad):
   ```bash
   gh issue list --state open --limit 5
   ```

5. **Último deploy**:
   ```bash
   git log main --oneline -1
   ```

6. **Mostrar todo en una tabla limpia**:
   ```
   ┌─────────────┬──────────┐
   │ Servicio     │ Estado   │
   ├─────────────┼──────────┤
   │ Local API    │ ✅ / ❌  │
   │ Prod API     │ ✅ / ❌  │
   │ ...          │ ...      │
   └─────────────┴──────────┘
   ```
