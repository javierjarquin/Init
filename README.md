# Claude Code Starter Kit

**Kit de inicio para maximizar el uso de Claude Code en cualquier proyecto de software.**

Incluye **24 slash commands** (skills), templates de procesos, GitHub templates, y documentación operacional lista para usar. Diseñado para equipos que quieren un workflow profesional de desarrollo desde el día 1.

---

## Qué incluye

```
claude-code-starter-kit/
├── .claude/
│   ├── commands/              ← 24 slash commands (skills)
│   │   ├── feature.md         ← Scaffold de features
│   │   ├── test-unit.md       ← Tests unitarios
│   │   ├── e2e.md             ← Tests E2E
│   │   ├── review-pr.md       ← Code review
│   │   ├── deploy-dev.md      ← Deploy a desarrollo
│   │   ├── deploy-prod.md     ← Deploy a producción
│   │   ├── hotfix.md          ← Hotfix de emergencia
│   │   ├── rollback.md        ← Rollback de deploys
│   │   ├── qa.md              ← Auditoría QA
│   │   ├── fix-qa.md          ← Corregir hallazgos QA
│   │   ├── security-scan.md   ← Escaneo de seguridad
│   │   ├── refactor.md        ← Refactoring seguro
│   │   ├── cleanup.md         ← Limpieza de código
│   │   ├── debug.md           ← Asistente de debugging
│   │   ├── perf.md            ← Análisis de performance
│   │   ├── deps.md            ← Gestión de dependencias
│   │   ├── migrate-db.md      ← Migraciones de BD
│   │   ├── docs.md            ← Generación de documentación
│   │   ├── sprint.md          ← Planificación de sprints
│   │   ├── status.md          ← Dashboard de estado
│   │   ├── changelog.md       ← Generación de changelog
│   │   ├── audit.md           ← Auditoría de coherencia
│   │   └── adr.md             ← Architecture Decision Records
│   └── settings.local.json    ← Permisos de Claude Code
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md      ← Template para bugs
│   │   ├── feature_request.md ← Template para features
│   │   └── qa_finding.md      ← Template para hallazgos QA
│   └── pull_request_template.md ← Template para PRs
├── docs/
│   ├── procesos/
│   │   ├── DEFINITION_OF_DONE.md  ← Cuándo el código está "listo"
│   │   ├── RELEASE_PROCESS.md     ← Proceso de releases
│   │   ├── INCIDENT_RESPONSE.md   ← Respuesta a incidentes
│   │   └── RUNBOOKS.md            ← Guías operacionales
│   └── adr/
│       └── ADR-000-template.md    ← Template para ADRs
├── CLAUDE.md                  ← Template de configuración del proyecto
├── setup.sh                   ← Script de instalación
└── README.md                  ← Este archivo
```

---

## Instalación

### Opción 1: Script automático

```bash
# Clonar el starter kit
git clone https://github.com/tu-org/claude-code-starter-kit.git

# Ejecutar setup apuntando a tu proyecto
cd claude-code-starter-kit
chmod +x setup.sh
./setup.sh /ruta/a/tu/proyecto
```

El script copia todos los archivos sin sobrescribir los existentes.

### Opción 2: Manual

Copia las carpetas `.claude/`, `.github/`, `docs/` y `CLAUDE.md` a tu proyecto.

### Opción 3: Copiar solo lo que necesitas

Si solo quieres algunos skills, copia los archivos `.md` que quieras a `.claude/commands/` en tu proyecto.

---

## Configuración post-instalación

### 1. Editar CLAUDE.md

Este es el archivo más importante. Claude Code lo lee al inicio de cada conversación. Reemplaza los `{{PLACEHOLDER}}` con los valores de tu proyecto:

```markdown
# CLAUDE.md — Mi Proyecto

## Project Overview
**Mi Proyecto** — Plataforma de e-commerce para artesanías mexicanas.

## Tech Stack
| Layer       | Technology          |
|-------------|---------------------|
| Backend     | NestJS 10, TypeScript |
| Frontend    | Next.js 14, React 18 |
| Database    | PostgreSQL 16       |

## Common Commands
# Install
pnpm install

# Dev
pnpm dev

# Test
pnpm test

## URLs
| Environment | API                         | Web                        |
|-------------|-----------------------------|-----------------------------|
| Local       | http://localhost:3001       | http://localhost:3000       |
| Production  | https://api.miproyecto.com | https://miproyecto.com     |
```

### 2. Ajustar permisos (`.claude/settings.local.json`)

Edita los permisos según tu package manager y herramientas:

```json
{
  "permissions": {
    "allow": [
      "Bash(curl:*)",
      "Bash(npx:*)",
      "Bash(pnpm:*)",
      "Bash(docker:*)",
      "Bash(git:*)",
      "Bash(gh:*)"
    ]
  }
}
```

### 3. Verificar instalación

```bash
# Abrir Claude Code en tu proyecto
cd tu-proyecto
claude

# Probar un skill
> /status
```

---

## Guía de Skills (Slash Commands)

### Desarrollo

| Skill | Qué hace | Ejemplo |
|-------|----------|---------|
| `/feature` | Scaffold completo de una nueva feature | `/feature "notifications"` |
| `/refactor` | Analiza y refactoriza código de forma segura | `/refactor src/services/auth/` |
| `/cleanup` | Limpia código muerto, imports, console.logs | `/cleanup all` |
| `/debug` | Diagnostica errores y problemas | `/debug "Cannot read property of undefined"` |

### Testing

| Skill | Qué hace | Ejemplo |
|-------|----------|---------|
| `/test-unit` | Corre o crea unit tests | `/test-unit create auth` |
| `/e2e` | Gestiona tests end-to-end | `/e2e create "checkout flow"` |
| `/qa` | Ejecuta auditoría QA completa | `/qa all` |
| `/fix-qa` | Corrige un hallazgo de QA | `/fix-qa QA-001` |

### Deploy & Operations

| Skill | Qué hace | Ejemplo |
|-------|----------|---------|
| `/deploy-dev` | Commit + push + PR a development | `/deploy-dev` |
| `/deploy-prod` | Merge a main con verificación | `/deploy-prod` |
| `/hotfix` | Fix de emergencia directo a main | `/hotfix "login crash"` |
| `/rollback` | Revierte un deploy problemático | `/rollback prod` |

### Code Quality

| Skill | Qué hace | Ejemplo |
|-------|----------|---------|
| `/review-pr` | Review de PR en 5 dimensiones | `/review-pr 42` |
| `/security-scan` | Escaneo completo de seguridad | `/security-scan` |
| `/perf` | Análisis de performance | `/perf api` |
| `/audit` | Auditoría de coherencia negocio | `/audit all` |

### Project Management

| Skill | Qué hace | Ejemplo |
|-------|----------|---------|
| `/sprint` | Planifica y gestiona sprints | `/sprint plan` |
| `/status` | Dashboard de estado del proyecto | `/status` |
| `/changelog` | Genera changelog desde commits | `/changelog --release` |
| `/adr` | Crea Architecture Decision Record | `/adr "API REST vs GraphQL"` |

### Documentation & Maintenance

| Skill | Qué hace | Ejemplo |
|-------|----------|---------|
| `/docs` | Genera documentación | `/docs api` |
| `/deps` | Gestiona dependencias | `/deps update` |
| `/migrate-db` | Migraciones de base de datos | `/migrate-db create "add users table"` |

---

## Workflows Completos (Ejemplos)

### Workflow 1: Nueva feature de principio a fin

```
# 1. Planificar
> /sprint plan
→ Claude lista issues, prioriza con MoSCoW, estima con T-shirt sizing

# 2. Crear feature
> /feature "payment-methods"
→ Claude crea branch, scaffold backend + frontend, registra módulo

# 3. Desarrollar (conversación normal con Claude)
> Implementa el endpoint POST /payments/methods que reciba tipo y datos del método de pago

# 4. Tests
> /test-unit create payment-methods
→ Claude crea specs con mocks, corre los tests

# 5. Review
> /review-pr
→ Claude revisa seguridad, performance, convenciones, lógica y calidad

# 6. Deploy
> /deploy-dev
→ Claude hace commit, push, crea PR a development

# 7. QA
> /qa payment
→ Claude ejecuta E2E tests del flujo de pagos

# 8. Producción
> /deploy-prod
→ Claude pide confirmación, mergea a main, verifica health check
```

### Workflow 2: Bug crítico en producción

```
# 1. Diagnosticar
> /debug "500 error en /api/payments"
→ Claude busca el error, traza el request, identifica causa raíz

# 2. Hotfix
> /hotfix "payment processing null pointer"
→ Claude crea branch desde main, aplica fix mínimo, crea PR directo a main

# 3. Verificar
> /status
→ Claude verifica health checks post-deploy

# 4. Documentar
> Claude pregunta si necesita postmortem (SEV-1/SEV-2 obligatorio)
```

### Workflow 3: Auditoría completa del proyecto

```
# 1. Seguridad
> /security-scan
→ Escanea dependencias, secrets, código — reporte OWASP Top 10

# 2. Performance
> /perf api
→ Detecta N+1 queries, endpoints lentos, falta de cache

# 3. Coherencia
> /audit all
→ Verifica que frontend y backend están alineados

# 4. Limpieza
> /cleanup all
→ Elimina imports no usados, dead code, console.logs

# 5. Dependencias
> /deps update
→ Actualiza dependencias con verificación de breaking changes
```

### Workflow 4: Onboarding de nuevo proyecto

```
# 1. Documentar
> /docs onboarding
→ Genera guía paso a paso para nuevos developers

# 2. Documentar API
> /docs api
→ Lista todos los endpoints con DTOs y roles

# 3. Arquitectura
> /docs architecture
→ Genera diagrama Mermaid de la arquitectura

# 4. Variables de entorno
> /docs env
→ Actualiza .env.example con todas las variables del código
```

### Workflow 5: Release semanal

```
# 1. Status
> /sprint status
→ Ver progreso del sprint, issues completados vs pendientes

# 2. Cerrar sprint
> /sprint close
→ Retrospectiva automática, mover pendientes al siguiente sprint

# 3. Changelog
> /changelog --release
→ Genera changelog y crea GitHub Release

# 4. Deploy
> /deploy-prod
→ Merge a main con verificación completa

# 5. Si algo falla
> /rollback prod
→ Revierte al deploy anterior inmediatamente
```

---

## Process Docs incluidos

### Definition of Done (`docs/procesos/DEFINITION_OF_DONE.md`)
Checklist que define cuándo un cambio está "terminado". Cubre:
- Cualquier cambio de código
- Bug fixes
- Nuevas features
- Cambios de BD
- CI/CD
- Releases

### Release Process (`docs/procesos/RELEASE_PROCESS.md`)
Workflow completo de releases:
- Flujo de branches: feature → development → main
- SemVer (MAJOR.MINOR.PATCH)
- Proceso de hotfix
- Rollback procedures

### Incident Response (`docs/procesos/INCIDENT_RESPONSE.md`)
Manejo de incidentes con:
- 4 niveles de severidad (SEV-1 a SEV-4)
- Proceso: detección → triaje → contención → resolución → postmortem
- Template de postmortem

### Runbooks (`docs/procesos/RUNBOOKS.md`)
Guías operacionales para problemas comunes:
- API no responde
- BD lenta
- Cache caído
- Migración falla
- Servicio externo caído
- Deploy falla
- Rollback
- Problema de seguridad

---

## GitHub Templates incluidos

### Pull Request Template
Estructura cada PR con:
- Resumen de cambios
- Tipo (fix/feat/refactor/etc.)
- Módulos afectados
- Contexto QA (si aplica)
- Evidencia antes/después
- Checklist de verificación

### Issue Templates
- **Bug Report**: Pasos para reproducir, impacto, evidencia
- **Feature Request**: Problema → solución → alternativas → criterios
- **QA Finding**: ID, flujo, test E2E, error, análisis, recomendación

---

## Personalización

### Agregar un skill nuevo

Crea un archivo `.md` en `.claude/commands/`:

```markdown
# /mi-skill — Descripción corta

Descripción de qué hace este skill.

## Uso
/mi-skill arg1       → Qué hace con arg1
/mi-skill arg2       → Qué hace con arg2

## Instrucciones

1. **Paso 1**: Qué debe hacer Claude
2. **Paso 2**: Siguiente acción
3. **Paso 3**: Resultado esperado
```

Claude Code detecta automáticamente los archivos en `.claude/commands/`.

### Agregar hooks (instrumentación)

Si quieres monitorear las sesiones de Claude Code, agrega hooks en `settings.local.json`:

```json
{
  "permissions": { "allow": ["..."] },
  "hooks": {
    "SessionStart": [{ "hooks": [{ "type": "http", "url": "http://localhost:4321/api/hooks/claude-code" }] }],
    "Stop": [{ "hooks": [{ "type": "http", "url": "http://localhost:4321/api/hooks/claude-code" }] }]
  }
}
```

Hooks disponibles: `SessionStart`, `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `PostToolUseFailure`, `Stop`, `SubagentStart`, `SubagentStop`, `SessionEnd`.

### Agregar al sistema de memoria

Claude Code tiene un sistema de memoria persistente. Para habilitarlo, crea el directorio de memoria del proyecto:

```bash
# Claude Code crea esto automáticamente, pero puedes pre-crearlo
mkdir -p ~/.claude/projects/$(pwd | tr '/' '-')/memory
```

Pídele a Claude que "recuerde" información importante:
```
> Recuerda que usamos Stripe para pagos y el webhook está en /api/webhooks/stripe
> Recuerda que el deploy tarda ~5 minutos
> Recuerda que los tests E2E requieren Docker corriendo
```

---

## Tips para aprovechar Claude Code al 100%

### 1. CLAUDE.md es tu arma secreta
Mientras más completo esté tu CLAUDE.md, mejor será Claude Code. Incluye:
- Estructura del proyecto
- Comandos comunes
- Convenciones de código
- Patrones críticos que no deben romperse
- URLs de cada entorno

### 2. Usa skills en cadena
Los skills se complementan entre sí:
```
/feature → /test-unit create → /review-pr → /deploy-dev → /qa → /deploy-prod
```

### 3. Deja que Claude planifique antes de ejecutar
Para tareas complejas, pídele que planifique primero:
```
> Necesito migrar de REST a GraphQL. No hagas cambios aún, solo dame un plan.
```

### 4. Usa el sistema de memoria
```
> Recuerda que siempre hay que correr /security-scan antes de un release
> Recuerda que el módulo de pagos está en mantenimiento hasta marzo
```

### 5. Combina con GitHub CLI
Claude Code tiene integración nativa con `gh`:
```
> Crea un issue para el bug que encontraste
> Lista los PRs pendientes de review
> Cierra el issue #42 con el fix que acabamos de hacer
```

### 6. Usa subagentes para tareas paralelas
Claude Code puede ejecutar tareas en paralelo internamente. Los skills como `/status` y `/security-scan` aprovechan esto automáticamente.

---

## Compatibilidad

| Feature | Node.js | Python | Go | Ruby | Rust |
|---------|:-------:|:------:|:--:|:----:|:----:|
| `/feature` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/test-unit` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/e2e` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/review-pr` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/deploy-*` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/security-scan` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/refactor` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `/sprint` | ✅ | ✅ | ✅ | ✅ | ✅ |
| Todos los demás | ✅ | ✅ | ✅ | ✅ | ✅ |

Los skills son **agnósticos al lenguaje**. Claude Code adapta los comandos según el stack definido en CLAUDE.md.

---

## FAQ

### ¿Necesito Claude Code CLI o funciona en VS Code?
Funciona en ambos. Los slash commands se detectan automáticamente en `.claude/commands/`.

### ¿Puedo usar esto con un proyecto que no es monorepo?
Sí. Los skills son genéricos. Solo ajusta las rutas en CLAUDE.md.

### ¿Los skills funcionan con cualquier lenguaje?
Sí. Claude Code lee CLAUDE.md para entender tu stack y adapta los comandos. Por ejemplo, `/test-unit` usa `pnpm test` para Node.js, `pytest` para Python, `go test` para Go, etc.

### ¿Puedo agregar mis propios skills?
Sí. Crea un archivo `.md` en `.claude/commands/` y Claude Code lo detecta automáticamente. Ver sección "Personalización".

### ¿Los skills se ejecutan automáticamente?
No. Tú los invocas escribiendo `/nombre-del-skill` en la conversación con Claude Code.

### ¿Esto afecta al rendimiento de Claude Code?
No. Claude Code solo lee CLAUDE.md al inicio y los skills bajo demanda.

---

## Licencia

MIT — Usa, modifica y comparte libremente.
