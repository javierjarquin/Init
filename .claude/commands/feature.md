# /feature — Scaffold a new feature

Crea una nueva feature siguiendo la arquitectura del proyecto.

## Uso
```
/feature "nombre-del-modulo"    → Scaffold completo (backend + frontend)
/feature api "nombre"           → Solo backend
/feature web "nombre"           → Solo frontend
```

## Instrucciones

1. **Crear branch**: `feat/{nombre}` desde development actualizado
   ```bash
   git checkout development && git pull && git checkout -b feat/{nombre}
   ```

2. **Leer CLAUDE.md** para entender la estructura y convenciones del proyecto.

3. **Scaffold backend** (si aplica):
   - Buscar módulos existentes como referencia (`ls` en la carpeta de módulos)
   - Crear: module, controller, service, DTOs, spec (test)
   - Registrar en el módulo principal
   - Seguir patrones de auth/guards existentes

4. **Scaffold frontend** (si aplica):
   - Crear page, error boundary
   - Agregar navegación (sidebar/menu)
   - Crear hooks para API calls
   - Seguir patrones de componentes existentes

5. **Validar**:
   - Unit tests pasan
   - Build compila sin errores
   - Lint sin errores

6. **Seguir convenciones de CLAUDE.md**:
   - DTOs validan toda entrada de usuario
   - Services contienen lógica de negocio
   - Controllers son thin (solo routing)
   - Commit message según convención del proyecto
