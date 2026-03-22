# /rollback — Rollback a deploy

Revierte un deploy problemático en producción o desarrollo.

## Uso
```
/rollback prod        → Rollback de producción
/rollback dev         → Rollback de desarrollo
/rollback db          → Rollback de migración de BD
```

## Instrucciones

### Rollback producción

1. **Verificar** que realmente hay un problema:
   ```bash
   # Health check del API (leer URL de CLAUDE.md)
   curl -s {PROD_API_URL}/health
   ```

2. **Revertir deploy**:
   - **Platform-based** (Coolify/Railway/Vercel/Fly): redeploy del commit anterior desde el dashboard
   - **Git-based**: revertir el merge en main
   ```bash
   git checkout main && git revert HEAD --no-edit && git push origin main
   ```

3. **Verificar** que el rollback funcionó:
   - Health check pasa
   - Frontend carga correctamente

### Rollback desarrollo

```bash
git checkout development
git revert HEAD --no-edit
git push origin development
```

### Rollback migración de BD

```
⚠️ NUNCA hacer migrate reset en producción.
```

1. Crear migración inversa manualmente
2. Ejecutar en la base de datos de producción con cuidado
3. Marcar como resuelta en el ORM si es necesario

### Post-rollback checklist
- [ ] Health check pasa
- [ ] Login/auth funciona
- [ ] Flujo principal funciona
- [ ] Crear issue con el problema que causó el rollback
- [ ] Notificar al equipo
- [ ] Documentar en postmortem si afectó usuarios
