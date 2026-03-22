# Incident Response

## Niveles de severidad

| Nivel | Descripción | Ejemplo | Tiempo de respuesta |
|-------|-------------|---------|---------------------|
| **SEV-1** | Plataforma caída, todos los usuarios afectados | API no responde, BD inaccesible | < 15 min |
| **SEV-2** | Funcionalidad crítica rota para algunos usuarios | Pagos no procesan, login falla | < 1 hora |
| **SEV-3** | Funcionalidad secundaria degradada | Reportes lentos, notificaciones retrasadas | < 4 horas |
| **SEV-4** | Bug menor, workaround disponible | UI desalineada, texto incorrecto | Siguiente sprint |

## Proceso de respuesta

### 1. Detección
- Alerta de monitoreo (Sentry, uptime monitor)
- Reporte de usuario
- Fallo en health check post-deploy

### 2. Triaje (primeros 5 minutos)
- [ ] **Identificar severidad** (SEV-1 a SEV-4)
- [ ] **Verificar alcance:** ¿cuántos usuarios afectados?
- [ ] **Verificar si hay deploy reciente** (`git log --oneline -5` en main)
- [ ] **Health checks:** verificar API, BD, cache, servicios externos

### 3. Contención (SEV-1/SEV-2)
- **Si fue un deploy reciente:** rollback inmediato (ver `/rollback`)
- **Si es BD:** verificar conexiones, locks, espacio en disco
- **Si es cache/Redis:** la app debería degradar gracefully
- **Si es servicio externo:** verificar status page del proveedor

### 4. Investigación
- Verificar logs de error (Sentry, server logs)
- Buscar errores recientes, stack traces
- Verificar métricas de la BD (conexiones, queries lentas)

### 5. Resolución
- Aplicar fix (hotfix branch si es SEV-1/SEV-2)
- Verificar que el fix resuelve el problema
- Monitorear por 30 minutos después del fix

### 6. Postmortem (obligatorio para SEV-1 y SEV-2)

Crear documento en `docs/postmortems/YYYY-MM-DD-titulo.md`:

```markdown
# Postmortem: [Título del incidente]

## Resumen
- **Fecha:** YYYY-MM-DD
- **Duración:** X horas/minutos
- **Severidad:** SEV-X
- **Impacto:** X usuarios afectados

## Timeline
- HH:MM — Se detectó [qué]
- HH:MM — Se identificó [causa]
- HH:MM — Se aplicó [fix]
- HH:MM — Se verificó resolución

## Causa raíz
[Descripción técnica]

## Qué funcionó bien
- [Qué ayudó a resolver rápido]

## Qué salió mal
- [Qué empeoró o retrasó]

## Action items
- [ ] [Acción preventiva] — responsable — fecha límite

## Lecciones aprendidas
[Qué cambiar para que no vuelva a pasar]
```

## Prevención

- Health checks automáticos
- Alertas de monitoreo para nuevos errores
- Rate limiting para picos de tráfico
- Backups automáticos de BD
- Graceful degradation cuando servicios externos caen
