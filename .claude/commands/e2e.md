# /e2e — E2E test management

Ejecuta, crea o depura tests end-to-end.

## Uso
```
/e2e run                    → Correr todos los E2E tests
/e2e run {spec}             → Correr un spec específico
/e2e create {flow}          → Crear nuevo E2E test para un flujo
/e2e debug {spec}           → Correr en modo debug (headed, slowMo)
/e2e report                 → Abrir el último reporte HTML
```

## Instrucciones

### /e2e run
1. Verificar que los servicios necesarios están corriendo (API, DB, frontend)
2. Ejecutar con el framework E2E del proyecto (Playwright, Cypress, etc.)
3. Usar `--workers=1` para evitar flakiness
4. Mostrar resultados en tabla:
   | Spec | Tests | Passed | Failed | Duration |
   |------|-------|--------|--------|----------|

### /e2e create {flow}
1. **Analizar el flujo** a testear:
   - ¿Qué páginas/endpoints involucra?
   - ¿Qué datos necesita? (fixtures/seed)
   - ¿Qué rol de usuario?

2. **Crear spec** siguiendo patrones existentes:
   - Login/auth si es necesario
   - Setup de datos (fixtures)
   - Acciones del usuario paso a paso
   - Assertions en cada paso importante
   - Cleanup si es necesario

3. **Mejores prácticas**:
   - Selectores estables (data-testid, roles ARIA) — NUNCA CSS frágil
   - Esperar por elementos/network, no por tiempo
   - Cada test independiente (no depender de orden)
   - Screenshots en fallos automáticos

4. **Ejecutar** el nuevo spec para verificar que pasa

### /e2e debug
1. Ejecutar en modo headed (navegador visible)
2. Con slowMo para ver cada paso
3. Pausar en el primer fallo
4. Mostrar selector playground si está disponible
