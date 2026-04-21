#!/bin/bash
# Claude Code Status Line — muestra info contextual del proyecto
# Activar en settings.local.json:
#   "statusLine": { "type": "command", "command": "bash .claude/statusline.sh" }

# Input JSON viene por stdin
INPUT=$(cat)

# Extraer info del input (Claude Code provee: model, workspace, session_id)
MODEL=$(echo "$INPUT" | grep -o '"display_name":"[^"]*"' | head -1 | cut -d'"' -f4)

# Git info
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no-git")
DIRTY=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
AHEAD=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "0")

# Colors
RESET='\033[0m'
BOLD='\033[1m'
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
DIM='\033[2m'

# Build status line
STATUS=""

# Model
if [ -n "$MODEL" ]; then
  STATUS="${STATUS}${CYAN}${MODEL}${RESET}"
fi

# Branch
if [ "$BRANCH" != "no-git" ]; then
  if [ "$BRANCH" = "main" ] || [ "$BRANCH" = "master" ]; then
    STATUS="${STATUS} ${DIM}|${RESET} ${RED}⚠ ${BRANCH}${RESET}"
  else
    STATUS="${STATUS} ${DIM}|${RESET} ${GREEN}⎇ ${BRANCH}${RESET}"
  fi

  # Dirty indicator
  if [ "$DIRTY" -gt 0 ]; then
    STATUS="${STATUS} ${YELLOW}●${DIRTY}${RESET}"
  fi

  # Ahead indicator
  if [ "$AHEAD" -gt 0 ]; then
    STATUS="${STATUS} ${CYAN}↑${AHEAD}${RESET}"
  fi
fi

printf "%b" "$STATUS"
