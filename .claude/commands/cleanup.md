# /cleanup — Code cleanup

Limpieza de código: eliminar dead code, imports no usados, archivos huérfanos.

## Uso
```
/cleanup imports         → Limpiar imports no usados
/cleanup dead-code       → Detectar y eliminar código muerto
/cleanup files           → Encontrar archivos huérfanos (no importados)
/cleanup console         → Eliminar console.log/print de producción
/cleanup types           → Limpiar tipos 'any' y tipos no usados
/cleanup all             → Todo lo anterior
```

## Instrucciones

### /cleanup imports
1. Buscar imports no utilizados en cada archivo
2. Eliminarlos automáticamente
3. Verificar que compila después de cada archivo modificado

### /cleanup dead-code
1. Buscar funciones/métodos que no se llaman desde ningún lado
2. Buscar variables asignadas pero nunca leídas
3. Buscar archivos exportados pero nunca importados
4. **Presentar lista para aprobación** antes de eliminar
5. NO eliminar si:
   - Es un endpoint (podría llamarse externamente)
   - Es un hook de lifecycle del framework
   - Es un export público de un package

### /cleanup files
1. Listar todos los archivos `.ts`, `.tsx`, `.js`, `.jsx`
2. Verificar cuáles no son importados por nadie
3. Excluir: entry points, configs, scripts, tests
4. Presentar lista de archivos huérfanos

### /cleanup console
1. Buscar `console.log`, `console.warn`, `console.error`, `console.debug`
2. Excluir: archivos de test, scripts de build, logger service
3. Eliminar los que sean de debugging temporal
4. **Mantener** los que son parte del logger oficial

### /cleanup types
1. Buscar `: any` en el código
2. Proponer tipo correcto basado en el uso
3. Buscar interfaces/types definidos pero no usados
4. Presentar cambios para aprobación

## Reglas
- Siempre correr tests después de cleanup
- Commits separados por tipo de cleanup
- Si algo no es claro, preguntar antes de eliminar
