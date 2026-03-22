# /debug — Debug assistance

Asistente de debugging para resolver errores y problemas.

## Uso
```
/debug "error message"        → Diagnosticar un error
/debug {file}:{line}          → Analizar un punto problemático
/debug logs                   → Analizar logs recientes
/debug trace {endpoint}       → Trazar un request completo
```

## Instrucciones

### /debug "error message"
1. **Buscar el error** en el codebase:
   ```bash
   # Buscar el string de error
   grep -rn "error message" --include="*.ts" --include="*.tsx" --include="*.js"
   ```

2. **Analizar contexto**:
   - ¿Es un error de runtime o compilación?
   - ¿Es consistente o intermitente?
   - ¿Empezó después de un cambio reciente? (`git log --oneline -10`)

3. **Diagnosticar causa raíz**:
   - Leer el stack trace completo
   - Seguir el flujo de datos hasta el punto de fallo
   - Identificar la condición que causa el error

4. **Proponer solución**:
   - Mostrar el fix sugerido con diff
   - Explicar por qué ocurre el error
   - Si hay varios fixes posibles, listar pros/contras

### /debug trace {endpoint}
1. **Seguir el request completo**:
   - Route/Controller que lo recibe
   - Middleware que se ejecuta
   - Service(s) que procesa
   - Queries a DB
   - Response que retorna

2. **Generar diagrama de flujo** (Mermaid):
   ```mermaid
   sequenceDiagram
   Client->>Controller: POST /endpoint
   Controller->>Service: method()
   Service->>DB: query
   DB-->>Service: result
   Service-->>Controller: response
   Controller-->>Client: 200 OK
   ```

### /debug logs
1. Leer logs recientes del servidor
2. Filtrar por errores (ERROR, WARN, FATAL)
3. Agrupar por tipo de error
4. Identificar el más frecuente o más reciente
