# /refactor — Analyze and refactor code

Analiza código existente y propone/aplica refactoring seguro.

## Uso
```
/refactor {path}               → Analizar módulo o archivo
/refactor "duplicated code"    → Buscar código duplicado en el proyecto
```

## Instrucciones

1. **Analizar** el código objetivo buscando:
   - Código duplicado (DRY violations)
   - Funciones > 50 líneas (dividir)
   - Complejidad ciclomática alta (simplificar)
   - Patrones inconsistentes con el resto del proyecto
   - Dead code (imports, funciones no usadas)
   - Type safety issues (any, missing types)

2. **Presentar plan ANTES de hacer cambios**:
   - Listar cada cambio propuesto con justificación
   - Estimar riesgo (bajo/medio/alto)
   - Esperar aprobación del usuario

3. **Aplicar** solo después de aprobación:
   - Crear branch: `refactor/{scope}`
   - Hacer cambios incrementales (un commit por cambio lógico)
   - Correr tests después de cada cambio
   - Si un test falla, revertir ese cambio

4. **Reglas**:
   - NUNCA cambiar lógica de negocio durante un refactor
   - NUNCA cambiar interfaces públicas (API endpoints, DTOs)
   - Mantener backwards compatibility
   - Si el refactor es grande, dividir en PRs pequeños
