# /changelog — Generate changelog from commits

Genera un changelog legible desde los conventional commits.

## Uso
```
/changelog                → Changelog desde el último tag
/changelog v1.0.0..HEAD   → Rango específico
/changelog --release       → Generar + crear GitHub Release
```

## Instrucciones

1. **Obtener commits** desde el último tag (o rango):
   ```bash
   git log --oneline $(git describe --tags --abbrev=0 2>/dev/null || echo "HEAD~50")..HEAD
   ```

2. **Agrupar por tipo** (conventional commits):
   - `feat:` → **Nuevas funcionalidades**
   - `fix:` → **Correcciones**
   - `perf:` → **Mejoras de rendimiento**
   - `docs:` → **Documentación**
   - `refactor:` → **Refactoring**
   - `test:` → **Tests**
   - `chore:` / `ci:` → **Mantenimiento**

3. **Generar markdown**:
   ```markdown
   # Changelog — vX.Y.Z (YYYY-MM-DD)

   ## Nuevas funcionalidades
   - feat(scope): descripción (#PR)

   ## Correcciones
   - fix(scope): descripción (#PR)

   ## Mantenimiento
   - chore(scope): descripción (#PR)
   ```

4. **Guardar** en `CHANGELOG.md` en la raíz del proyecto

5. **Si --release**: Crear GitHub Release:
   ```bash
   gh release create vX.Y.Z --title "vX.Y.Z" --notes-file CHANGELOG.md
   ```

## Versionado (SemVer)
- **MAJOR** (X): Breaking changes
- **MINOR** (Y): Nuevas features
- **PATCH** (Z): Bug fixes
