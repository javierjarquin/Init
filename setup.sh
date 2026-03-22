#!/bin/bash

# ============================================================================
# Claude Code Starter Kit — Setup Script
# ============================================================================
# Este script inicializa el starter kit en tu proyecto existente.
# Copia los archivos de configuración, skills, templates y docs.
#
# Uso:
#   chmod +x setup.sh
#   ./setup.sh /ruta/a/tu/proyecto
#
# O desde el directorio del proyecto:
#   ./setup.sh .
# ============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-.}"

# Resolve to absolute path
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

echo -e "${BLUE}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║    Claude Code Starter Kit — Setup              ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Source: ${YELLOW}$SCRIPT_DIR${NC}"
echo -e "Target: ${YELLOW}$TARGET_DIR${NC}"
echo ""

# Confirm
read -p "¿Copiar el starter kit al proyecto? (y/N) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Cancelado.${NC}"
    exit 1
fi

# Function to copy with backup
copy_safe() {
    local src="$1"
    local dest="$2"

    if [ -f "$dest" ]; then
        echo -e "  ${YELLOW}⚠ Ya existe: $dest (saltando)${NC}"
    else
        mkdir -p "$(dirname "$dest")"
        cp "$src" "$dest"
        echo -e "  ${GREEN}✓ Creado: $dest${NC}"
    fi
}

# ─── .claude/commands/ ─────────────────────────────────────────────
echo ""
echo -e "${BLUE}▸ Skills (slash commands)${NC}"
mkdir -p "$TARGET_DIR/.claude/commands"
for file in "$SCRIPT_DIR/.claude/commands/"*.md; do
    filename=$(basename "$file")
    copy_safe "$file" "$TARGET_DIR/.claude/commands/$filename"
done

# ─── .claude/settings.local.json ───────────────────────────────────
echo ""
echo -e "${BLUE}▸ Settings${NC}"
copy_safe "$SCRIPT_DIR/.claude/settings.local.json" "$TARGET_DIR/.claude/settings.local.json"

# ─── .github/ ──────────────────────────────────────────────────────
echo ""
echo -e "${BLUE}▸ GitHub templates${NC}"
mkdir -p "$TARGET_DIR/.github/ISSUE_TEMPLATE"
copy_safe "$SCRIPT_DIR/.github/pull_request_template.md" "$TARGET_DIR/.github/pull_request_template.md"
for file in "$SCRIPT_DIR/.github/ISSUE_TEMPLATE/"*.md; do
    filename=$(basename "$file")
    copy_safe "$file" "$TARGET_DIR/.github/ISSUE_TEMPLATE/$filename"
done

# ─── docs/ ─────────────────────────────────────────────────────────
echo ""
echo -e "${BLUE}▸ Process docs${NC}"
mkdir -p "$TARGET_DIR/docs/procesos"
mkdir -p "$TARGET_DIR/docs/adr"
mkdir -p "$TARGET_DIR/docs/postmortems"
for file in "$SCRIPT_DIR/docs/procesos/"*.md; do
    filename=$(basename "$file")
    copy_safe "$file" "$TARGET_DIR/docs/procesos/$filename"
done
copy_safe "$SCRIPT_DIR/docs/adr/ADR-000-template.md" "$TARGET_DIR/docs/adr/ADR-000-template.md"

# ─── CLAUDE.md ─────────────────────────────────────────────────────
echo ""
echo -e "${BLUE}▸ CLAUDE.md template${NC}"
copy_safe "$SCRIPT_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"

# ─── Summary ───────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║    ✓ Starter kit instalado correctamente        ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Próximos pasos:"
echo -e "  1. ${YELLOW}Edita CLAUDE.md${NC} — reemplaza los {{PLACEHOLDER}} con tu proyecto"
echo -e "  2. ${YELLOW}Edita .claude/settings.local.json${NC} — ajusta permisos"
echo -e "  3. ${YELLOW}Inicia Claude Code${NC} — abre tu proyecto con 'claude' en terminal"
echo -e "  4. ${YELLOW}Prueba /status${NC} — verifica que todo funciona"
echo ""
echo -e "Skills disponibles (${GREEN}24 total${NC}):"
echo -e "  ${BLUE}/feature${NC}  /test-unit  /e2e  /review-pr  /refactor  /cleanup"
echo -e "  ${BLUE}/deploy-dev${NC}  /deploy-prod  /rollback  /hotfix"
echo -e "  ${BLUE}/qa${NC}  /fix-qa  /audit  /security-scan  /perf"
echo -e "  ${BLUE}/sprint${NC}  /status  /changelog  /adr  /docs"
echo -e "  ${BLUE}/debug${NC}  /deps  /migrate-db"
echo ""
