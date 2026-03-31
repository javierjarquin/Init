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
echo  [1/12] Skills (slash commands)...
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
echo  [2/12] Settings + hooks...
if not exist "%TARGET_DIR%\.claude" mkdir "%TARGET_DIR%\.claude"
if not exist "%TARGET_DIR%\.claude\settings.local.json" (
    copy "%SRC%.claude\settings.local.json" "%TARGET_DIR%\.claude\settings.local.json" >nul
    echo   + settings.local.json
) else (
    echo   - settings.local.json (ya existe)
)

echo.
echo  [3/12] Subagentes personalizados...
if not exist "%TARGET_DIR%\.claude\agents\reviewer" mkdir "%TARGET_DIR%\.claude\agents\reviewer"
if not exist "%TARGET_DIR%\.claude\agents\researcher" mkdir "%TARGET_DIR%\.claude\agents\researcher"
if not exist "%TARGET_DIR%\.claude\agents\db-expert" mkdir "%TARGET_DIR%\.claude\agents\db-expert"
if not exist "%TARGET_DIR%\.claude\agents\quick-fix" mkdir "%TARGET_DIR%\.claude\agents\quick-fix"
for %%d in (reviewer researcher db-expert quick-fix) do (
    if not exist "%TARGET_DIR%\.claude\agents\%%d\%%d.md" (
        copy "%SRC%.claude\agents\%%d\%%d.md" "%TARGET_DIR%\.claude\agents\%%d\%%d.md" >nul
        echo   + %%d.md
    ) else (
        echo   - %%d.md (ya existe)
    )
)

echo.
echo  [4/12] Reglas contextuales...
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
echo  [5/12] GitHub Actions workflows...
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
echo  [6/12] GitHub templates...
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
echo  [7/12] Process docs...
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
echo  [8/12] ADR template...
if not exist "%TARGET_DIR%\docs\adr\ADR-000-template.md" (
    copy "%SRC%docs\adr\ADR-000-template.md" "%TARGET_DIR%\docs\adr\ADR-000-template.md" >nul
    echo   + ADR-000-template.md
) else (
    echo   - ADR-000-template.md (ya existe)
)

echo.
echo  [9/12] MCP servers template...
if not exist "%TARGET_DIR%\.mcp.json" (
    copy "%SRC%.mcp.json" "%TARGET_DIR%\.mcp.json" >nul
    echo   + .mcp.json
) else (
    echo   - .mcp.json (ya existe)
)

echo.
echo  [10/12] Extras (LSP, plugin, keybindings, memory)...
if not exist "%TARGET_DIR%\.lsp.json" (
    copy "%SRC%.lsp.json" "%TARGET_DIR%\.lsp.json" >nul
    echo   + .lsp.json
) else (
    echo   - .lsp.json (ya existe)
)
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
echo  [11/12] CLAUDE.md...
if not exist "%TARGET_DIR%\CLAUDE.md" (
    copy "%SRC%CLAUDE.md" "%TARGET_DIR%\CLAUDE.md" >nul
    echo   + CLAUDE.md
) else (
    echo   - CLAUDE.md (ya existe)
)

echo.
echo  ======================================================
echo    Listo! Starter kit instalado.
echo  ======================================================
echo.
echo   Pasos siguientes:
echo     1. Edita CLAUDE.md con los datos de tu proyecto
echo     2. Edita .claude\settings.local.json (permisos + hooks)
echo     3. Configura .github\workflows\ (package manager + deploy)
echo     4. Abre Claude Code en tu proyecto
echo     5. Prueba escribiendo /status
echo.
echo  [12/12] Listo!
echo.
echo   38 skills disponibles:
echo     /feature /test-unit /e2e /review-pr /refactor /cleanup
echo     /deploy-dev /deploy-prod /rollback /hotfix
echo     /qa /fix-qa /audit /security-scan /perf
echo     /sprint /status /changelog /adr /docs
echo     /debug /deps /migrate-db /code-review /validate
echo     /flows /flow-test /ux-review /standards
echo     /docker /env-check /a11y
echo     /init-project /learn-project /verify-req
echo.
echo   4 subagentes:
echo     @reviewer  @researcher  @db-expert  @quick-fix
echo.
echo   7 reglas contextuales:
echo     tests  migrations  api-routes  components  env-files  docker  anti-hallucination
echo.
echo   4 workflows CI/CD:
echo     ci.yml  cd-dev.yml  cd-prod.yml  security.yml
echo.
echo   Extras:
echo     .mcp.json  .lsp.json  plugin.json  keybindings.json  MEMORY.md
echo.

endlocal
