# /fix-qa — Fix a QA finding

Corrige un hallazgo de QA siguiendo el workflow de fix.

## Uso
```
/fix-qa {ID}           → Corregir hallazgo específico por ID
/fix-qa "descripción"  → Buscar y corregir por descripción
```

## Instrucciones

1. **Identificar el hallazgo**: Buscar en reportes QA, issues de GitHub, o docs de auditoría.

2. **Crear branch**: `fix/qa-{ID}` desde development
   ```bash
   git checkout development && git pull && git checkout -b fix/qa-{ID}
   ```

3. **Implementar fix**:
   - Leer el código afectado
   - Aplicar la corrección mínima necesaria
   - NO cambiar lógica de negocio a menos que sea el bug

4. **Verificar**:
   - Correr el test que detectó el fallo
   - Correr tests relacionados para asegurar no regresión
   - Si es fix de API, correr unit tests también

5. **Commit + PR**:
   - Commit: `fix({scope}): {descripción del fix}`
   - PR body: incluir ID del hallazgo, evidencia antes/después
   - Base: development

6. **Actualizar reporte**: Marcar el hallazgo como resuelto
