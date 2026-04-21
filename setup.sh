#!/bin/bash

# ============================================================================
# Claude Code Starter Kit — Setup Script
# ============================================================================
# Este script inicializa el starter kit en tu proyecto existente.
# Copia los archivos de configuracion, skills, workflows, templates y docs.
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
read -p "Copiar el starter kit al proyecto? (y/N) " -n 1 -r
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
echo -e "${BLUE}▸ Slash commands${NC}"
mkdir -p "$TARGET_DIR/.claude/commands"
for file in "$SCRIPT_DIR/.claude/commands/"*.md; do
    filename=$(basename "$file")
    copy_safe "$file" "$TARGET_DIR/.claude/commands/$filename"
done

# ─── .claude/settings.local.json ───────────────────────────────────
echo ""
echo -e "${BLUE}▸ Settings + hooks${NC}"
copy_safe "$SCRIPT_DIR/.claude/settings.local.json" "$TARGET_DIR/.claude/settings.local.json"

# ─── .claude/agents/ ──────────────────────────────────────────────
echo ""
echo -e "${BLUE}▸ Subagentes (10 total)${NC}"
for dir in "$SCRIPT_DIR/.claude/agents/"*/; do
    agent_name=$(basename "$dir")
    mkdir -p "$TARGET_DIR/.claude/agents/$agent_name"
    for file in "$dir"*.md; do
        filename=$(basename "$file")
        copy_safe "$file" "$TARGET_DIR/.claude/agents/$agent_name/$filename"
    done
done

# ─── .claude/skills/ ──────────────────────────────────────────────
echo ""
echo -e "${BLUE}▸ Skills (5 total)${NC}"
for dir in "$SCRIPT_DIR/.claude/skills/"*/; do
    skill_name=$(basename "$dir")
    mkdir -p "$TARGET_DIR/.claude/skills/$skill_name"
    for file in "$dir"*.md; do
        filename=$(basename "$file")
        copy_safe "$file" "$TARGET_DIR/.claude/skills/$skill_name/$filename"
    done
done

# ─── .claude/output-styles/ ──────────────────────────────────────
echo ""
echo -e "${BLUE}▸ Output styles (3 total)${NC}"
mkdir -p "$TARGET_DIR/.claude/output-styles"
for file in "$SCRIPT_DIR/.claude/output-styles/"*.md; do
    filename=$(basename "$file")
    copy_safe "$file" "$TARGET_DIR/.claude/output-styles/$filename"
done

# ─── .claude/statusline.sh ────────────────────────────────────────
echo ""
echo -e "${BLUE}▸ Status line${NC}"
copy_safe "$SCRIPT_DIR/.claude/statusline.sh" "$TARGET_DIR/.claude/statusline.sh"
chmod +x "$TARGET_DIR/.claude/statusline.sh" 2>/dev/null || true

# ─── .claude/rules/ ──────────────────────────────────────────────
echo ""
echo -e "${BLUE}▸ Reglas contextuales${NC}"
mkdir -p "$TARGET_DIR/.claude/rules"
for file in "$SCRIPT_DIR/.claude/rules/"*.md; do
    filename=$(basename "$file")
    copy_safe "$file" "$TARGET_DIR/.claude/rules/$filename"
done

# ─── .github/workflows/ ───────────────────────────────────────────
echo ""
echo -e "${BLUE}▸ GitHub Actions workflows${NC}"
mkdir -p "$TARGET_DIR/.github/workflows"
if [ -d "$SCRIPT_DIR/.github/workflows" ]; then
    for file in "$SCRIPT_DIR/.github/workflows/"*.yml; do
        [ -f "$file" ] || continue
        filename=$(basename "$file")
        copy_safe "$file" "$TARGET_DIR/.github/workflows/$filename"
    done
fi

# ─── .github/ templates ───────────────────────────────────────────
echo ""
echo -e "${BLUE}▸ GitHub templates${NC}"
mkdir -p "$TARGET_DIR/.github/ISSUE_TEMPLATE"
if [ -f "$SCRIPT_DIR/.github/pull_request_template.md" ]; then
    copy_safe "$SCRIPT_DIR/.github/pull_request_template.md" "$TARGET_DIR/.github/pull_request_template.md"
fi
if [ -d "$SCRIPT_DIR/.github/ISSUE_TEMPLATE" ]; then
    for file in "$SCRIPT_DIR/.github/ISSUE_TEMPLATE/"*.md; do
        [ -f "$file" ] || continue
        filename=$(basename "$file")
        copy_safe "$file" "$TARGET_DIR/.github/ISSUE_TEMPLATE/$filename"
    done
fi

# ─── docs/ ─────────────────────────────────────────────────────────
echo ""
echo -e "${BLUE}▸ Process docs${NC}"
mkdir -p "$TARGET_DIR/docs/procesos"
mkdir -p "$TARGET_DIR/docs/adr"
mkdir -p "$TARGET_DIR/docs/postmortems"
if [ -d "$SCRIPT_DIR/docs/procesos" ]; then
    for file in "$SCRIPT_DIR/docs/procesos/"*.md; do
        [ -f "$file" ] || continue
        filename=$(basename "$file")
        copy_safe "$file" "$TARGET_DIR/docs/procesos/$filename"
    done
fi
[ -f "$SCRIPT_DIR/docs/adr/ADR-000-template.md" ] && \
    copy_safe "$SCRIPT_DIR/docs/adr/ADR-000-template.md" "$TARGET_DIR/docs/adr/ADR-000-template.md"

# ─── MCP, LSP, Plugin, Keybindings, Memory ────────────────────────
echo ""
echo -e "${BLUE}▸ MCP servers (activados: context7, sequential-thinking, memory)${NC}"
copy_safe "$SCRIPT_DIR/.mcp.json" "$TARGET_DIR/.mcp.json"

echo ""
echo -e "${BLUE}▸ LSP servers template${NC}"
copy_safe "$SCRIPT_DIR/.lsp.json" "$TARGET_DIR/.lsp.json"

echo ""
echo -e "${BLUE}▸ Plugin manifest${NC}"
mkdir -p "$TARGET_DIR/.claude-plugin"
copy_safe "$SCRIPT_DIR/.claude-plugin/plugin.json" "$TARGET_DIR/.claude-plugin/plugin.json"

echo ""
echo -e "${BLUE}▸ Keybindings template${NC}"
copy_safe "$SCRIPT_DIR/keybindings.json" "$TARGET_DIR/keybindings.json"

echo ""
echo -e "${BLUE}▸ Memory system${NC}"
copy_safe "$SCRIPT_DIR/MEMORY.md" "$TARGET_DIR/MEMORY.md"

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
echo -e "Proximos pasos:"
echo -e "  1. ${YELLOW}Edita CLAUDE.md${NC} — reemplaza los {{PLACEHOLDER}} con tu proyecto"
echo -e "  2. ${YELLOW}Edita .claude/settings.local.json${NC} — ajusta permisos y hooks"
echo -e "  3. ${YELLOW}Configura .github/workflows/${NC} — ajusta package manager y deploy"
echo -e "  4. ${YELLOW}Inicia Claude Code${NC} — abre tu proyecto con 'claude' en terminal"
echo -e "  5. ${YELLOW}Prueba /status y /ship-it${NC}"
echo ""
echo -e "Slash commands (${GREEN}37 total${NC}):"
echo -e "  ${BLUE}/feature${NC}  /test-unit  /e2e  /review-pr  /refactor  /cleanup"
echo -e "  ${BLUE}/deploy-dev${NC}  /deploy-prod  /rollback  /hotfix"
echo -e "  ${BLUE}/qa${NC}  /fix-qa  /audit  /security-scan  /perf"
echo -e "  ${BLUE}/sprint${NC}  /status  /changelog  /adr  /docs"
echo -e "  ${BLUE}/debug${NC}  /deps  /migrate-db  /code-review  /validate"
echo -e "  ${BLUE}/flows${NC}  /flow-test  /ux-review  /standards"
echo -e "  ${BLUE}/docker${NC}  /env-check  /a11y"
echo -e "  ${BLUE}/init-project${NC}  /learn-project  /verify-req  /manual"
echo ""
echo -e "Subagentes (${GREEN}10 total${NC}):"
echo -e "  ${BLUE}@reviewer${NC}  @researcher  @db-expert  @quick-fix"
echo -e "  ${BLUE}@security-auditor${NC}  @api-architect  @frontend-reviewer"
echo -e "  ${BLUE}@e2e-runner${NC}  @performance-profiler  @devops-expert"
echo ""
echo -e "Skills (${GREEN}5 total${NC}):"
echo -e "  ${BLUE}create-feature${NC}  create-migration  add-endpoint  debug-flow  ship-it"
echo ""
echo -e "Output styles (${GREEN}3 total${NC}):"
echo -e "  ${BLUE}concise${NC}  review-mode  teaching"
echo ""
echo -e "Reglas contextuales (${GREEN}7 total${NC}):"
echo -e "  ${BLUE}tests${NC}  migrations  api-routes  components  env-files  docker  anti-hallucination"
echo ""
echo -e "MCPs activados (${GREEN}3 total${NC}):"
echo -e "  ${BLUE}context7${NC}  sequential-thinking  memory"
echo ""
echo -e "Workflows CI/CD (${GREEN}4 total${NC}):"
echo -e "  ${BLUE}ci.yml${NC}  cd-dev.yml  cd-prod.yml  security.yml"
echo ""
echo -e "Extras:"
echo -e "  ${BLUE}.mcp.json${NC}  .lsp.json  plugin.json  keybindings.json"
echo -e "  ${BLUE}MEMORY.md${NC}  statusline.sh"
echo ""
