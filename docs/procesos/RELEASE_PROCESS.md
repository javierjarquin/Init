# Release Process

## Flujo de branches

```
feature/xxx ──► development ──► main (producción)
fix/xxx     ──►      │
test/xxx    ──►      │
                     │
              staging (futuro)
```

## Proceso de release

### 1. Preparación (en `development`)

```bash
git checkout development
git pull origin development

# Verificar que CI pasa:
# - Lint + Type Check ✅
# - Unit Tests ✅
# - Security Audit ✅
# - E2E Tests ✅
```

### 2. Crear release branch (opcional para releases grandes)

```bash
git checkout -b release/v1.X.0
# Solo bug fixes en este branch, no features nuevas
```

### 3. Generar changelog

```bash
# Revisar commits desde el último release
git log --oneline $(git describe --tags --abbrev=0)..HEAD

# Usar /changelog para generar automáticamente
```

### 4. Crear tag y merge a main

```bash
git checkout main
git pull origin main
git merge development --no-ff

# Crear tag
git tag -a v1.X.0 -m "Release v1.X.0: descripción breve"
git push origin main --tags
```

### 5. Verificación post-deploy

```bash
# Health check del API
curl {PROD_API_URL}/health

# Verificar frontend
curl -s -o /dev/null -w "%{http_code}" {PROD_WEB_URL}

# Verificar errores en monitoreo (Sentry, etc.)
```

### 6. Comunicación

- [ ] Release notes publicadas en GitHub Releases
- [ ] Notificar al equipo (si aplica)
- [ ] Actualizar docs si hay cambios de API

## Versionado (SemVer)

- **MAJOR** (v2.0.0): Cambios breaking en la API
- **MINOR** (v1.1.0): Nuevas funcionalidades backwards-compatible
- **PATCH** (v1.0.1): Bug fixes y hotfixes

## Hotfix process

Para bugs críticos en producción:

```bash
git checkout main
git checkout -b hotfix/descripcion-breve
# Fix + test
git push -u origin hotfix/descripcion-breve
# PR directo a main (excepción)
# Después: cherry-pick o merge a development
```

## Rollback

Si algo sale mal post-deploy:
1. Redeploy del commit anterior desde la plataforma de deploy
2. O: `git revert HEAD && git push`
3. Si es de BD: crear migración inversa (NUNCA reset en producción)
