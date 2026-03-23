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
echo  [1/6] Skills (slash commands)...
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
echo  [2/6] Settings...
if not exist "%TARGET_DIR%\.claude" mkdir "%TARGET_DIR%\.claude"
if not exist "%TARGET_DIR%\.claude\settings.local.json" (
    copy "%SRC%.claude\settings.local.json" "%TARGET_DIR%\.claude\settings.local.json" >nul
    echo   + settings.local.json
) else (
    echo   - settings.local.json (ya existe)
)

echo.
echo  [3/6] GitHub templates...
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
echo  [4/6] Process docs...
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
echo  [5/6] ADR template...
if not exist "%TARGET_DIR%\docs\adr\ADR-000-template.md" (
    copy "%SRC%docs\adr\ADR-000-template.md" "%TARGET_DIR%\docs\adr\ADR-000-template.md" >nul
    echo   + ADR-000-template.md
) else (
    echo   - ADR-000-template.md (ya existe)
)

echo.
echo  [6/6] CLAUDE.md...
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
echo     2. Edita .claude\settings.local.json
echo     3. Abre Claude Code en tu proyecto
echo     4. Prueba escribiendo /status
echo.
echo   24 skills disponibles:
echo     /feature /test-unit /e2e /review-pr /refactor /cleanup
echo     /deploy-dev /deploy-prod /rollback /hotfix
echo     /qa /fix-qa /audit /security-scan /perf
echo     /sprint /status /changelog /adr /docs
echo     /debug /deps /migrate-db
echo.

endlocal
