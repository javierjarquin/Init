# /init-project — Inicializa Claude Code en un proyecto existente

Configura Claude Code en un proyecto que ya tiene codigo. Detecta el stack, genera CLAUDE.md, copia los archivos necesarios y extrae los estandares automaticamente.

## Uso
```
/init-project              → Setup completo interactivo
/init-project minimal      → Solo CLAUDE.md + settings + hooks
/init-project full         → Todo: skills + agentes + reglas + CI + docs
```

## Instrucciones

### Paso 1: Diagnostico rapido

Analiza el proyecto actual:

1. **Existe CLAUDE.md?** → Si tiene placeholders `{{}}`, necesita configurarse
2. **Existe .claude/?** → Verificar que tiene commands, settings, agents, rules
3. **Existe .github/workflows/?** → Verificar CI/CD
4. **Cual es el stack?** → Detectar lenguaje, framework, BD, test framework

Presenta:
```
## Diagnostico del proyecto

Estado actual:
  CLAUDE.md:         ❌ No existe / ⚠️ Tiene placeholders / ✅ Configurado
  Skills:            ❌ 0/36 / ⚠️ N/36 / ✅ 36/36
  Agentes:           ❌ 0/4 / ✅ N/4
  Reglas:            ❌ 0 / ✅ N reglas
  Hooks:             ❌ Sin hooks / ✅ N hooks activos
  CI/CD:             ❌ Sin workflows / ✅ N workflows
  MCP:               ❌ Sin config / ✅ Configurado
  Memoria:           ❌ Sin MEMORY.md / ✅ Configurado

Stack detectado:
  Lenguaje:    [auto-detectado]
  Framework:   [auto-detectado]
  BD:          [auto-detectado]
  Tests:       [auto-detectado]

¿Que quieres instalar? (completo/minimal/seleccionar)
```

### Paso 2: Generar CLAUDE.md

Si no existe o tiene placeholders, genera uno completo basado en el analisis:

- Rellena Tech Stack con lo detectado
- Rellena Common Commands buscando scripts en package.json, Makefile, etc.
- Rellena Monorepo Structure con la estructura real
- Rellena Coding Conventions basandose en el codigo existente
- Mantiene las Safety Rules del template original

### Paso 3: Instalar componentes

Segun la opcion elegida, crea/copia los archivos necesarios:

**Minimal** (lo esencial):
```
.claude/settings.local.json    ← Permisos + hooks de seguridad
CLAUDE.md                       ← Configuracion del proyecto (generado)
```

**Recomendado** (desarrollo diario):
```
.claude/settings.local.json    ← Permisos + hooks de seguridad
.claude/commands/*.md          ← 36 skills
.claude/rules/*.md             ← Reglas contextuales (generadas para tu stack)
CLAUDE.md                      ← Configuracion del proyecto (generado)
MEMORY.md                      ← Sistema de memoria
```

**Full** (equipo completo):
```
.claude/settings.local.json    ← Permisos + hooks de seguridad
.claude/commands/*.md          ← 36 skills
.claude/agents/*/              ← 4+ subagentes
.claude/rules/*.md             ← Reglas contextuales
.github/workflows/*.yml        ← CI/CD workflows
.github/ISSUE_TEMPLATE/*.md   ← Issue templates
.github/pull_request_template.md
docs/procesos/*.md             ← Process docs
docs/adr/ADR-000-template.md
.mcp.json                      ← MCP servers template
.lsp.json                      ← LSP servers template
CLAUDE.md                      ← Configuracion del proyecto
MEMORY.md                      ← Sistema de memoria
keybindings.json               ← Atajos de teclado
```

### Paso 4: Extraer estandares

Ejecuta automaticamente el equivalente a `/learn-project` para:
- Generar reglas contextuales especificas para el stack detectado
- Actualizar standards.md con ejemplos reales del proyecto
- Especializar agentes si el stack lo amerita

### Paso 5: Verificacion

```
## Setup completado

Archivos creados:
  ✅ CLAUDE.md (configurado para [stack])
  ✅ .claude/settings.local.json (N hooks activos)
  ✅ .claude/commands/ (36 skills)
  ✅ .claude/rules/ (N reglas para [lenguaje])
  ...

Prueba rapida:
  1. Cierra y abre Claude Code (para cargar CLAUDE.md)
  2. Escribe /status para ver el dashboard
  3. Escribe /learn-project para extraer mas patrones

Siguientes pasos recomendados:
  1. Revisa CLAUDE.md y ajusta lo que no sea correcto
  2. Corre /security-scan para un primer escaneo
  3. Corre /learn-project para extraer estandares completos
```
