---
globs: ".env,.env.*,.env.local,.env.development,.env.production,.env.example"
---

# Reglas para archivos de entorno

- NUNCA hagas commit de archivos .env con valores reales (solo .env.example)
- .env.example debe tener TODAS las variables con valores placeholder
- Agrupa variables por servicio: DB_*, AUTH_*, SMTP_*, REDIS_*, etc.
- Documenta cada variable con un comentario descriptivo
- Usa nombres UPPER_SNAKE_CASE para todas las variables
- Valores sensibles (API keys, passwords, tokens) NUNCA en el codigo fuente
- Si detectas un secret en un archivo .env trackeado por git, alerta inmediatamente
