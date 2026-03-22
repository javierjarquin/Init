# /qa — Run QA audit

Ejecuta auditoría QA del flujo o módulo indicado.

## Uso
```
/qa {flow}            → Auditoría de un flujo específico
/qa all               → Todos los flujos
/qa modules           → Solo los specs de módulos
```

## Instrucciones

1. **Verificar entorno**: Comprobar que los servicios necesarios (DB, cache, API, frontend) están corriendo. Si no, intentar levantarlos.

2. **Identificar specs**: Buscar archivos de test E2E en el proyecto.
   ```bash
   # Buscar specs de Playwright, Cypress, o el framework E2E del proyecto
   find . -name "*.spec.ts" -path "*/e2e/*" -o -name "*.spec.ts" -path "*/tests/*"
   ```

3. **Ejecutar tests según el argumento**:
   - Si es un flujo específico: ejecutar solo ese spec
   - Si es `all`: ejecutar todos secuencialmente
   - Si es `modules`: ejecutar los specs de módulos
   - Usar `--workers=1` para evitar race conditions

4. **Reportar resultados**:
   | Spec | Passed | Failed | Skipped |
   |------|--------|--------|---------|

   Si hay fallos, listar los test names y el error.

5. **Si hay fallos**: Preguntar si quiero que los corrija (usar `/fix-qa`) o solo documente.

## Config
- Siempre usar workers=1 para tests E2E (evitar flakiness)
- Timeout generoso para E2E (60s+ por test)
- Si la API no responde, reiniciar servicios primero
