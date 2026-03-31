---
globs: "**/migrations/**,**/migrate/**,*.migration.ts,*.migration.js"
---

# Reglas para migraciones de base de datos

- SIEMPRE incluye funcion de rollback (down/revert)
- NUNCA uses DROP TABLE sin confirmacion explicita del usuario
- NUNCA uses DELETE FROM sin WHERE
- Para tablas con datos en produccion, usa migraciones no-destructivas:
  1. Primero ADD la nueva columna/tabla
  2. Migra los datos
  3. Luego DROP la columna/tabla vieja (en migracion separada)
- Nombra las migraciones con timestamp + descripcion: `20240101_add_users_email_index`
- Agrega indices para columnas usadas frecuentemente en WHERE, JOIN, ORDER BY
- Usa transacciones para migraciones que modifican multiples tablas
- Verifica que los tipos de datos sean consistentes entre foreign keys
