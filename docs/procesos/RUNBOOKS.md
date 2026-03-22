# Runbooks Operacionales

> Guías paso a paso para resolver problemas operacionales comunes.
> Adaptar los comandos y URLs a tu proyecto específico.

---

## RB-01: La API no responde (502/503)

### Síntomas
- Health check falla
- Frontend muestra errores de conexión

### Diagnóstico
```bash
# 1. Verificar si la API está corriendo
curl -v {API_URL}/health

# 2. Verificar logs del servidor
# (adaptar según plataforma: Railway, Coolify, Fly, etc.)

# 3. Verificar recursos (CPU, RAM, Disk)
```

### Resolución
1. **Falta de memoria:** Reiniciar el servicio/container
2. **Crash loop:** Verificar logs, buscar el error, aplicar `/hotfix`
3. **Servidor no responde:** Verificar la plataforma de hosting

---

## RB-02: Base de datos lenta o inaccesible

### Síntomas
- API responde lento (> 5s)
- Timeouts en queries

### Diagnóstico
1. Verificar conexiones activas
2. Buscar queries lentas
3. Verificar espacio en disco

### Resolución
1. **Muchas conexiones:** Verificar connection pooling, posible leak
2. **Query lenta:** Identificar query, agregar índice
3. **Disco lleno:** Limpiar datos antiguos (logs, audit), vacuum

---

## RB-03: Cache/Redis caído

### Síntomas
- Health check muestra cache desconectado
- Jobs en cola no se procesan

### Resolución
1. La app debería seguir funcionando (graceful degradation)
2. Reiniciar el servicio de cache
3. Los jobs pendientes se procesan cuando vuelve
4. Si no arranca: verificar memoria del servidor

---

## RB-04: Migración de BD falla

### Síntomas
- Deploy falla en el paso de migración
- Error de columna/tabla/tipo incompatible

### Diagnóstico
1. Verificar estado de migraciones
2. Leer el SQL de la migración fallida

### Resolución
1. **NUNCA** hacer reset de migraciones en producción
2. Crear nueva migración que corrija el problema
3. Si hay datos corruptos: restaurar backup
4. Marcar migración como aplicada si fue manual

---

## RB-05: Servicio externo caído (pagos, email, etc.)

### Síntomas
- Feature específica no funciona
- Errores de timeout hacia servicio externo

### Diagnóstico
1. Verificar status page del proveedor
2. Verificar si los tokens/API keys siguen válidos
3. Verificar rate limits

### Resolución
1. Si es caída del proveedor: esperar, los jobs se encolan
2. Si es token expirado: renovar, actualizar env var, redeploy
3. Si es rate limit: implementar backoff o reducir frecuencia

---

## RB-06: Deploy falla

### Síntomas
- Build falla en CI/CD
- Container/servicio no arranca después del deploy

### Diagnóstico
1. Verificar logs del build
2. Verificar que `build` funciona localmente

### Resolución
1. **Build falla:** Error de compilación, dependencia faltante
2. **No arranca:** Verificar env vars, posible variable faltante
3. **Puerto ocupado:** Verificar procesos zombie

---

## RB-07: Rollback de deploy

### Cuándo hacer rollback
- Deploy causa errores 500 en producción
- Feature nueva rompe un flujo existente
- Regresión detectada post-deploy

### Procedimiento
1. Usar `/rollback prod` o `/rollback dev`
2. Verificar health check post-rollback
3. Crear issue con el problema
4. Documentar en postmortem si afectó usuarios

---

## RB-08: Problema de seguridad detectado

### Síntomas
- Alerta de vulnerabilidad en dependencias
- Datos expuestos
- Acceso no autorizado detectado

### Resolución
1. **Evaluar impacto**: ¿datos comprometidos? ¿acceso ganado?
2. **Contener**: Revocar tokens/keys si es necesario
3. **Corregir**: Aplicar `/hotfix` o `/security-scan`
4. **Comunicar**: Notificar al equipo y stakeholders
5. **Postmortem**: Obligatorio para cualquier brecha de datos

---

## Checklist general post-incidente
- [ ] Health check pasa
- [ ] Flujo principal funciona (login → feature principal)
- [ ] Crear issue con el problema
- [ ] Notificar al equipo
- [ ] Documentar en postmortem si aplica
- [ ] Crear test de regresión
