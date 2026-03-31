---
globs: "Dockerfile*,docker-compose*.yml,docker-compose*.yaml,.dockerignore"
---

# Reglas para archivos Docker

- Usa multi-stage builds para reducir tamano de imagen
- No copies node_modules al contenedor — instala dentro del build
- Usa .dockerignore para excluir: .git, node_modules, .env, tests, docs
- Especifica versiones exactas de imagenes base (no uses :latest en produccion)
- Ejecuta el proceso como usuario non-root (USER node / USER app)
- Expone solo los puertos necesarios
- Usa HEALTHCHECK para verificar que el servicio esta funcionando
- docker-compose: usa depends_on con condition: service_healthy cuando sea posible
- Secretos nunca en Dockerfile — usa build args o Docker secrets
