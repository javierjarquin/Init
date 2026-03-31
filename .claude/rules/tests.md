---
globs: "*.test.ts,*.test.tsx,*.spec.ts,*.spec.tsx,*.test.js,*.spec.js"
---

# Reglas para archivos de test

- Usa `describe` + `it` para estructurar los tests
- Nombres de test descriptivos en ingles: `it('should return 404 when user not found')`
- NO uses mocks de base de datos en tests de integracion — usa una BD real de test
- Cada test debe ser independiente: no depender del orden de ejecucion
- Limpia el estado en `beforeEach` o `afterEach`, no en el test mismo
- Agrupa tests por funcionalidad, no por metodo
- Para tests de API: verifica status code, body, y headers relevantes
- Para tests de UI: prefiere testing-library queries por role/text sobre selectores CSS
