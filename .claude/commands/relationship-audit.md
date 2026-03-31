# /relationship-audit — Auditoria de relaciones entre tablas

Analiza la integridad referencial del sistema: foreign keys, registros huerfanos, dependencias circulares, impacto de cascadas y validacion en capa de servicios.

## Uso
```
/relationship-audit all              → Auditoria completa de todas las relaciones
/relationship-audit orphans          → Solo detectar registros huerfanos
/relationship-audit fk-coverage      → Validar cobertura de foreign keys
/relationship-audit cascade          → Analisis de impacto de cascadas
/relationship-audit service-layer    → Validar checks de FK en servicios
/relationship-audit report           → Genera reporte en docs/audit/
```

## Instrucciones

### Paso 1: Detectar el motor de base de datos

Lee CLAUDE.md para identificar el motor. Adapta las queries segun:

| Motor | Catalogo de FKs | Herramienta CLI |
|-------|----------------|-----------------|
| PostgreSQL/Supabase | `information_schema.table_constraints` + `referential_constraints` | `psql` / `supabase db query` |
| MySQL/MariaDB | `information_schema.KEY_COLUMN_USAGE` + `REFERENTIAL_CONSTRAINTS` | `mysql` |
| Oracle | `USER_CONSTRAINTS` + `USER_CONS_COLUMNS` | `sqlplus` |
| SQL Server | `sys.foreign_keys` + `sys.foreign_key_columns` | `sqlcmd` |
| SQLite | `PRAGMA foreign_key_list(tabla)` | `sqlite3` |
| Firebird | `RDB$RELATION_CONSTRAINTS` + `RDB$REF_CONSTRAINTS` | `isql` |

### Paso 2: Inventario de foreign keys

Genera la query apropiada para listar TODAS las FKs del schema del proyecto. Presenta como tabla:

```
| Tabla hija | Columna FK | Tabla padre | ON DELETE | ON UPDATE | Estado |
```

### Paso 3: Detectar columnas `*_id` sin FK

Busca todas las columnas que terminan en `_id` (excluyendo `id` y `tenant_id`) que NO tienen foreign key constraint. Estas son relaciones implicitas sin proteccion.

### Paso 4: Detectar registros huerfanos

Para cada FK encontrada, ejecuta un LEFT JOIN para detectar registros hijos que apuntan a padres inexistentes:

```sql
-- Patron generico (adaptar nombres)
SELECT hijo.id, hijo.[fk_column]
FROM [tabla_hija] hijo
LEFT JOIN [tabla_padre] padre ON hijo.[fk_column] = padre.id
WHERE hijo.[fk_column] IS NOT NULL AND padre.id IS NULL
LIMIT 50;
```

Cualquier resultado > 0 filas es un problema.

### Paso 5: Analisis de cascadas peligrosas

Identifica FKs con `ON DELETE CASCADE` en tablas criticas (pagos, facturas, historial). Estas pueden borrar datos financieros en cascada.

Regla: tablas con datos financieros o de auditoria deben usar `RESTRICT` o `SET NULL`, nunca `CASCADE`.

### Paso 6: Grafo de dependencias

Genera un grafo de niveles de dependencia:

```
Nivel 0: Tablas sin FK (tablas maestras)
Nivel 1: Tablas que solo dependen de nivel 0
Nivel 2: Tablas que dependen de nivel 0-1
...
```

Uso: el orden inverso es el orden seguro para DELETE. El orden directo es seguro para INSERT/migracion.

### Paso 7: Validacion en capa de servicios

Para cada servicio con metodos `create*()` o `insert*()`, verificar que se valida la existencia de entidades referenciadas ANTES del INSERT.

Buscar con grep:
- Funciones create/insert en servicios
- Verificar si hacen SELECT/findOne/exists antes del INSERT
- Si no validan, marcar como gap

### Paso 8: Consistencia multi-tenant (si aplica)

Si el proyecto usa `tenant_id` o schema por tenant, verificar que registros hijos y padres pertenecen al mismo tenant:

```sql
-- Patron generico
SELECT COUNT(*) AS mismatches
FROM [tabla_hija] h
JOIN [tabla_padre] p ON h.[fk_column] = p.id
WHERE h.tenant_id != p.tenant_id;
-- Resultado esperado: 0
```

## Formato de salida

```markdown
# Reporte de Relaciones — [fecha]

## Resumen
- X foreign keys encontradas
- X columnas _id sin FK (gaps)
- X registros huerfanos
- X cascadas peligrosas

## Inventario de FKs
| Tabla hija | Columna | Tabla padre | ON DELETE | Estado |

## Gaps (columnas _id sin FK)
| Tabla | Columna | Tabla padre probable | Riesgo |

## Registros huerfanos
| Relacion | Cantidad | Severidad |

## Cascadas peligrosas
| FK | Politica actual | Recomendada | Razon |

## Grafo de dependencias
Nivel 0 → Nivel N

## Acciones requeridas
1. [CRITICO] ...
2. [MEDIO] ...
```

## Cuando ejecutar

- Despues de agregar nuevas tablas o relaciones
- Antes de releases a produccion
- Despues de migraciones de datos
- Cuando se reporta "registro no encontrado" inesperado
