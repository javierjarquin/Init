---
globs: "**/routes/**,**/controllers/**,**/handlers/**,**/api/**/*.ts,**/api/**/*.js,**/endpoints/**"
---

# Reglas para rutas y controladores de API

- Valida SIEMPRE el input del usuario (Zod, Joi, class-validator, etc.)
- Retorna codigos HTTP semanticos: 201 para creacion, 204 para delete, 422 para validacion
- Nunca expongas errores internos al cliente — usa mensajes genericos en produccion
- Implementa rate limiting en endpoints publicos
- Verifica autenticacion y autorizacion antes de cualquier operacion
- Usa try/catch o middleware de errores — nunca dejes excepciones sin manejar
- Parametros de query para filtros/paginacion, body para creacion/actualizacion
- Respuestas consistentes: `{ data, meta, error }` o el patron del proyecto
