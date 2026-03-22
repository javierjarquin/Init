# /hotfix — Emergency hotfix workflow

Workflow de emergencia para bugs críticos en producción. Bypassa development y va directo a main.

## Uso
```
/hotfix "descripción del bug"    → Crear hotfix branch y aplicar fix
```

## Instrucciones

1. **Crear branch desde main** (NO desde development):
   ```bash
   git checkout main && git pull
   git checkout -b hotfix/{slug}
   ```

2. **Diagnosticar**:
   - Leer logs de error (Sentry, server logs)
   - Identificar el archivo y línea del problema
   - Verificar si hay un commit reciente que lo causó

3. **Implementar fix mínimo**:
   - SOLO corregir el bug — nada más
   - NO refactorizar, NO mejorar, NO limpiar
   - El fix debe ser lo más pequeño y seguro posible

4. **Verificar**:
   - Unit tests pasan
   - Build compila
   - Reproducir el bug manualmente si es posible

5. **PR directo a main**:
   ```bash
   git push -u origin hotfix/{slug}
   gh pr create --base main --title "hotfix: {descripción}" --body "..."
   ```

6. **Post-merge**:
   - Verificar deploy y health check
   - Cherry-pick a development:
     ```bash
     git checkout development
     git cherry-pick {commit-hash}
     git push origin development
     ```
   - Crear issue para investigación root cause (si no es obvio)
   - Considerar si necesita postmortem (`docs/postmortems/`)

## ⚠️ Reglas
- Solo usar para bugs que afectan producción AHORA
- Siempre pedir confirmación antes de merge a main
- Siempre cherry-pick a development después
