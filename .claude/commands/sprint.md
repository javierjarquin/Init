# /sprint — Sprint planning and management

Planifica un sprint ágil: priorizar issues, estimar y organizar el trabajo.

## Uso
```
/sprint plan              → Planificar nuevo sprint
/sprint status            → Ver progreso del sprint actual
/sprint close             → Cerrar sprint y generar retrospectiva
```

## Instrucciones

### /sprint plan

1. **Listar issues abiertos**:
   ```bash
   gh issue list --state open --limit 50 --json number,title,labels,assignees
   ```

2. **Priorizar** usando MoSCoW:
   - **Must** — Bloqueantes, bugs críticos, features comprometidas
   - **Should** — Mejoras importantes, deuda técnica riesgosa
   - **Could** — Nice-to-have, mejoras UX
   - **Won't** — Dejar para otro sprint

3. **Estimar** cada issue (T-shirt sizing):
   - **XS** — < 1 hora (fix trivial, config)
   - **S** — 1-4 horas (feature simple, fix medio)
   - **M** — 4-8 horas (feature media, refactor)
   - **L** — 1-2 días (feature compleja)
   - **XL** — 3-5 días (feature mayor, dividir si es posible)

4. **Presentar plan**:
   | Prioridad | Issue | Estimación | Asignado |
   |-----------|-------|------------|----------|

5. **Crear milestone** en GitHub:
   ```bash
   gh api repos/{owner}/{repo}/milestones -f title="Sprint X" -f due_on="YYYY-MM-DD"
   ```

### /sprint status

1. Listar issues del milestone actual
2. Mostrar progreso: abiertos / en progreso / cerrados
3. Mostrar burndown (issues cerrados por día)

### /sprint close

1. Listar issues completados vs pendientes
2. Mover issues pendientes al próximo sprint
3. Generar retrospectiva:
   - **Qué salió bien**
   - **Qué salió mal**
   - **Qué mejorar**
4. Cerrar el milestone en GitHub

## Duración sugerida
- Sprint de 1 semana para equipo pequeño (1-2 personas)
- Sprint de 2 semanas para equipo mediano (3-5 personas)
