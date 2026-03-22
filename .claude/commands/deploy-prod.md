# /deploy-prod — Deploy to production

Merge a main y verifica deploy en producción. **REQUIERE CONFIRMACIÓN EXPLÍCITA.**

## Uso
```
/deploy-prod          → Merge development → main + verificar
```

## Instrucciones

1. **Pre-checks obligatorios** (TODOS deben pasar):
   - [ ] Unit tests pasan
   - [ ] E2E tests pasan (al menos los críticos)
   - [ ] Build compila sin errores
   - [ ] No hay PRs pendientes críticos
   - [ ] Branch development está actualizada

2. **PEDIR CONFIRMACIÓN** al usuario:
   > "Voy a mergear development → main. Esto desplegará a producción.
   > - X commits pendientes
   > - Cambios: [resumen]
   > ¿Confirmas?"

3. **Merge** (solo después de confirmación):
   ```bash
   git checkout main && git pull
   git merge development --no-ff -m "release: merge development → main"
   git push origin main
   ```

4. **Verificar deploy** (esperar ~3 min):
   - Health check del API
   - Verificar que el frontend carga
   - Si falla: ALERTAR inmediatamente y sugerir `/rollback`

5. **Post-deploy**:
   - Crear GitHub Release con tag semver
   - Generar changelog con `/changelog`

## URLs producción
> Configurar en CLAUDE.md → sección URLs
