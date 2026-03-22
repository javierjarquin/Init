# Definition of Done (DoD)

> Un cambio solo está "terminado" cuando cumple TODOS los criterios de su categoría.

## Para cualquier cambio de código

- [ ] Commit message sigue conventional commits (`feat:`, `fix:`, etc.)
- [ ] No hay errores de TypeScript / tipado (`tsc --noEmit` o equivalente)
- [ ] No hay errores de lint
- [ ] No se exponen credenciales, IPs, ni datos sensibles en código ni docs
- [ ] PR creado contra `development` (nunca directo a `main`)

## Para bug fixes (`fix:`)

Todo lo anterior, más:
- [ ] Test unitario o E2E que reproduce el bug antes del fix
- [ ] Test pasa después del fix
- [ ] Reporte QA actualizado si viene de auditoría QA
- [ ] Issue referenciado en el PR (`closes #XX`)

## Para nuevas funcionalidades (`feat:`)

Todo lo anterior, más:
- [ ] Tests unitarios para la lógica de negocio nueva
- [ ] Test E2E para el happy path
- [ ] Funciona en móvil y desktop (si tiene UI)
- [ ] Accesibilidad básica (aria-labels en botones de solo ícono)
- [ ] No se crean endpoints nuevos innecesarios (reutilizar existentes)
- [ ] Documentación actualizada si cambia la API pública

## Para cambios de base de datos

Todo lo de código, más:
- [ ] Migración creada con el ORM
- [ ] Migración es reversible (no hay `DROP TABLE` sin respaldo)
- [ ] Schema/types regenerados después del cambio
- [ ] Seed actualizado si aplica

## Para cambios de CI/CD

- [ ] Workflow probado en un PR antes de mergear
- [ ] No se exponen secrets en logs
- [ ] Tiempos de CI no aumentan significativamente

## Para releases a producción

- [ ] Todos los PRs del release tienen DoD completo
- [ ] E2E pasa en entorno de desarrollo remoto
- [ ] Health check responde `200` post-deploy
- [ ] Changelog actualizado
- [ ] Tag de versión creado

## Excepciones

- Hotfixes críticos pueden ir directo a `main` con PR, pero deben completar DoD dentro de 24h
- Si un criterio no aplica, documentar por qué en el PR
