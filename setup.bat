@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

:: ============================================================================
:: Claude Code Starter Kit — Setup Script (Windows)
:: ============================================================================
:: Uso:
::   setup.bat C:\ruta\a\tu\proyecto
:: ============================================================================

set "TARGET_DIR=%~1"

if "%TARGET_DIR%"=="" (
    echo.
    echo   Uso: setup.bat C:\ruta\a\tu\proyecto
    echo.
    echo   Ejemplo:
    echo     setup.bat C:\Users\Dev\MiProyecto
    echo.
    exit /b 1
)

if not exist "%TARGET_DIR%" (
    echo [ERROR] El directorio "%TARGET_DIR%" no existe.
    exit /b 1
)

set "SCRIPT_DIR=%~dp0"

echo.
echo  ======================================================
echo    Claude Code Starter Kit - Setup (Windows)
echo  ======================================================
echo.
echo   Source: %SCRIPT_DIR%
echo   Target: %TARGET_DIR%
echo.

set /p CONFIRM="  Copiar el starter kit al proyecto? (S/N): "
if /i not "%CONFIRM%"=="S" (
    echo   Cancelado.
    exit /b 0
)

echo.
echo  --- Skills (slash commands) ---

if not exist "%TARGET_DIR%\.claude\commands" mkdir "%TARGET_DIR%\.claude\commands"

for %%f in ("%SCRIPT_DIR%.claude\commands\*.md") do (
    if not exist "%TARGET_DIR%\.claude\commands\%%~nxf" (
        copy "%%f" "%TARGET_DIR%\.claude\commands\%%~nxf" >nul
        echo   [OK] .claude\commands\%%~nxf
    ) else (
        echo   [--] .claude\commands\%%~nxf (ya existe, saltando)
    )
)

echo.
echo  --- Settings ---

if not exist "%TARGET_DIR%\.claude" mkdir "%TARGET_DIR%\.claude"
if not exist "%TARGET_DIR%\.claude\settings.local.json" (
    copy "%SCRIPT_DIR%.claude\settings.local.json" "%TARGET_DIR%\.claude\settings.local.json" >nul
    echo   [OK] .claude\settings.local.json
) else (
    echo   [--] .claude\settings.local.json (ya existe, saltando)
)

echo.
echo  --- GitHub templates ---

if not exist "%TARGET_DIR%\.github\ISSUE_TEMPLATE" mkdir "%TARGET_DIR%\.github\ISSUE_TEMPLATE"

if not exist "%TARGET_DIR%\.github\pull_request_template.md" (
    copy "%SCRIPT_DIR%.github\pull_request_template.md" "%TARGET_DIR%\.github\pull_request_template.md" >nul
    echo   [OK] .github\pull_request_template.md
) else (
    echo   [--] .github\pull_request_template.md (ya existe, saltando)
)

for %%f in ("%SCRIPT_DIR%.github\ISSUE_TEMPLATE\*.md") do (
    if not exist "%TARGET_DIR%\.github\ISSUE_TEMPLATE\%%~nxf" (
        copy "%%f" "%TARGET_DIR%\.github\ISSUE_TEMPLATE\%%~nxf" >nul
        echo   [OK] .github\ISSUE_TEMPLATE\%%~nxf
    ) else (
        echo   [--] .github\ISSUE_TEMPLATE\%%~nxf (ya existe, saltando)
    )
)

echo.
echo  --- Process docs ---

if not exist "%TARGET_DIR%\docs\procesos" mkdir "%TARGET_DIR%\docs\procesos"
if not exist "%TARGET_DIR%\docs\adr" mkdir "%TARGET_DIR%\docs\adr"
if not exist "%TARGET_DIR%\docs\postmortems" mkdir "%TARGET_DIR%\docs\postmortems"

for %%f in ("%SCRIPT_DIR%docs\procesos\*.md") do (
    if not exist "%TARGET_DIR%\docs\procesos\%%~nxf" (
        copy "%%f" "%TARGET_DIR%\docs\procesos\%%~nxf" >nul
        echo   [OK] docs\procesos\%%~nxf
    ) else (
        echo   [--] docs\procesos\%%~nxf (ya existe, saltando)
    )
)

if not exist "%TARGET_DIR%\docs\adr\ADR-000-template.md" (
    copy "%SCRIPT_DIR%docs\adr\ADR-000-template.md" "%TARGET_DIR%\docs\adr\ADR-000-template.md" >nul
    echo   [OK] docs\adr\ADR-000-template.md
) else (
    echo   [--] docs\adr\ADR-000-template.md (ya existe, saltando)
)

echo.
echo  --- CLAUDE.md template ---

if not exist "%TARGET_DIR%\CLAUDE.md" (
    copy "%SCRIPT_DIR%CLAUDE.md" "%TARGET_DIR%\CLAUDE.md" >nul
    echo   [OK] CLAUDE.md
) else (
    echo   [--] CLAUDE.md (ya existe, saltando)
)

echo.
echo  ======================================================
echo    Starter kit instalado correctamente!
echo  ======================================================
echo.
echo   Proximos pasos:
echo     1. Edita CLAUDE.md — reemplaza los {{PLACEHOLDER}}
echo     2. Edita .claude\settings.local.json — ajusta permisos
echo     3. Abre Claude Code en tu proyecto
echo     4. Prueba /status para verificar
echo.
echo   Skills disponibles (24 total):
echo     /feature  /test-unit  /e2e  /review-pr  /refactor  /cleanup
echo     /deploy-dev  /deploy-prod  /rollback  /hotfix
echo     /qa  /fix-qa  /audit  /security-scan  /perf
echo     /sprint  /status  /changelog  /adr  /docs
echo     /debug  /deps  /migrate-db
echo.

endlocal
