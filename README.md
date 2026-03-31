# Claude Code Starter Kit

> Kit completo para iniciar y mantener un sistema explotando al buen Claudio.

**Kit de inicio para maximizar el uso de Claude Code en cualquier proyecto de software.**

Incluye **38 slash commands** (skills), **4 subagentes especializados**, **7 reglas contextuales**, **8 hooks de seguridad**, **4 GitHub Actions workflows**, **MCP/LSP templates**, **sistema de memoria**, **plugin manifest**, templates de procesos, GitHub templates y documentacion operacional lista para usar. Diseñado para equipos que quieren un workflow profesional de desarrollo desde el dia 1.

---

## Que incluye

```
claude-code-starter-kit/
├── .claude/
│   ├── commands/              ← 38 slash commands (skills)
│   │   ├── feature.md         ← Scaffold de features
│   │   ├── test-unit.md       ← Tests unitarios
│   │   ├── e2e.md             ← Tests E2E
│   │   ├── review-pr.md       ← Code review
│   │   ├── code-review.md     ← Checklist tecnico 10 puntos
│   │   ├── deploy-dev.md      ← Deploy a desarrollo
│   │   ├── deploy-prod.md     ← Deploy a produccion
│   │   ├── hotfix.md          ← Hotfix de emergencia
│   │   ├── rollback.md        ← Rollback de deploys
│   │   ├── qa.md              ← Auditoria QA
│   │   ├── fix-qa.md          ← Corregir hallazgos QA
│   │   ├── security-scan.md   ← Escaneo de seguridad
│   │   ├── refactor.md        ← Refactoring seguro
│   │   ├── cleanup.md         ← Limpieza de codigo
│   │   ├── debug.md           ← Asistente de debugging
│   │   ├── perf.md            ← Analisis de performance
│   │   ├── deps.md            ← Gestion de dependencias
│   │   ├── migrate-db.md      ← Migraciones de BD
│   │   ├── docs.md            ← Generacion de documentacion
│   │   ├── sprint.md          ← Planificacion de sprints
│   │   ├── status.md          ← Dashboard de estado
│   │   ├── changelog.md       ← Generacion de changelog
│   │   ├── audit.md           ← Auditoria de coherencia
│   │   ├── adr.md             ← Architecture Decision Records
│   │   ├── flows.md           ← Flujos de negocio
│   │   ├── flow-test.md       ← Testing de flujos E2E
│   │   ├── ux-review.md       ← Auditoria visual UX/UI
│   │   ├── validate.md        ← Validacion pre-merge
│   │   ├── standards.md       ← Buenas practicas
│   │   ├── docker.md          ← Gestion de Docker
│   │   ├── env-check.md       ← Variables de entorno
│   │   ├── a11y.md            ← Accesibilidad WCAG
│   │   ├── data-integrity.md  ← Integridad de datos
│   │   ├── relationship-audit.md ← Relaciones de BD
│   │   ├── manual.md          ← Manuales PDF
│   │   ├── init-project.md    ← Setup en proyecto existente  ← NUEVO
│   │   ├── learn-project.md   ← Extraer estandares del codigo ← NUEVO
│   │   └── verify-req.md      ← Anti-alucinacion de reqs     ← NUEVO
│   ├── agents/                ← 4 subagentes especializados     ← NUEVO
│   │   ├── reviewer/          ← Code review exhaustivo
│   │   ├── researcher/        ← Investigacion tecnica
│   │   ├── db-expert/         ← Experto en bases de datos
│   │   └── quick-fix/         ← Correcciones rapidas
│   ├── rules/                 ← 7 reglas contextuales           ← NUEVO
│   │   ├── tests.md           ← Reglas para archivos de test
│   │   ├── migrations.md      ← Reglas para migraciones
│   │   ├── api-routes.md      ← Reglas para rutas/controllers
│   │   ├── components.md      ← Reglas para componentes frontend
│   │   ├── env-files.md       ← Reglas para archivos .env
│   │   ├── docker.md          ← Reglas para Dockerfiles
│   │   └── anti-hallucination.md ← Verifica antes de referenciar ← NUEVO
│   └── settings.local.json    ← Permisos + 8 hooks de seguridad
├── .claude-plugin/            ← Plugin manifest                  ← NUEVO
│   └── plugin.json            ← Metadata para distribucion
├── .github/
│   ├── workflows/             ← CI/CD automatizado
│   │   ├── ci.yml             ← Lint + Typecheck + Tests en PRs
│   │   ├── cd-dev.yml         ← Deploy automatico a development
│   │   ├── cd-prod.yml        ← Deploy a produccion con approval
│   │   └── security.yml       ← Escaneo de seguridad semanal
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md      ← Template para bugs
│   │   ├── feature_request.md ← Template para features
│   │   └── qa_finding.md      ← Template para hallazgos QA
│   └── pull_request_template.md ← Template para PRs
├── docs/
│   ├── procesos/
│   │   ├── DEFINITION_OF_DONE.md  ← Cuando el codigo esta "listo"
│   │   ├── RELEASE_PROCESS.md     ← Proceso de releases
│   │   ├── INCIDENT_RESPONSE.md   ← Respuesta a incidentes
│   │   └── RUNBOOKS.md            ← Guias operacionales
│   └── adr/
│       └── ADR-000-template.md    ← Template para ADRs
├── .mcp.json                  ← MCP servers template             ← NUEVO
├── .lsp.json                  ← LSP servers template             ← NUEVO
├── CLAUDE.md                  ← Template de configuracion del proyecto
├── MEMORY.md                  ← Sistema de memoria persistente   ← NUEVO
├── keybindings.json           ← Atajos de teclado template       ← NUEVO
├── setup.sh                   ← Script de instalacion (Linux/Mac)
├── setup.bat                  ← Script de instalacion (Windows)
└── README.md                  ← Este archivo
```

---

## Instalacion

### Opcion 1: Script automatico

**Windows (CMD o PowerShell):**
```cmd
git clone https://github.com/javierjarquin/Init.git claude-code-starter-kit
cd claude-code-starter-kit
setup.bat C:\ruta\a\tu\proyecto
```

**Linux / Mac:**
```bash
git clone https://github.com/javierjarquin/Init.git claude-code-starter-kit
cd claude-code-starter-kit
chmod +x setup.sh
./setup.sh /ruta/a/tu/proyecto
```

El script copia todos los archivos sin sobrescribir los existentes.

### Opcion 2: Manual

Copia las carpetas `.claude/`, `.github/`, `docs/` y `CLAUDE.md` a tu proyecto.

### Opcion 3: Copiar solo lo que necesitas

Si solo quieres algunos skills, copia los archivos `.md` que quieras a `.claude/commands/` en tu proyecto.

---

## Implementar en un proyecto existente

Si ya tienes un sistema con codigo, este es el flujo recomendado:

### Opcion A: Automatico (recomendado)

```bash
# 1. Instala el kit con el script
setup.bat C:\ruta\a\tu-proyecto-existente     # Windows
./setup.sh /ruta/a/tu-proyecto-existente       # Linux/Mac

# 2. Abre Claude Code en tu proyecto
cd tu-proyecto-existente
claude

# 3. Claude detecta que CLAUDE.md tiene placeholders y ofrece configurarlo
# O ejecuta manualmente:
> /init-project full

# 4. Extrae los estandares reales de tu codigo
> /learn-project
```

`/init-project` detecta tu stack y configura todo. `/learn-project` analiza tu codigo real y genera reglas especificas.

### Opcion B: Manual (control total)

Copia solo lo que necesites segun tu caso:

**Nivel 1 — Lo minimo** (funciona solo con esto):
```
📋 CLAUDE.md                        ← Edita los placeholders con tu stack
📋 .claude/settings.local.json      ← Hooks de seguridad
```

**Nivel 2 — Desarrollo diario** (recomendado):
```
📋 CLAUDE.md
📋 .claude/settings.local.json
📂 .claude/commands/*.md             ← 38 skills
📋 MEMORY.md                         ← Sistema de memoria
```

**Nivel 3 — Equipo completo** (todo):
```
📋 CLAUDE.md
📋 .claude/settings.local.json
📂 .claude/commands/*.md             ← 38 skills
📂 .claude/agents/*/                 ← 4 subagentes
📂 .claude/rules/*.md                ← 7 reglas contextuales
📋 .mcp.json                         ← MCP servers
📋 .lsp.json                         ← LSP servers
📋 MEMORY.md                         ← Memoria
📋 keybindings.json                  ← Atajos
📂 .github/workflows/*.yml           ← CI/CD
📂 .github/ISSUE_TEMPLATE/*.md       ← Issue templates
📋 .github/pull_request_template.md
📂 docs/procesos/*.md                ← Process docs
```

### Que hacer despues de copiar

```
# 1. Configura CLAUDE.md (lo mas importante)
> /init-project
→ Detecta tu stack y rellena los placeholders automaticamente

# 2. Extrae estandares del codigo existente
> /learn-project
→ Analiza 15-30 archivos, extrae naming, patrones, anti-patrones
→ Genera reglas en .claude/rules/ especificas para tu proyecto
→ Actualiza standards.md con ejemplos REALES de tu codigo

# 3. Primer escaneo de salud
> /security-scan
→ Detecta vulnerabilidades existentes

> /status
→ Dashboard del estado actual

# 4. Opcional: conecta servicios
→ Edita .mcp.json para conectar tu BD, Slack, Sentry, etc.
```

### Ejemplo real: Sistema Delphi existente

```bash
# Copiar el kit
setup.bat C:\Proyectos\SisInventario

# Abrir Claude Code
cd C:\Proyectos\SisInventario
claude

# Claude ve CLAUDE.md con placeholders...
> /init-project
→ "Detectado: Delphi XE4, Firebird 2.5, 45 forms, 12 datamodules"
→ Genera CLAUDE.md configurado automaticamente

> /learn-project
→ "Analizando 25 archivos..."
→ "Naming: TClase, FPrivado, AParametro — PascalCase"
→ "Patron datos: DataModules con IBQuery parametrizado"
→ "⚠️ 3 archivos con SQL concatenado detectado"
→ Genera .claude/rules/delphi.md con las convenciones reales

> /security-scan
→ "CRITICO: 8 queries con SQL concatenado (injection risk)"
→ "ALTO: 2 passwords hardcodeados en dmConexion.pas"

# Ahora Claude Code conoce TU proyecto
> /status
→ Dashboard completo del sistema
```

---

## Configuracion post-instalacion

### 1. Editar CLAUDE.md

Este es el archivo mas importante. Claude Code lo lee al inicio de cada conversacion. Reemplaza los `{{PLACEHOLDER}}` con los valores de tu proyecto:

```markdown
# CLAUDE.md — Mi Proyecto

## Project Overview
**Mi Proyecto** — Plataforma de e-commerce para artesanias mexicanas.

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

Edita los permisos segun tu package manager y herramientas:

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

### 3. Configurar GitHub Actions workflows

Los workflows en `.github/workflows/` son templates listos para usar. Ajusta segun tu stack:

- **ci.yml** — Cambia el package manager (pnpm/npm/yarn/bun) y los comandos
- **cd-dev.yml** — Descomenta tu proveedor de deploy (Vercel, Railway, Fly.io, Docker)
- **cd-prod.yml** — Configura el environment de produccion en GitHub (Settings > Environments)
- **security.yml** — Activa CodeQL si quieres analisis profundo

### 4. Verificar instalacion

```bash
# Abrir Claude Code en tu proyecto
cd tu-proyecto
claude

# Probar un skill
> /status
```

---

## Guia de Skills (Slash Commands)

### Desarrollo

| Skill | Que hace | Ejemplo |
|-------|----------|---------|
| `/feature` | Scaffold completo de una nueva feature | `/feature "notifications"` |
| `/refactor` | Analiza y refactoriza codigo de forma segura | `/refactor src/services/auth/` |
| `/cleanup` | Limpia codigo muerto, imports, console.logs | `/cleanup all` |
| `/debug` | Diagnostica errores y problemas | `/debug "Cannot read property of undefined"` |
| `/docker` | Gestiona contenedores, imagenes y compose | `/docker up` |

### Testing

| Skill | Que hace | Ejemplo |
|-------|----------|---------|
| `/test-unit` | Corre o crea unit tests | `/test-unit create auth` |
| `/e2e` | Gestiona tests end-to-end | `/e2e create "checkout flow"` |
| `/qa` | Ejecuta auditoria QA completa | `/qa all` |
| `/fix-qa` | Corrige un hallazgo de QA | `/fix-qa QA-001` |

### Deploy & Operations

| Skill | Que hace | Ejemplo |
|-------|----------|---------|
| `/deploy-dev` | Commit + push + PR a development | `/deploy-dev` |
| `/deploy-prod` | Merge a main con verificacion | `/deploy-prod` |
| `/hotfix` | Fix de emergencia directo a main | `/hotfix "login crash"` |
| `/rollback` | Revierte un deploy problematico | `/rollback prod` |

### Code Quality

| Skill | Que hace | Ejemplo |
|-------|----------|---------|
| `/review-pr` | Review de PR en 5 dimensiones | `/review-pr 42` |
| `/code-review` | Checklist tecnico de 10 puntos | `/code-review --full` |
| `/validate` | Workflow pre-merge: review + build + smoke test | `/validate --fix` |
| `/standards` | Buenas practicas con ejemplos CORRECTO vs INCORRECTO | `/standards front` |
| `/security-scan` | Escaneo completo de seguridad | `/security-scan` |
| `/perf` | Analisis de performance | `/perf api` |
| `/audit` | Auditoria de coherencia negocio | `/audit all` |
| `/ux-review` | Auditoria visual UX/UI con screenshots | `/ux-review mobile` |
| `/a11y` | Auditoria de accesibilidad WCAG 2.1 | `/a11y page /login` |

### Infrastructure & Environment

| Skill | Que hace | Ejemplo |
|-------|----------|---------|
| `/docker` | Gestiona Docker: build, up, down, logs, clean | `/docker status` |
| `/env-check` | Valida variables de entorno y detecta secrets | `/env-check` |
| `/migrate-db` | Migraciones de base de datos | `/migrate-db create "add users table"` |
| `/deps` | Gestiona dependencias | `/deps update` |

### Business Flows

| Skill | Que hace | Ejemplo |
|-------|----------|---------|
| `/flows` | Consultar y validar flujos de negocio documentados | `/flows validate` |
| `/flow-test` | Pruebas E2E de flujos completos con Playwright | `/flow-test os fix` |

### Project Management

| Skill | Que hace | Ejemplo |
|-------|----------|---------|
| `/sprint` | Planifica y gestiona sprints | `/sprint plan` |
| `/status` | Dashboard de estado del proyecto | `/status` |
| `/changelog` | Genera changelog desde commits | `/changelog --release` |
| `/adr` | Crea Architecture Decision Record | `/adr "API REST vs GraphQL"` |

### Documentation

| Skill | Que hace | Ejemplo |
|-------|----------|---------|
| `/docs` | Genera documentacion | `/docs api` |

### Onboarding & Estandares

| Skill | Que hace | Ejemplo |
|-------|----------|---------|
| `/init-project` | Inicializa Claude Code en un proyecto existente | `/init-project full` |
| `/learn-project` | Escanea el codigo y extrae estandares reales | `/learn-project backend` |
| `/verify-req` | Verifica un requerimiento contra el codigo real antes de implementar | `/verify-req "agregar email a clientes"` |

---

## Subagentes Especializados

El kit incluye **4 subagentes** que Claude Code puede delegar tareas automaticamente. Cada uno tiene un modelo, herramientas y reglas optimizadas para su trabajo.

### Como funcionan

Los subagentes son "mini-Claude" especializados que se ejecutan en su propio contexto. Claude decide cuando usarlos, o puedes invocarlos manualmente con `@nombre`.

```
# Invocacion automatica (Claude decide)
> Revisa este PR antes de merge
→ Claude delega al agente @reviewer automaticamente

# Invocacion manual con @mencion
> @researcher investiga si Drizzle ORM soporta migraciones automaticas
→ Se ejecuta el agente researcher directamente

# Invocacion explicita
> Usa el agente db-expert para analizar el schema
→ Claude delega al agente db-expert
```

### Agentes incluidos

| Agente | Modelo | Especialidad | Cuando se usa |
|--------|--------|-------------|---------------|
| `@reviewer` | Sonnet | Code review exhaustivo en 6 dimensiones | PRs, reviews, validaciones pre-merge |
| `@researcher` | Sonnet | Investigacion tecnica con busqueda web | Antes de implementar, comparar alternativas |
| `@db-expert` | Sonnet | Base de datos: schema, queries, migraciones | Cambios de BD, optimizacion, modelado |
| `@quick-fix` | Haiku | Correcciones rapidas (lint, typos, imports) | Fixes triviales que no ameritan analisis |

### Detalle de cada agente

**@reviewer** — Revisa codigo en 6 dimensiones:
1. Seguridad (OWASP Top 10)
2. Performance (N+1, memory leaks)
3. Logica de negocio (edge cases)
4. Convenciones (adherencia a CLAUDE.md)
5. Tests (cobertura adecuada)
6. Veredicto final (APROBADO / CAMBIOS REQUERIDOS)

**@researcher** — Investiga antes de implementar:
- Busca documentacion oficial y mejores practicas
- Compara alternativas con pros/contras
- Analiza CVEs y vulnerabilidades conocidas
- Incluye fuentes y URLs en su reporte

**@db-expert** — Experto en base de datos:
- Analiza schema y relaciones
- Detecta indices faltantes y N+1 queries
- Genera migraciones con rollback incluido
- Respeta reglas de seguridad (nunca DROP sin confirmacion)

**@quick-fix** — Rapido para cambios menores:
- Usa Haiku (mas rapido, mas barato)
- Corrige lint errors, imports, typos
- No sobre-analiza: hace el cambio y listo
- Se limita a cambios pequenos

### Personalizar agentes

Crea un archivo en `.claude/agents/nombre/nombre.md`:

```markdown
---
name: mi-agente
description: Descripcion de cuando usar este agente
model: sonnet  # haiku | sonnet | opus
maxTurns: 15
tools:
  - Read
  - Edit
  - Bash
  - Grep
---

# Instrucciones del agente

Eres un agente especializado en...

## Proceso
1. Paso 1
2. Paso 2

## Reglas
- Regla 1
- Regla 2
```

Claude Code detecta automaticamente los agentes en `.claude/agents/`.

---

## Reglas Contextuales (por tipo de archivo)

El kit incluye **6 reglas** que se activan automaticamente segun el tipo de archivo que Claude Code esta editando. Esto asegura que las convenciones correctas se apliquen sin necesidad de recordarselo.

### Como funcionan

Las reglas viven en `.claude/rules/` y usan **glob patterns** para activarse:

```
Editas un archivo .test.ts → Se cargan las reglas de tests automaticamente
Editas un Dockerfile       → Se cargan las reglas de Docker automaticamente
Editas una migracion       → Se cargan las reglas de migraciones automaticamente
```

### Reglas incluidas

| Archivo | Se activa con | Que hace |
|---------|---------------|----------|
| `tests.md` | `*.test.ts`, `*.spec.ts`, `*.test.js` | Estructura de tests, no mocks de BD, independencia |
| `migrations.md` | `**/migrations/**`, `*.migration.ts` | Siempre rollback, nunca DROP sin confirmacion, transacciones |
| `api-routes.md` | `**/routes/**`, `**/controllers/**`, `**/api/**` | Validar input, HTTP semantico, rate limiting, auth |
| `components.md` | `*.tsx`, `*.jsx`, `**/components/**` | Props tipadas, accesibilidad, estados loading/error/empty |
| `env-files.md` | `.env`, `.env.*`, `.env.example` | Nunca commit secrets, documentar variables, UPPER_SNAKE_CASE |
| `docker.md` | `Dockerfile*`, `docker-compose*.yml` | Multi-stage, non-root, HEALTHCHECK, no secrets en Dockerfile |
| `anti-hallucination.md` | `*` (todos los archivos) | Verificar antes de referenciar, usar nombres reales, no inventar |

### Ejemplo: que pasa cuando editas un test

Cuando Claude Code edita `src/users/users.service.spec.ts`, automaticamente carga `rules/tests.md` y sigue estas reglas:

```
✅ Usa describe + it para estructurar
✅ Nombres descriptivos en ingles
✅ Cada test es independiente
✅ Limpia estado en beforeEach/afterEach
❌ NO usa mocks de base de datos en integracion
❌ NO depende del orden de ejecucion
```

### Agregar reglas nuevas

Crea un archivo `.md` en `.claude/rules/`:

```markdown
---
globs: "*.service.ts,**/services/**"
---

# Reglas para servicios

- Cada servicio tiene una sola responsabilidad
- Inyecta dependencias via constructor
- Maneja errores con excepciones tipadas
- Nunca accedas a la BD directamente, usa repositorios
```

---

## MCP Servers (Integracion con servicios externos)

El kit incluye un template `.mcp.json` con configuraciones listas para conectar Claude Code a servicios externos via **Model Context Protocol**.

### Que es MCP

MCP permite que Claude Code acceda a herramientas externas: bases de datos, APIs, servicios de monitoreo, etc. En vez de copiar/pegar datos, Claude consulta directamente.

### Servidores incluidos (templates)

| Servidor | Para que sirve | Que necesitas |
|----------|---------------|---------------|
| **PostgreSQL** | Queries directos, ver schema, analizar tablas | Connection string |
| **SQLite** | Acceso a BD locales ligeras | Path al archivo .sqlite |
| **Filesystem** | Acceso a directorios fuera del proyecto | Ruta al directorio |
| **Brave Search** | Busqueda web desde Claude | API key de Brave |
| **GitHub** | Issues, PRs, repos, actions avanzado | Personal Access Token |
| **Sentry** | Errores, issues, performance en prod | Auth token de Sentry |
| **Slack** | Enviar mensajes, leer canales | Config de Slack |
| **Memory** | Base de conocimiento con grafo de entidades | Ninguno |

### Como configurar

1. Abre `.mcp.json` en tu proyecto
2. Descomenta el servidor que necesites (quita los `//` del nombre y propiedades)
3. Agrega tus credenciales
4. Reinicia Claude Code

**Ejemplo — Conectar PostgreSQL:**

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "postgresql://user:pass@localhost:5432/mydb"]
    }
  }
}
```

Ahora puedes decirle a Claude: "Muestra las ultimas 10 ordenes de la tabla orders" y ejecutara el query directamente.

---

## LSP Servers (Inteligencia de codigo)

El template `.lsp.json` permite conectar **Language Server Protocol** a Claude Code para darle inteligencia de tipos real.

### Que hace un LSP

Sin LSP, Claude lee archivos como texto plano. Con LSP, Claude entiende:
- **Tipos reales** de variables y funciones
- **Errores de compilacion** antes de ejecutar
- **Definiciones** de funciones importadas
- **Autocompletado** informado por el compilador

### Servidores incluidos (templates)

| Servidor | Lenguaje | Comando |
|----------|----------|---------|
| TypeScript | TS/JS | `typescript-language-server --stdio` |
| Python | Python | `pylsp` (requiere python-lsp-server) |
| Go | Go | `gopls serve` |
| Rust | Rust | `rust-analyzer` |
| CSS | CSS/SCSS | `vscode-css-languageserver-bin --stdio` |

### Como configurar

1. Abre `.lsp.json` en tu proyecto
2. Descomenta el servidor de tu lenguaje
3. Reinicia Claude Code

---

## Sistema de Memoria Persistente

El kit incluye `MEMORY.md` como template para el sistema de memoria entre sesiones de Claude Code.

### Que es la memoria

Claude Code puede **recordar informacion entre sesiones**. Cuando cierras y vuelves a abrir Claude, recuerda lo que le pediste que guardara.

### Tipos de memoria

| Tipo | Que guarda | Ejemplo |
|------|-----------|---------|
| **user** | Info sobre ti: rol, preferencias | "Soy frontend senior, nuevo en Go" |
| **feedback** | Correcciones a su comportamiento | "No resumas al final de cada respuesta" |
| **project** | Contexto del proyecto actual | "Merge freeze desde el jueves por release mobile" |
| **reference** | Donde encontrar info externa | "Bugs se trackean en Linear proyecto INGEST" |

### Como usar

```
# Pedirle que recuerde algo
> Recuerda que usamos Stripe para pagos y el webhook esta en /api/webhooks/stripe
> Recuerda que los tests E2E requieren Docker corriendo
> Recuerda que el deploy tarda ~5 minutos en Railway

# Pedirle que olvide algo
> Olvida lo que te dije sobre el deploy, ahora tarda 2 minutos

# Consultar su memoria
> Que recuerdas sobre este proyecto?
```

### Estructura de MEMORY.md

```markdown
# MEMORY.md — Indice de memoria del proyecto

- [Stack del proyecto](memory/project_stack.md) — NestJS + Next.js + PostgreSQL
- [Convenciones](memory/feedback_conventions.md) — PRs bundleados para refactors
- [Deploy info](memory/project_deploy.md) — Pipeline tarda ~5 min en Railway
```

Cada entrada apunta a un archivo con los detalles. Claude crea estos archivos automaticamente cuando le pides que recuerde algo.

---

## Plugin System (Distribucion del kit)

El kit incluye un **plugin manifest** (`.claude-plugin/plugin.json`) que permite distribuirlo como plugin instalable.

### Instalar el kit como plugin

En vez de copiar archivos manualmente, los usuarios pueden instalar el kit directamente:

```bash
# Desde el CLI de Claude Code
/plugin install https://github.com/javierjarquin/Init

# O con flag al iniciar
claude --plugin-dir /ruta/al/starter-kit
```

### Manifest del plugin

```json
{
  "name": "claude-code-starter-kit",
  "description": "Kit completo con 35+ skills, 4 subagentes, reglas contextuales...",
  "version": "2.0.0",
  "author": "javierjarquin",
  "license": "MIT"
}
```

### Crear tu propio plugin

Si quieres empaquetar tus propios skills/agentes como plugin:

1. Crea `.claude-plugin/plugin.json` con name, description, version
2. Agrega tus skills en `skills/` o `commands/`
3. Agrega tus agentes en `agents/`
4. Publica en GitHub
5. Los usuarios instalan con `/plugin install tu-repo`

---

## Keybindings (Atajos de teclado)

El kit incluye un template `keybindings.json` con atajos utiles pre-configurados.

### Como configurar

1. Copia `keybindings.json` a `~/.claude/keybindings.json`
2. Descomenta los atajos que quieras usar
3. Reinicia Claude Code

### Atajos incluidos

| Atajo | Accion | Contexto |
|-------|--------|----------|
| `Ctrl+Enter` | Enviar mensaje | Chat |
| `Ctrl+L` | Limpiar pantalla | App |
| `Escape` | Modo vim normal | Chat |
| `Ctrl+Y` | Aprobar accion rapidamente | Permisos |
| `Ctrl+N` | Rechazar accion | Permisos |
| `Ctrl+Up` | Historial anterior | Chat |
| `Ctrl+Down` | Historial siguiente | Chat |

### Atajos por defecto de Claude Code

| Atajo | Accion |
|-------|--------|
| `Ctrl+D` | Enviar prompt |
| `Ctrl+C` | Cancelar request |
| `Shift+Tab` | Cambiar modo de permisos |
| `Ctrl+B` | Enviar tarea a background |
| `Ctrl+R` | Buscar en historial de comandos |

---

## Sistema Anti-Alucinacion

El kit incluye un sistema de 3 capas para evitar que Claude invente cosas que no existen en tu codigo.

### El problema

Sin proteccion, Claude puede:
- Decir "modifique la funcion `calcularTotal`" cuando la funcion se llama `CalcTotal` o no existe
- Asumir que una tabla se llama `customers` cuando en tu BD es `CLIENTES`
- Inventar rutas de archivos: `src/services/auth.ts` cuando tu proyecto usa `src/modules/auth/auth.service.ts`
- Decir "el endpoint POST /api/users" cuando en tu codigo es `POST /usuarios`

### Las 3 capas de proteccion

```
CAPA 1: Hook UserPromptSubmit (ANTES de cada respuesta)
  → Inyecta recordatorio: "Busca antes de referenciar"
  → Se ejecuta automaticamente en CADA mensaje

CAPA 2: Regla anti-hallucination.md (DURANTE la respuesta)
  → Globs: "*" (aplica a todos los archivos)
  → Reglas: verificar antes de referenciar, usar nombres reales,
    leer antes de editar, decir claramente si no encuentra algo

CAPA 3: Skill /verify-req (ANTES de implementar)
  → Invocacion manual para requerimientos complejos
  → Descompone suposiciones y verifica cada una contra el codigo
  → Genera tabla con nombres REALES vs nombres asumidos
```

### Capa 1: Hook automatico

Cada vez que envias un mensaje, Claude recibe este recordatorio:

```
🔍 ANTI-HALLUCINATION REMINDER: Before referencing any function, table,
file or endpoint — SEARCH for it first. Use REAL names from the code,
not assumed names. If you cannot find it, say so clearly.
```

No necesitas hacer nada — se inyecta automaticamente.

### Capa 2: Regla global

El archivo `.claude/rules/anti-hallucination.md` se carga con **cualquier archivo** que Claude toque. Incluye:

- NUNCA menciones algo sin haberlo BUSCADO primero
- Usa nombres EXACTOS del codigo, no los del requerimiento
- Si no lo encontraste, NO EXISTE — dilo claramente
- NUNCA edites un archivo que no hayas leido
- No inventes metricas, tiempos o conteos

### Capa 3: Skill `/verify-req`

Para requerimientos complejos, usalo antes de implementar:

```
> /verify-req "agregar campo email a tabla clientes"

## Verificacion de requerimiento

### Suposiciones verificadas
| # | Suposicion | Estado | Evidencia |
|---|-----------|--------|-----------|
| 1 | Tabla "clientes" existe | ✅ EXISTE | sql/schema.sql:45 (se llama CLIENTES) |
| 2 | Campo email no existe | ✅ CONFIRMADO | No encontrado en schema |
| 3 | Modelo TCliente existe | ✅ EXISTE | src/models/Cliente.pas:12 |
| 4 | Form de clientes existe | ✅ EXISTE | src/forms/frmClientes.pas |

### Nombres REALES (usa estos, no otros)
| Concepto | Nombre REAL | Ubicacion |
|----------|-------------|-----------|
| Tabla | CLIENTES | sql/schema.sql:45 |
| PK | CLIENTE_ID | sql/schema.sql:46 |
| Modelo | TCliente | src/models/Cliente.pas:12 |
| Form | TfrmClientes | src/forms/frmClientes.pas:1 |

¿Procedo con la implementacion?
```

### Ejemplo: antes vs despues

**Sin proteccion (alucina):**
```
Tu: "agrega email a clientes"
Claude: "Listo, modifique el modelo Customer en src/models/customer.ts,
         actualice la migracion en src/database/migrations/ y
         el endpoint GET /api/customers ahora retorna el email."

→ Pero tu proyecto es Delphi, la tabla es CLIENTES, el modelo
  es TCliente, y no hay endpoints REST.
```

**Con proteccion (verifica):**
```
Tu: "agrega email a clientes"
Claude: "Busque en el proyecto:
  - Tabla encontrada: CLIENTES en sql/schema.sql:45
  - Modelo encontrado: TCliente en src/models/Cliente.pas:12
  - Form encontrado: TfrmClientes en src/forms/frmClientes.pas
  - Campo EMAIL: no existe actualmente

  El campo en la tabla se llama con UPPER_CASE (ej: NOMBRE, TELEFONO).
  Voy a crear el campo como EMAIL VARCHAR(100).
  ¿Procedo?"
```

---

## GitHub Actions Workflows

El kit incluye 4 workflows CI/CD listos para adaptar a tu proyecto:

### CI (`ci.yml`) — En cada PR

```
PR abierto → Lint → Typecheck → Unit Tests → E2E Tests → Build Check
```

- Corre en PRs a `main` y `development`
- Cancela runs anteriores del mismo PR (ahorra minutos)
- Sube reporte de coverage como artifact
- Sube reporte de Playwright si E2E falla

### CD Development (`cd-dev.yml`) — Al merge en development

```
Merge a development → Build → Deploy → Health Check → Notify
```

- Incluye templates para: **Vercel, Railway, Fly.io, Docker**
- Health check automatico post-deploy
- Solo necesitas desconmentar tu proveedor y agregar secrets

### CD Production (`cd-prod.yml`) — Al merge en main

```
Merge a main → Pre-checks completos → Deploy (con approval) → Health Check → GitHub Release
```

- **Requiere aprobacion manual** via GitHub Environments
- Pre-checks: lint + typecheck + tests + build
- Crea GitHub Release automatico con los ultimos commits
- Rollback automatico si health check falla (opcional)

### Security (`security.yml`) — Semanal + en PRs

```
Lunes 8AM UTC → Dependency Audit → Secret Detection → Code Analysis
```

- **TruffleHog** para detectar secrets en el historial de git
- Patrones de secrets: API keys, passwords, .env files, private keys
- Analisis de codigo: SQL injection, XSS, eval, command injection
- Opcional: CodeQL de GitHub para analisis profundo

### Como configurar los workflows

1. **Cambia el package manager** en `ci.yml` (default: pnpm)
2. **Elige tu proveedor de deploy** en `cd-dev.yml` y `cd-prod.yml` (descomenta la opcion)
3. **Agrega secrets en GitHub** (Settings > Secrets > Actions):
   - Deploy: `VERCEL_TOKEN`, `RAILWAY_TOKEN`, `FLY_API_TOKEN`, etc.
   - Docker: `DOCKER_USERNAME`, `DOCKER_PASSWORD`, `DOCKER_REGISTRY`
4. **Crea el environment "production"** en GitHub (Settings > Environments) para requerir approval

---

## Safety Guards (Protecciones de Seguridad)

El kit incluye **hooks de seguridad activos** que BLOQUEAN operaciones peligrosas automaticamente. Esto evita que Claude Code (o tu) ejecute algo destructivo por accidente.

### Operaciones bloqueadas por hooks

| Operacion | Por que se bloquea | Alternativa segura |
|-----------|--------------------|--------------------|
| `git push --force` | Reescribe historial, puede borrar trabajo | `git push --force-with-lease` o push normal |
| `git push origin main` | Push directo a produccion sin review | Crear PR con `/deploy-prod` |
| `git reset --hard` | Descarta cambios sin guardar | `git stash` o `git revert` |
| `migrate reset` / `db reset` | **Borra TODA la base de datos** | `/migrate-db rollback` (solo dev) |
| `DROP TABLE` / `DROP DATABASE` | Irreversible sin backup | Crear migracion inversa |
| `TRUNCATE TABLE` | Elimina todos los registros | `DELETE` con `WHERE` |

Estos hooks estan en `settings.local.json` y se activan automaticamente al instalar el kit.

### Branch Protection (configurar en GitHub)

Despues de instalar el kit, configura branch protection en GitHub:

**Settings > Branches > Branch protection rules:**

Para `main` y `development`:
- Require pull request before merging
- Require at least 1 approval
- Require status checks to pass (CI workflow)
- Do not allow force pushes
- Do not allow deletions

### Ejemplo real: lo que los hooks previenen

```
Tu: "corrige este bug y deployealo"
Claude: git push --force origin main
Hook: ❌ BLOCKED: Force push detected.

Tu: "la BD esta rara, reseteala"
Claude: npx prisma migrate reset
Hook: ❌ BLOCKED: Destructive database operation detected. Use /migrate-db rollback instead.

Tu: "borra la tabla de pruebas"
Claude: DROP TABLE test_data;
Hook: ❌ BLOCKED: Destructive database operation detected.
```

Sin estos hooks, un simple "corrige y deployea" podria terminar en un force push a main o un reset de BD. **A mi me paso con mi agendita.** Por eso existen.

---

## Hooks de Automatizacion

El kit incluye **8 hooks pre-configurados** en `settings.local.json` que se ejecutan automaticamente:

### Hooks activos en el kit

| Hook | Matcher | Que hace |
|------|---------|----------|
| `SessionStart` | — | Log de inicio con timestamp |
| `PreToolUse` | Bash | Bloquea force push |
| `PreToolUse` | Bash | Bloquea DROP TABLE / migrate reset |
| `PreToolUse` | Bash | Bloquea push directo a main |
| `PreToolUse` | Bash | Bloquea git reset --hard |
| `PreToolUse` | Edit\|Write | Log de modificacion de archivos |
| `PostToolUse` | Bash | Log de comandos ejecutados |
| `Stop` | — | Log de fin de sesion |
| `UserPromptSubmit` | — | Log de prompts recibidos |
| `SubagentStop` | — | Log de subagentes completados |
| `FileChanged` | .env | Alerta si se modifica .env |
| `FileChanged` | package.json | Recuerda correr install |

### Todos los hooks disponibles

| Hook | Cuando se ejecuta | Ejemplo de uso |
|------|-------------------|----------------|
| `SessionStart` | Al iniciar sesion | Cargar contexto, verificar servicios |
| `SessionEnd` | Al cerrar Claude Code | Cleanup final |
| `UserPromptSubmit` | Cuando envias un mensaje | Validar formato, logging |
| `PreToolUse` | Antes de ejecutar herramienta | **Bloquear operaciones peligrosas** |
| `PostToolUse` | Despues de ejecutar herramienta | Logging, notificaciones |
| `PostToolUseFailure` | Cuando una herramienta falla | Alertas, retry logic |
| `Stop` | Al terminar de responder | Guardar estado, notificar |
| `SubagentStart` | Al crear un subagente | Tracking de subagentes |
| `SubagentStop` | Al terminar un subagente | Quality gates, cleanup |
| `FileChanged` | Cuando un archivo cambia | Alertas de archivos criticos |
| `PreCompact` | Antes de comprimir contexto | Preservar info critica |
| `PostCompact` | Despues de comprimir | Recargar contexto necesario |
| `WorktreeCreate` | Al crear worktree de git | Setup de entorno |
| `WorktreeRemove` | Al eliminar worktree | Cleanup |
| `InstructionsLoaded` | Al cargar CLAUDE.md | Validar configuracion |
| `PermissionRequest` | Al pedir permiso | Auto-aprobar/denegar |
| `ConfigChange` | Al cambiar configuracion | Notificar cambios |

### Ejemplos de hooks avanzados

**Notificar por Slack al terminar sesion:**
```json
{
  "Stop": [{
    "hooks": [{
      "type": "command",
      "command": "curl -s -X POST https://hooks.slack.com/services/XXX -d '{\"text\":\"Claude Code session ended\"}'"
    }]
  }]
}
```

**Bloquear edicion de archivos criticos:**
```json
{
  "PreToolUse": [{
    "matcher": "Edit",
    "hooks": [{
      "type": "command",
      "command": "if echo \"$TOOL_INPUT\" | grep -qE 'production\\.config|secrets\\.'; then echo '❌ BLOCKED: Cannot edit production config files' && exit 1; fi"
    }]
  }]
}
```

**Auto-lint despues de editar:**
```json
{
  "PostToolUse": [{
    "matcher": "Edit|Write",
    "hooks": [{
      "type": "command",
      "command": "echo '🔍 Verificando formato...'"
    }]
  }]
}
```

**Alerta cuando cambia el schema de BD:**
```json
{
  "FileChanged": [{
    "matcher": "schema.prisma",
    "hooks": [{
      "type": "command",
      "command": "echo '⚠️ Schema changed — run prisma generate and create migration'"
    }]
  }]
}
```

---

## Workflows Completos (Ejemplos)

### Workflow 1: Nueva feature de principio a fin

```
# 1. Planificar
> /sprint plan
→ Claude lista issues, prioriza con MoSCoW, estima con T-shirt sizing

# 2. Verificar entorno
> /env-check
→ Claude valida que todas las variables estan configuradas

# 3. Levantar servicios
> /docker up
→ Claude levanta BD, cache y servicios con docker-compose

# 4. Crear feature
> /feature "payment-methods"
→ Claude crea branch, scaffold backend + frontend, registra modulo

# 5. Desarrollar (conversacion normal con Claude)
> Implementa el endpoint POST /payments/methods que reciba tipo y datos del metodo de pago

# 6. Tests
> /test-unit create payment-methods
→ Claude crea specs con mocks, corre los tests

# 7. Accesibilidad
> /a11y page /payments
→ Claude audita accesibilidad de la pagina de pagos

# 8. Review
> /review-pr
→ Claude revisa seguridad, performance, convenciones, logica y calidad

# 9. Deploy
> /deploy-dev
→ Claude hace commit, push, crea PR a development
→ CI corre automaticamente: lint + typecheck + tests + build

# 10. QA
> /qa payment
→ Claude ejecuta E2E tests del flujo de pagos

# 11. Produccion
> /deploy-prod
→ Claude pide confirmacion, mergea a main, verifica health check
→ CD corre automaticamente: pre-checks + deploy + release
```

### Workflow 2: Bug critico en produccion

```
# 1. Diagnosticar
> /debug "500 error en /api/payments"
→ Claude busca el error, traza el request, identifica causa raiz

# 2. Hotfix
> /hotfix "payment processing null pointer"
→ Claude crea branch desde main, aplica fix minimo, crea PR directo a main

# 3. Verificar
> /status
→ Claude verifica health checks post-deploy

# 4. Documentar
> Claude pregunta si necesita postmortem (SEV-1/SEV-2 obligatorio)
```

### Workflow 3: Auditoria completa del proyecto

```
# 1. Seguridad
> /security-scan
→ Escanea dependencias, secrets, codigo — reporte OWASP Top 10

# 2. Performance
> /perf api
→ Detecta N+1 queries, endpoints lentos, falta de cache

# 3. Accesibilidad
> /a11y
→ Auditoria WCAG 2.1 completa del frontend

# 4. Coherencia
> /audit all
→ Verifica que frontend y backend estan alineados

# 5. Variables de entorno
> /env-check secrets
→ Verifica que no hay secrets filtrados en el repo

# 6. Limpieza
> /cleanup all
→ Elimina imports no usados, dead code, console.logs

# 7. Dependencias
> /deps update
→ Actualiza dependencias con verificacion de breaking changes
```

### Workflow 4: Onboarding de nuevo proyecto

```
# 1. Documentar
> /docs onboarding
→ Genera guia paso a paso para nuevos developers

# 2. Documentar API
> /docs api
→ Lista todos los endpoints con DTOs y roles

# 3. Arquitectura
> /docs architecture
→ Genera diagrama Mermaid de la arquitectura

# 4. Variables de entorno
> /env-check generate
→ Genera .env.example con todas las variables del codigo

# 5. Docker
> /docker create
→ Genera Dockerfile + docker-compose.yml optimizados
```

### Workflow 5: Release semanal

```
# 1. Status
> /sprint status
→ Ver progreso del sprint, issues completados vs pendientes

# 2. Cerrar sprint
> /sprint close
→ Retrospectiva automatica, mover pendientes al siguiente sprint

# 3. Changelog
> /changelog --release
→ Genera changelog y crea GitHub Release

# 4. Deploy
> /deploy-prod
→ Merge a main con verificacion completa

# 5. Si algo falla
> /rollback prod
→ Revierte al deploy anterior inmediatamente
```

### Workflow 6: Quality gate completo (antes de release)

```
# 1. Code review tecnico
> /code-review --full
→ Claude aplica checklist de 10 puntos: hydration, RLS, CSS, forms, auth, etc.

# 2. Standards check
> /standards
→ Verifica patrones correctos vs incorrectos en todo el proyecto

# 3. Validacion pre-merge
> /validate --fix
→ Code review + refactor + TypeScript build + smoke test con Playwright

# 4. Accesibilidad
> /a11y fix
→ Audita y corrige problemas de accesibilidad automaticamente

# 5. Business flow testing
> /flow-test completo fix
→ Ejecuta todos los flujos de negocio E2E, corrige fallos automaticamente

# 6. UX Review
> /ux-review
→ Screenshots desktop + mobile, checa layout, botones, responsive

# 7. QA final
> /qa all
→ Ejecuta suite E2E completa

# 8. Si todo pasa → deploy
> /deploy-prod
```

### Workflow 7: Nuevo proyecto desde cero

```
# 1. Clonar el starter kit
git clone https://github.com/javierjarquin/Init.git claude-code-starter-kit
cd claude-code-starter-kit
setup.bat C:\ruta\a\mi-nuevo-proyecto

# 2. Configurar CLAUDE.md con tu stack
> Abre CLAUDE.md y reemplaza los placeholders

# 3. Configurar Docker
> /docker create
→ Genera Dockerfile + docker-compose.yml para tu stack

# 4. Generar .env.example
> /env-check generate
→ Escanea el codigo y genera template de variables

# 5. Crear la feature principal
> /feature "core-module"

# 6. Documentar flujos de negocio
> /flows add "order-lifecycle"

# 7. Crear tests E2E
> /e2e create "main flow"

# 8. Review completo
> /validate --fix

# 9. Deploy
> /deploy-dev
```

### Workflow 8: Setup de infraestructura Docker

```
# 1. Crear archivos Docker
> /docker create
→ Genera Dockerfile multi-stage + docker-compose.yml + .dockerignore

# 2. Levantar servicios
> /docker up
→ Levanta app + BD + Redis con docker-compose

# 3. Verificar estado
> /docker status
→ Tabla con estado de cada contenedor y puertos

# 4. Ver logs si hay problemas
> /docker logs api
→ Muestra logs del servicio API con analisis de errores

# 5. Limpiar cuando termines
> /docker clean
→ Elimina imagenes y volumenes sin usar
```

### Workflow 9: Verificacion de entorno y seguridad

```
# 1. Verificar variables
> /env-check
→ Tabla comparativa: variables en codigo vs .env vs .env.example

# 2. Detectar secrets filtrados
> /env-check secrets
→ Verifica que no hay API keys, passwords o .env en el repo

# 3. Generar template
> /env-check generate
→ Crea/actualiza .env.example con todas las variables agrupadas

# 4. Scan de seguridad
> /security-scan
→ Complementa con escaneo OWASP completo
```

---

## Process Docs incluidos

### Definition of Done (`docs/procesos/DEFINITION_OF_DONE.md`)
Checklist que define cuando un cambio esta "terminado". Cubre:
- Cualquier cambio de codigo
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
- Proceso: deteccion → triaje → contencion → resolucion → postmortem
- Template de postmortem

### Runbooks (`docs/procesos/RUNBOOKS.md`)
Guias operacionales para problemas comunes:
- API no responde
- BD lenta
- Cache caido
- Migracion falla
- Servicio externo caido
- Deploy falla
- Rollback
- Problema de seguridad

---

## GitHub Templates incluidos

### Pull Request Template
Estructura cada PR con:
- Resumen de cambios
- Tipo (fix/feat/refactor/etc.)
- Modulos afectados
- Contexto QA (si aplica)
- Evidencia antes/despues
- Checklist de verificacion

### Issue Templates
- **Bug Report**: Pasos para reproducir, impacto, evidencia
- **Feature Request**: Problema → solucion → alternativas → criterios
- **QA Finding**: ID, flujo, test E2E, error, analisis, recomendacion

---

## Personalizacion

### Agregar un skill nuevo

Crea un archivo `.md` en `.claude/commands/`:

```markdown
# /mi-skill — Descripcion corta

Descripcion de que hace este skill.

## Uso
/mi-skill arg1       → Que hace con arg1
/mi-skill arg2       → Que hace con arg2

## Instrucciones

1. **Paso 1**: Que debe hacer Claude
2. **Paso 2**: Siguiente accion
3. **Paso 3**: Resultado esperado
```

Claude Code detecta automaticamente los archivos en `.claude/commands/`.

### Agregar un subagente nuevo

Crea un directorio y archivo en `.claude/agents/nombre/nombre.md` con frontmatter YAML. Ver seccion "Subagentes Especializados" arriba.

### Agregar reglas contextuales

Crea un archivo `.md` en `.claude/rules/` con frontmatter que incluya `globs`. Ver seccion "Reglas Contextuales" arriba.

### Conectar servicios externos (MCP)

Edita `.mcp.json` para conectar bases de datos, APIs, Slack, etc. Ver seccion "MCP Servers" arriba.

### Personalizar hooks

Edita `.claude/settings.local.json` para agregar hooks que se ejecutan automaticamente. Ver seccion "Hooks de Automatizacion" arriba.

### Configurar atajos de teclado

Copia `keybindings.json` a `~/.claude/keybindings.json` y descomenta los atajos. Ver seccion "Keybindings" arriba.

### Usar el sistema de memoria

Pidele a Claude que "recuerde" informacion importante:
```
> Recuerda que usamos Stripe para pagos y el webhook esta en /api/webhooks/stripe
> Recuerda que el deploy tarda ~5 minutos
> Recuerda que los tests E2E requieren Docker corriendo
```

Claude guarda la informacion en `MEMORY.md` y archivos asociados, y la recuerda en sesiones futuras.

---

## Tips para aprovechar Claude Code al 100%

### 1. CLAUDE.md es tu arma secreta
Mientras mas completo este tu CLAUDE.md, mejor sera Claude Code. Incluye:
- Estructura del proyecto
- Comandos comunes
- Convenciones de codigo
- Patrones criticos que no deben romperse
- URLs de cada entorno

### 2. Usa skills en cadena
Los skills se complementan entre si:
```
/env-check → /docker up → /feature → /test-unit create → /a11y → /review-pr → /deploy-dev → /qa → /deploy-prod
```

### 3. Deja que Claude planifique antes de ejecutar
Para tareas complejas, pidele que planifique primero:
```
> Necesito migrar de REST a GraphQL. No hagas cambios aun, solo dame un plan.
```

### 4. Usa el sistema de memoria
```
> Recuerda que siempre hay que correr /security-scan antes de un release
> Recuerda que el modulo de pagos esta en mantenimiento hasta marzo
```

### 5. Combina con GitHub CLI
Claude Code tiene integracion nativa con `gh`:
```
> Crea un issue para el bug que encontraste
> Lista los PRs pendientes de review
> Cierra el issue #42 con el fix que acabamos de hacer
```

### 6. Delega con @subagentes
Usa `@nombre` para invocar subagentes directamente:
```
> @reviewer revisa los cambios antes de merge
> @researcher investiga alternativas a Redis para cache
> @db-expert analiza el schema de la tabla orders
> @quick-fix corrige los errores de lint
```

### 7. Conecta servicios con MCP
Conecta BD, Slack, Sentry, GitHub directamente a Claude:
```
# Con MCP de PostgreSQL activo:
> Muestra las ultimas 10 ordenes de la tabla orders
> Cuantos usuarios se registraron esta semana?

# Con MCP de Sentry activo:
> Cuales son los errores mas frecuentes en produccion?
```

### 8. Aprovecha las reglas contextuales
Las reglas en `.claude/rules/` se activan automaticamente. No necesitas recordarle a Claude las convenciones — las carga segun el archivo que edita.

### 9. Programa tareas recurrentes
Usa `/loop` o tareas programadas para automatizar:
```
> /loop 30m /status          → Dashboard cada 30 min
> /loop 1h /security-scan    → Escaneo cada hora
```

### 10. Aprovecha los workflows de CI/CD
Los GitHub Actions workflows corren automaticamente. Cuando haces `/deploy-dev`, el CI verifica tu codigo sin que tengas que hacer nada extra.

---

## Compatibilidad

| Feature | Node.js | Python | Go | Ruby | Rust |
|---------|:-------:|:------:|:--:|:----:|:----:|
| 38 Skills | ✅ | ✅ | ✅ | ✅ | ✅ |
| 4 Subagentes | ✅ | ✅ | ✅ | ✅ | ✅ |
| 7 Reglas contextuales | ✅ | ✅ | ✅ | ✅ | ✅ |
| Hooks de seguridad | ✅ | ✅ | ✅ | ✅ | ✅ |
| MCP Servers | ✅ | ✅ | ✅ | ✅ | ✅ |
| LSP Servers | TS/JS | pylsp | gopls | — | rust-analyzer |
| Sistema de memoria | ✅ | ✅ | ✅ | ✅ | ✅ |
| GitHub Actions | ✅ | ✅ | ✅ | ✅ | ✅ |
| Plugin system | ✅ | ✅ | ✅ | ✅ | ✅ |

Todo es **agnostico al lenguaje** excepto LSP (que depende del language server disponible). Claude Code adapta los comandos segun el stack definido en CLAUDE.md.

---

## FAQ

### Necesito Claude Code CLI o funciona en VS Code?
Funciona en ambos. Los slash commands, agentes y reglas se detectan automaticamente.

### Puedo usar esto con un proyecto que no es monorepo?
Si. Todo es generico. Solo ajusta las rutas en CLAUDE.md.

### Los skills funcionan con cualquier lenguaje?
Si. Claude Code lee CLAUDE.md para entender tu stack y adapta los comandos. Por ejemplo, `/test-unit` usa `pnpm test` para Node.js, `pytest` para Python, `go test` para Go, etc.

### Puedo agregar mis propios skills/agentes/reglas?
Si. Crea archivos `.md` en `.claude/commands/`, `.claude/agents/nombre/` o `.claude/rules/` y Claude Code los detecta automaticamente. Ver seccion "Personalizacion".

### Los subagentes cuestan mas tokens?
Si, cada subagente usa su propio contexto. Pero Haiku (`@quick-fix`) es muy economico, y delegar evita contaminar tu contexto principal.

### Como conecto mi base de datos a Claude Code?
Configura el MCP server de PostgreSQL/SQLite en `.mcp.json`. Ver seccion "MCP Servers".

### Las reglas contextuales afectan el rendimiento?
No. Solo se cargan cuando Claude edita archivos que matchean el glob pattern.

### Puedo instalar el kit como plugin?
Si. Usa `/plugin install https://github.com/javierjarquin/Init` o `claude --plugin-dir /ruta/al/kit`.

### Los hooks bloquean a Claude automaticamente?
Si. Los hooks `PreToolUse` con `exit 1` bloquean la operacion antes de que se ejecute. Claude recibe el mensaje de error y busca una alternativa segura.

### Como configuro approval para produccion?
En GitHub: Settings > Environments > New environment "production" > Required reviewers.

### Como programo tareas recurrentes?
Usa `/loop intervalo /skill` en la sesion. Para tareas programadas fuera de sesion, usa `/schedule`.

---

## Licencia

MIT — Usa, modifica y comparte libremente.
