# /adr — Create Architecture Decision Record

Documenta una decisión arquitectónica importante.

## Uso
```
/adr "título de la decisión"    → Crear ADR con ese título
/adr list                       → Listar ADRs existentes
```

## Instrucciones

### Crear ADR

1. **Determinar número**: Buscar el último ADR en `docs/adr/` e incrementar
   ```bash
   ls docs/adr/ADR-*.md | tail -1
   ```

2. **Crear archivo** `docs/adr/ADR-{NNN}-{slug}.md` con formato:
   ```markdown
   # ADR-{NNN}: {Título}

   **Estado:** Aceptada | Propuesta | Deprecada | Reemplazada por ADR-XXX
   **Fecha:** YYYY-MM-DD
   **Autor:** {nombre}

   ## Contexto
   ¿Qué problema estamos resolviendo? ¿Qué restricciones tenemos?

   ## Decisión
   ¿Qué decidimos hacer y por qué?

   ## Alternativas consideradas
   | Opción | Pros | Contras |
   |--------|------|---------|

   ## Consecuencias
   - **Positivas:** ...
   - **Negativas:** ...
   - **Riesgos:** ...

   ## Referencias
   - Links a docs, PRs, issues relevantes
   ```

3. **Preguntar al usuario** si necesita más contexto para llenar alguna sección

### Listar ADRs
```bash
ls docs/adr/ADR-*.md
```
Mostrar tabla con: número, título, estado, fecha.
