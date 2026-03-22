# /test-unit — Run or create unit tests

Ejecuta unit tests existentes o crea nuevos para un módulo.

## Uso
```
/test-unit                        → Correr todos los unit tests
/test-unit {module}               → Correr tests de un módulo
/test-unit create {module}        → Crear spec para el módulo
/test-unit coverage               → Correr con coverage report
```

## Instrucciones

### Correr tests
```bash
# Leer CLAUDE.md para obtener el comando exacto de tests del proyecto.
# Ejemplos comunes:
# npm test
# pnpm test
# pytest
# go test ./...
```

- Si se indica un módulo: filtrar por nombre
- Si se indica coverage: usar el flag de coverage del test runner

### Crear tests
Si el argumento es "create {módulo}":

1. **Leer** el archivo/service/module a testear
2. **Identificar** dependencias (DB, cache, APIs externas, etc.)
3. **Crear** spec siguiendo los patrones de tests existentes en el proyecto:
   - Buscar tests existentes como referencia
   - Mockear dependencias externas
   - Un `describe` por método/función pública
   - Tests para: happy path, validación, errores, edge cases

4. **Ejecutar** el nuevo spec para verificar que pasa
5. **Si falla**, ajustar mocks hasta que pase

### Principios
- Cada test debe ser independiente (no depender de orden)
- Nombres descriptivos: "should return X when Y"
- No testear implementación interna, testear comportamiento
- Mockear solo lo necesario (boundaries: DB, APIs, filesystem)
