# CLAUDE.md — {{PROJECT_NAME}}

> **Instrucciones para Claude Code.** Este archivo define las reglas, convenciones y contexto del proyecto.
> Reemplaza todos los `{{PLACEHOLDER}}` con los valores de tu proyecto.

## Project Overview

**{{PROJECT_NAME}}** — {{PROJECT_DESCRIPTION}}

## Monorepo Structure

```
{{DIRECTORY_STRUCTURE}}
# Ejemplo:
# apps/
#   api/          → Backend (NestJS / Express / FastAPI)
#   web/          → Frontend (Next.js / Nuxt / SvelteKit)
# packages/
#   shared/       → Shared types & constants
# docs/           → Documentation
# .github/        → CI/CD workflows
```

**Package manager:** {{PACKAGE_MANAGER}} (npm / pnpm / yarn / bun)

## Tech Stack

| Layer       | Technology                     |
|-------------|--------------------------------|
| Backend     | {{BACKEND_TECH}}               |
| Frontend    | {{FRONTEND_TECH}}              |
| Database    | {{DATABASE_TECH}}              |
| ORM         | {{ORM_TECH}}                   |
| Auth        | {{AUTH_TECH}}                   |
| Deployment  | {{DEPLOY_TECH}}                |
| Monitoring  | {{MONITORING_TECH}}            |

## Common Commands

```bash
# Install dependencies
{{INSTALL_CMD}}

# Development
{{DEV_CMD}}

# Build
{{BUILD_CMD}}

# Lint
{{LINT_CMD}}

# Format
{{FORMAT_CMD}}

# Run tests (unit)
{{TEST_CMD}}

# Run tests (e2e)
{{TEST_E2E_CMD}}

# Run tests (coverage)
{{TEST_COV_CMD}}

# Type check
{{TYPECHECK_CMD}}
```

## Architecture

{{ARCHITECTURE_NOTES}}
<!-- Documenta aquí los patrones arquitectónicos principales:
- Multi-tenancy (si aplica)
- Middleware stack
- Module organization
- State management
- Caching strategy
-->

## Security

{{SECURITY_NOTES}}
<!-- Documenta aquí:
- Auth strategy (JWT, sessions, OAuth)
- RBAC roles
- Rate limiting config
- Encryption
- Audit logging
-->

## Coding Conventions

### General

- Language: **TypeScript** (strict mode) — o el lenguaje principal del proyecto.
- Commit messages: **{{COMMIT_LANGUAGE}}** (español/inglés), conventional commits format: `fix:`, `feat:`, `chore:`, etc.
- Code and variable names: **English**.
- Comments: **{{COMMENT_LANGUAGE}}** for business logic, English for technical comments.

### Backend

{{BACKEND_CONVENTIONS}}
<!-- Ejemplo:
- One module per domain feature
- DTOs validate all input
- Services contain business logic — controllers are thin
- Test files collocated: *.spec.ts
-->

### Frontend

{{FRONTEND_CONVENTIONS}}
<!-- Ejemplo:
- App Router with route groups
- Components organized by feature
- API calls via React Query hooks
- Path alias: @/* maps to src/*
-->

### Database

{{DB_CONVENTIONS}}
<!-- Ejemplo:
- Schema at apps/api/prisma/schema.prisma
- Always run prisma:generate after schema changes
- Never raw SQL without parameterization
-->

## Environment Variables

Required variables documented in `.env.example`. Key groups:

{{ENV_VARS_DOCS}}
<!-- Lista las variables agrupadas por función -->

## Testing

- **Unit tests:** {{TEST_FRAMEWORK}} — `{{TEST_CMD}}`
- **E2E tests:** {{E2E_FRAMEWORK}} — `{{TEST_E2E_CMD}}`
- Always run tests before submitting a PR.

## CI/CD

- **CI:** {{CI_DESCRIPTION}}
- **Deploy:** {{DEPLOY_DESCRIPTION}}
- Health check: `{{HEALTH_CHECK_URL}}`

## Important Patterns to Preserve

1. {{PATTERN_1}}
2. {{PATTERN_2}}
3. {{PATTERN_3}}
<!-- Lista los patrones críticos que NUNCA deben romperse -->

## Git Workflow

- **Main branch:** `main`
- **Development branch:** `development`
- PRs: feature branches → `development` → `main`
- Commit messages: {{COMMIT_STYLE}}

## URLs

| Environment | API | Web |
|-------------|-----|-----|
| Local       | `{{LOCAL_API_URL}}` | `{{LOCAL_WEB_URL}}` |
| Development | `{{DEV_API_URL}}` | `{{DEV_WEB_URL}}` |
| Production  | `{{PROD_API_URL}}` | `{{PROD_WEB_URL}}` |
