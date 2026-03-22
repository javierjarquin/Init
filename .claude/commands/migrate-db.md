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
- NUNCA `migrate reset` en producción
- NUNCA `DROP TABLE` sin backup verificado
- Siempre hacer backup antes de migrar en producción
- Migraciones deben ser idempotentes cuando sea posible
- Agregar datos default en la migración, no en el seed (para producción)
