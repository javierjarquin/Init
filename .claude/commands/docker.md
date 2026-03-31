# /docker — Gestion de contenedores Docker

Gestiona contenedores, imagenes y docker-compose del proyecto.

## Uso
```
/docker status        → Estado de contenedores del proyecto
/docker up            → Levantar servicios con docker-compose
/docker down          → Detener servicios
/docker build         → Construir/reconstruir imagenes
/docker logs          → Ver logs de un servicio
/docker clean         → Limpiar imagenes y volumenes sin usar
/docker create        → Crear Dockerfile o docker-compose.yml
```

## Instrucciones

### Comando: `status`
1. Ejecutar `docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"` para ver contenedores activos
2. Ejecutar `docker compose ps` (si existe docker-compose.yml) para ver servicios del proyecto
3. Mostrar resumen en tabla:

| Servicio | Estado | Puertos | Salud |
|----------|--------|---------|-------|

4. Si hay contenedores caidos, sugerir revisar logs

### Comando: `up`
1. Verificar que Docker esta corriendo: `docker info`
2. Buscar `docker-compose.yml` o `compose.yml` en el proyecto
3. Si no existe, preguntar si quiere crearlo (ver `create`)
4. Ejecutar `docker compose up -d`
5. Esperar 10 segundos y verificar que todos los servicios estan healthy
6. Mostrar puertos expuestos

### Comando: `down`
1. Ejecutar `docker compose down`
2. Preguntar si quiere eliminar volumenes (`docker compose down -v`)
3. Confirmar que los contenedores se detuvieron

### Comando: `build`
1. Verificar que existe Dockerfile
2. Ejecutar `docker compose build` (si hay compose) o `docker build -t {nombre} .`
3. Mostrar tamanio de la imagen resultante
4. Sugerir optimizaciones si la imagen es grande (> 500MB):
   - Multi-stage builds
   - .dockerignore
   - Capas de cache optimizadas

### Comando: `logs`
1. Preguntar cual servicio (o mostrar lista de servicios disponibles)
2. Ejecutar `docker compose logs -f --tail=100 {servicio}`
3. Si hay errores, analizarlos y sugerir soluciones

### Comando: `clean`
1. Mostrar espacio usado: `docker system df`
2. Listar imagenes sin tag: `docker images -f "dangling=true"`
3. Listar volumenes sin usar: `docker volume ls -f "dangling=true"`
4. Pedir confirmacion antes de limpiar
5. Ejecutar `docker system prune -f` (sin volumenes por seguridad)
6. Si el usuario confirma volumenes: `docker volume prune -f`

### Comando: `create`
Generar archivos Docker segun el stack definido en CLAUDE.md:

**Dockerfile:**
- Usar multi-stage build
- Imagen base slim/alpine
- Crear usuario no-root
- Copiar solo archivos necesarios
- Respetar el package manager del proyecto
- Incluir health check
- Respetar .dockerignore

**docker-compose.yml:**
- Servicio principal (app)
- Base de datos segun CLAUDE.md (postgres, mysql, mongo, etc.)
- Cache/Redis si el proyecto lo usa
- Variables de entorno desde .env
- Volumen para datos persistentes
- Red interna
- Health checks

**Ejemplo de estructura generada:**
```yaml
services:
  app:
    build: .
    ports:
      - "3000:3000"
    env_file: .env
    depends_on:
      db:
        condition: service_healthy
  db:
    image: postgres:16-alpine
    volumes:
      - db_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready"]
volumes:
  db_data:
```

**.dockerignore** (crear si no existe):
```
node_modules
.git
.env
*.log
coverage
dist
.next
```

## Reglas
- NUNCA ejecutar `docker system prune -a` sin confirmacion explicita
- NUNCA eliminar volumenes de base de datos sin preguntar
- Siempre verificar que Docker esta corriendo antes de cualquier comando
- Preferir `docker compose` (v2) sobre `docker-compose` (v1)
- No hardcodear credenciales en Dockerfiles — usar variables de entorno
