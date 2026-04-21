@echo off
setlocal enabledelayedexpansion

set "TARGET_DIR=%~1"

if "%TARGET_DIR%"=="" (
    echo.
    echo   Uso: setup.bat C:\ruta\a\tu\proyecto
    echo.
    echo   Ejemplo: setup.bat C:\Users\Dev\MiProyecto
    echo.
    exit /b 1
)

if not exist "%TARGET_DIR%" (
    echo [ERROR] El directorio "%TARGET_DIR%" no existe.
    exit /b 1
)

set "SRC=%~dp0"

echo.
echo  ======================================================
echo    Claude Code Starter Kit - Setup
echo  ======================================================
echo.
echo   Source: %SRC%
echo   Target: %TARGET_DIR%
echo.

set /p CONFIRM="  Copiar el starter kit al proyecto? (S/N): "
if /i not "%CONFIRM%"=="S" (
    echo   Cancelado.
    exit /b 0
)

echo.
echo  [1/16] Slash commands...
if not exist "%TARGET_DIR%\.claude\commands" mkdir "%TARGET_DIR%\.claude\commands"
for %%f in ("%SRC%.claude\commands\*.md") do (
    if not exist "%TARGET_DIR%\.claude\commands\%%~nxf" (
        copy "%%f" "%TARGET_DIR%\.claude\commands\%%~nxf" >nul
        echo   + %%~nxf
    ) else (
        echo   - %%~nxf (ya existe)
    )
)

echo.
echo  [2/16] Settings + hooks...
if not exist "%TARGET_DIR%\.claude" mkdir "%TARGET_DIR%\.claude"
if not exist "%TARGET_DIR%\.claude\settings.local.json" (
    copy "%SRC%.claude\settings.local.json" "%TARGET_DIR%\.claude\settings.local.json" >nul
    echo   + settings.local.json
) else (
    echo   - settings.local.json (ya existe)
)

echo.
echo  [3/16] Subagentes (10 total)...
for %%d in (reviewer researcher db-expert quick-fix security-auditor api-architect frontend-reviewer e2e-runner performance-profiler devops-expert) do (
    if not exist "%TARGET_DIR%\.claude\agents\%%d" mkdir "%TARGET_DIR%\.claude\agents\%%d"
    if not exist "%TARGET_DIR%\.claude\agents\%%d\%%d.md" (
        copy "%SRC%.claude\agents\%%d\%%d.md" "%TARGET_DIR%\.claude\agents\%%d\%%d.md" >nul
        echo   + %%d.md
    ) else (
        echo   - %%d.md (ya existe)
    )
)

echo.
echo  [4/16] Skills (5 total)...
for %%s in (create-feature create-migration add-endpoint debug-flow ship-it) do (
    if not exist "%TARGET_DIR%\.claude\skills\%%s" mkdir "%TARGET_DIR%\.claude\skills\%%s"
    if not exist "%TARGET_DIR%\.claude\skills\%%s\SKILL.md" (
        copy "%SRC%.claude\skills\%%s\SKILL.md" "%TARGET_DIR%\.claude\skills\%%s\SKILL.md" >nul
        echo   + %%s/SKILL.md
    ) else (
        echo   - %%s/SKILL.md (ya existe)
    )
)

echo.
echo  [5/16] Output styles (3 total)...
if not exist "%TARGET_DIR%\.claude\output-styles" mkdir "%TARGET_DIR%\.claude\output-styles"
for %%f in ("%SRC%.claude\output-styles\*.md") do (
    if not exist "%TARGET_DIR%\.claude\output-styles\%%~nxf" (
        copy "%%f" "%TARGET_DIR%\.claude\output-styles\%%~nxf" >nul
        echo   + %%~nxf
    ) else (
        echo   - %%~nxf (ya existe)
    )
)

echo.
echo  [6/16] Status line...
if not exist "%TARGET_DIR%\.claude\statusline.sh" (
    copy "%SRC%.claude\statusline.sh" "%TARGET_DIR%\.claude\statusline.sh" >nul
    echo   + statusline.sh
) else (
    echo   - statusline.sh (ya existe)
)

echo.
echo  [7/16] Reglas contextuales (7 total)...
if not exist "%TARGET_DIR%\.claude\rules" mkdir "%TARGET_DIR%\.claude\rules"
for %%f in ("%SRC%.claude\rules\*.md") do (
    if not exist "%TARGET_DIR%\.claude\rules\%%~nxf" (
        copy "%%f" "%TARGET_DIR%\.claude\rules\%%~nxf" >nul
        echo   + %%~nxf
    ) else (
        echo   - %%~nxf (ya existe)
    )
)

echo.
echo  [8/16] GitHub Actions workflows...
if not exist "%TARGET_DIR%\.github\workflows" mkdir "%TARGET_DIR%\.github\workflows"
for %%f in ("%SRC%.github\workflows\*.yml") do (
    if not exist "%TARGET_DIR%\.github\workflows\%%~nxf" (
        copy "%%f" "%TARGET_DIR%\.github\workflows\%%~nxf" >nul
        echo   + %%~nxf
    ) else (
        echo   - %%~nxf (ya existe)
    )
)

echo.
echo  [9/16] GitHub templates...
if not exist "%TARGET_DIR%\.github\ISSUE_TEMPLATE" mkdir "%TARGET_DIR%\.github\ISSUE_TEMPLATE"
if not exist "%TARGET_DIR%\.github\pull_request_template.md" (
    copy "%SRC%.github\pull_request_template.md" "%TARGET_DIR%\.github\pull_request_template.md" >nul
    echo   + pull_request_template.md
) else (
    echo   - pull_request_template.md (ya existe)
)
for %%f in ("%SRC%.github\ISSUE_TEMPLATE\*.md") do (
    if not exist "%TARGET_DIR%\.github\ISSUE_TEMPLATE\%%~nxf" (
        copy "%%f" "%TARGET_DIR%\.github\ISSUE_TEMPLATE\%%~nxf" >nul
        echo   + %%~nxf
    ) else (
        echo   - %%~nxf (ya existe)
    )
)

echo.
echo  [10/16] Process docs...
if not exist "%TARGET_DIR%\docs\procesos" mkdir "%TARGET_DIR%\docs\procesos"
if not exist "%TARGET_DIR%\docs\adr" mkdir "%TARGET_DIR%\docs\adr"
if not exist "%TARGET_DIR%\docs\postmortems" mkdir "%TARGET_DIR%\docs\postmortems"
for %%f in ("%SRC%docs\procesos\*.md") do (
    if not exist "%TARGET_DIR%\docs\procesos\%%~nxf" (
        copy "%%f" "%TARGET_DIR%\docs\procesos\%%~nxf" >nul
        echo   + %%~nxf
    ) else (
        echo   - %%~nxf (ya existe)
    )
)

echo.
echo  [11/16] ADR template...
if not exist "%TARGET_DIR%\docs\adr\ADR-000-template.md" (
    copy "%SRC%docs\adr\ADR-000-template.md" "%TARGET_DIR%\docs\adr\ADR-000-template.md" >nul
    echo   + ADR-000-template.md
) else (
    echo   - ADR-000-template.md (ya existe)
)

echo.
echo  [12/16] MCP servers (activados: context7, sequential-thinking, memory)...
if not exist "%TARGET_DIR%\.mcp.json" (
    copy "%SRC%.mcp.json" "%TARGET_DIR%\.mcp.json" >nul
    echo   + .mcp.json
) else (
    echo   - .mcp.json (ya existe)
)

echo.
echo  [13/16] LSP template...
if not exist "%TARGET_DIR%\.lsp.json" (
    copy "%SRC%.lsp.json" "%TARGET_DIR%\.lsp.json" >nul
    echo   + .lsp.json
) else (
    echo   - .lsp.json (ya existe)
)

echo.
echo  [14/16] Plugin + keybindings + memory...
if not exist "%TARGET_DIR%\.claude-plugin" mkdir "%TARGET_DIR%\.claude-plugin"
if not exist "%TARGET_DIR%\.claude-plugin\plugin.json" (
    copy "%SRC%.claude-plugin\plugin.json" "%TARGET_DIR%\.claude-plugin\plugin.json" >nul
    echo   + plugin.json
) else (
    echo   - plugin.json (ya existe)
)
if not exist "%TARGET_DIR%\keybindings.json" (
    copy "%SRC%keybindings.json" "%TARGET_DIR%\keybindings.json" >nul
    echo   + keybindings.json
) else (
    echo   - keybindings.json (ya existe)
)
if not exist "%TARGET_DIR%\MEMORY.md" (
    copy "%SRC%MEMORY.md" "%TARGET_DIR%\MEMORY.md" >nul
    echo   + MEMORY.md
) else (
    echo   - MEMORY.md (ya existe)
)

echo.
echo  [15/16] CLAUDE.md...
if not exist "%TARGET_DIR%\CLAUDE.md" (
    copy "%SRC%CLAUDE.md" "%TARGET_DIR%\CLAUDE.md" >nul
    echo   + CLAUDE.md
) else (
    echo   - CLAUDE.md (ya existe)
)

echo.
echo  [16/16] Listo!
echo.
echo  ======================================================
echo    Starter kit instalado.
echo  ======================================================
echo.
echo   Pasos siguientes:
echo     1. Edita CLAUDE.md con los datos de tu proyecto
echo     2. Edita .claude\settings.local.json (permisos + hooks)
echo     3. Configura .github\workflows\ (package manager + deploy)
echo     4. Abre Claude Code en tu proyecto
echo     5. Prueba /status y /ship-it
echo.
echo   37 slash commands:
echo     /feature /test-unit /e2e /review-pr /refactor /cleanup
echo     /deploy-dev /deploy-prod /rollback /hotfix
echo     /qa /fix-qa /audit /security-scan /perf
echo     /sprint /status /changelog /adr /docs
echo     /debug /deps /migrate-db /code-review /validate
echo     /flows /flow-test /ux-review /standards
echo     /docker /env-check /a11y
echo     /init-project /learn-project /verify-req /manual
echo.
echo   10 subagentes:
echo     @reviewer @researcher @db-expert @quick-fix
echo     @security-auditor @api-architect @frontend-reviewer
echo     @e2e-runner @performance-profiler @devops-expert
echo.
echo   5 skills:
echo     create-feature  create-migration  add-endpoint
echo     debug-flow  ship-it
echo.
echo   3 output styles:
echo     concise  review-mode  teaching
echo.
echo   7 reglas contextuales:
echo     tests migrations api-routes components env-files docker anti-hallucination
echo.
echo   3 MCPs activados:
echo     context7  sequential-thinking  memory
echo.
echo   4 workflows CI/CD:
echo     ci.yml  cd-dev.yml  cd-prod.yml  security.yml
echo.
echo   Extras:
echo     .mcp.json  .lsp.json  plugin.json  keybindings.json
echo     MEMORY.md  statusline.sh
echo.

endlocal
