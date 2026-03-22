# /perf — Performance analysis

Analiza y optimiza el rendimiento del proyecto.

## Uso
```
/perf api                → Analizar performance del backend
/perf web                → Analizar performance del frontend
/perf db                 → Analizar queries lentas
/perf bundle             → Analizar tamaño del bundle
```

## Instrucciones

### /perf api
1. **Buscar problemas comunes**:
   - N+1 queries (loops con queries individuales)
   - Queries sin paginación que retornan todos los registros
   - Endpoints sin cache que deberían tenerlo
   - Operaciones síncronas que deberían ser async/background jobs
   - Serialización innecesaria de datos grandes

2. **Generar reporte**:
   | Endpoint | Problema | Impacto | Sugerencia |
   |----------|----------|---------|------------|

### /perf web
1. **Buscar problemas comunes**:
   - Componentes que re-renderizan innecesariamente
   - Imágenes sin optimizar (sin lazy loading, sin next/image)
   - Bundles innecesarios importados en el client
   - Falta de memoización en cálculos pesados
   - API calls duplicadas (sin cache/dedup)

2. **Verificar Lighthouse patterns**:
   - ¿Se usa `dynamic()` / lazy loading para rutas pesadas?
   - ¿Los componentes pesados son server components?
   - ¿Las fuentes están optimizadas?

### /perf db
1. **Analizar schema**:
   - Tablas sin índices en columnas frecuentemente consultadas
   - Índices faltantes en foreign keys
   - Queries con full table scan
   - JOINs innecesarios

2. **Buscar en código**:
   - Queries raw sin `EXPLAIN ANALYZE`
   - Transacciones demasiado largas
   - Conexiones no liberadas

### /perf bundle
1. **Analizar tamaño del bundle**:
   ```bash
   # Next.js
   npx @next/bundle-analyzer

   # Generic
   npx source-map-explorer dist/**/*.js
   ```
2. Identificar dependencias pesadas que podrían reemplazarse
3. Sugerir code splitting donde aplique
