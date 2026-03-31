# /migrate-db — Database migration workflow

Gestión segura de migraciones de base de datos.

## Uso
```
/migrate-db create "descripción"   → Crear nueva migración
/migrate-db run                    → Ejecutar migraciones pendientes
/migrate-db status                 → Ver estado de migraciones
/migrate-db rollback               → Revertir última migración (solo dev)
/migrate-db seed                   → Ejecutar seed data
```

## Instrucciones

### /migrate-db create
1. **Verificar** que el schema/models están actualizados
2. **Crear migración** con el ORM del proyecto:
   ```bash
   # Prisma
   npx prisma migrate dev --name {slug}

   # TypeORM
   npx typeorm migration:generate -n {Name}

   # Knex
   npx knex migrate:make {name}

   # Django
   python manage.py makemigrations

   # SQL puro
   # Crear archivo en migrations/ con timestamp
   ```
3. **Revisar** el SQL generado antes de aplicar
4. **Verificar** que la migración es reversible (tiene DOWN/rollback)

### /migrate-db run
1. **Verificar estado**:
   ```bash
   npx prisma migrate status  # o equivalente
   ```
2. **Ejecutar en dev local primero** — NUNCA directo en producción
3. **Verificar** que la aplicación funciona después de migrar
4. **Regenerar** el client del ORM si es necesario:
   ```bash
   npx prisma generate  # o equivalente
   ```

### /migrate-db status
1. Mostrar migraciones aplicadas vs pendientes
2. Alertar si hay divergencia entre dev y prod
3. Mostrar último timestamp de migración

### /migrate-db rollback
```
⚠️ SOLO usar en desarrollo local. NUNCA en producción.
```
1. En producción: crear migración nueva que revierta los cambios
2. En desarrollo: usar el rollback del ORM
3. Verificar que la app funciona después del rollback

### /migrate-db seed
1. Ejecutar seed script del proyecto
2. Verificar que no duplica datos si se corre múltiples veces (idempotente)

## Reglas de seguridad

### OPERACIONES BLOQUEADAS (requieren confirmacion explicita del usuario)
```
❌ migrate reset       → Borra TODA la base de datos. PROHIBIDO en dev y prod.
❌ DROP TABLE          → Irreversible sin backup. NUNCA sin confirmacion.
❌ DROP DATABASE       → Catastrofico. NUNCA.
❌ TRUNCATE TABLE      → Borra todos los registros. NUNCA sin confirmacion.
❌ DELETE FROM (sin WHERE) → Borra todos los registros. NUNCA.
❌ supabase db reset   → Borra TODO. PROHIBIDO.
❌ prisma migrate reset → Borra TODO. PROHIBIDO.
```

### Reglas generales
- NUNCA ejecutar operaciones destructivas sin confirmacion EXPLICITA del usuario
- NUNCA `migrate reset` — ni en desarrollo, ni en produccion. Usar `rollback` para revertir
- NUNCA `DROP TABLE` sin backup verificado Y confirmacion del usuario
- Siempre hacer backup antes de migrar en produccion
- Migraciones deben ser idempotentes cuando sea posible
- Agregar datos default en la migracion, no en el seed (para produccion)
- En produccion: NUNCA usar rollback. Crear migracion nueva que revierta cambios
- Verificar que la migracion tiene DOWN/rollback ANTES de aplicarla

### Alternativas seguras
```
✅ migrate deploy      → Aplica migraciones pendientes (sin reset)
✅ migrate rollback    → Revierte la ultima migracion (solo dev local)
✅ Crear migracion inversa → Para revertir en produccion
✅ Backup antes de migrar → pg_dump / mysqldump antes de cambios
```

### Por que NO usar reset ni en desarrollo
Un `migrate reset` en desarrollo puede parecer inofensivo, pero:
1. Si alguien conecta por error a la BD de staging/prod, pierde TODO
2. Crea el habito de "resetear cuando algo falla" en vez de arreglar la migracion
3. No prueba el flujo real de migraciones que correra en produccion
4. Si hay datos de prueba que tardaste horas en crear, los pierdes

La alternativa correcta: `migrate rollback` + corregir la migracion + `migrate run`
