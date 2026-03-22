# /deps — Dependency management

Gestión segura de dependencias: actualizar, auditar, limpiar.

## Uso
```
/deps update             → Actualizar dependencias (minor + patch)
/deps update --major     → Incluir major updates (con análisis de breaking changes)
/deps audit              → Auditar vulnerabilidades
/deps unused             → Detectar dependencias no usadas
/deps why {package}      → Explicar por qué se usa un paquete
```

## Instrucciones

### /deps update
1. **Verificar estado actual**:
   ```bash
   # Node.js
   npx npm-check-updates --target minor

   # Python
   pip list --outdated
   ```

2. **Para cada actualización**, verificar:
   - ¿Es minor/patch? → Generalmente seguro
   - ¿Es major? → Leer changelog, buscar breaking changes
   - ¿Tiene vulnerabilidades conocidas? → Priorizar

3. **Aplicar actualizaciones** en lotes por riesgo:
   - Primero: patches de seguridad
   - Segundo: minor updates
   - Último: major updates (uno por uno)

4. **Después de cada lote**:
   - Correr tests
   - Verificar build
   - Si falla: revertir y reportar

5. **Commit**: `chore(deps): actualizar dependencias [lista]`

### /deps unused
1. Buscar imports/requires en el código
2. Comparar con package.json / requirements.txt
3. Listar dependencias que no se importan en ningún archivo
4. **NO eliminar automáticamente** — presentar lista para aprobación

### /deps why {package}
1. Buscar dónde se importa el paquete
2. Explicar para qué se usa
3. Si es transitiva: mostrar el dependency tree
