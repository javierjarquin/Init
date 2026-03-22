# /docs — Generate or update documentation

Genera o actualiza documentación del proyecto.

## Uso
```
/docs api                → Documentar endpoints de la API (OpenAPI/Swagger style)
/docs module {name}      → Documentar un módulo específico
/docs architecture       → Generar diagrama de arquitectura (Mermaid)
/docs onboarding         → Generar guía de onboarding para nuevos devs
/docs env                → Generar/actualizar .env.example con todos los env vars
```

## Instrucciones

### /docs api
1. Escanear todos los controllers/routes del backend
2. Extraer: method, path, guards/middleware, DTOs, response types
3. Generar tabla markdown:
   | Method | Path | Auth | Roles | Request Body | Response |
   |--------|------|------|-------|-------------|----------|
4. Guardar en `docs/api-reference.md`

### /docs module {name}
1. Leer todos los archivos del módulo
2. Documentar:
   - Propósito del módulo
   - Dependencias
   - Endpoints (si tiene)
   - Modelos/entities
   - Flujo de datos (diagrama Mermaid)
3. Guardar en `docs/modules/{name}.md`

### /docs architecture
1. Analizar estructura del proyecto
2. Generar diagrama Mermaid con:
   - Componentes principales
   - Flujo de datos
   - Dependencias entre módulos
   - Servicios externos
3. Guardar en `docs/architecture.md`

### /docs onboarding
1. Leer CLAUDE.md, README.md, .env.example
2. Generar guía paso a paso:
   - Requisitos (Node, DB, etc.)
   - Clonar repo
   - Instalar dependencias
   - Configurar env vars
   - Levantar servicios
   - Correr tests
   - Primer feature
3. Guardar en `docs/ONBOARDING.md`

### /docs env
1. Buscar todas las referencias a `process.env` o `os.environ` en el código
2. Comparar con `.env.example` existente
3. Agregar las variables faltantes con descripción y valor ejemplo
4. Alertar si hay variables en `.env.example` que ya no se usan
