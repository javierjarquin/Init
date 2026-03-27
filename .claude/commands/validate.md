# /validate — Pre-merge validation workflow

Executes code-review + refactor check + build + smoke test in sequence. Use BEFORE committing or merging significant changes.

## Usage
```
/validate                → Full validation of modified files
/validate {module}       → Validate a specific module
/validate --fix          → Validate + auto-fix issues
```

## Steps

### Step 1: Code Review
Execute `/code-review` on modified files. Check for:
- Hydration mismatches
- Missing props in destructuring
- Actions without auth context
- CSS reset conflicts
- Form validation bugs
- Missing providers

### Step 2: Refactor Check
For each modified file:
- No duplicate code
- No unused imports
- Correct types (no unnecessary `any`)
- Server actions in proper files
- Client components have `"use client"`

### Step 3: Build Check
```bash
npx tsc --noEmit 2>&1 | head -30
```
If TypeScript errors exist, list and fix them.

### Step 4: Smoke Test
Run 5 quick checks with Playwright:
1. Login works
2. Main listing page loads with data
3. Detail page loads without JS errors
4. Key feature renders (if applicable)
5. 0 hydration errors in console

### Step 5: Report
```markdown
## Validation Report

| Step | Status | Details |
|------|--------|---------|
| Code Review | PASS/FAIL | X issues found |
| Refactor | PASS/FAIL | X improvements suggested |
| TypeScript | PASS/FAIL | X errors |
| Smoke Test | PASS/FAIL | X/5 tests passed |

### Critical issues (block merge):
...

### Minor issues (don't block):
...
```

## Rules

- If CRITICAL issues exist, do NOT proceed with merge
- If MINOR issues exist, document but allow merge
- NEVER run destructive database commands as part of validation
- ALWAYS take screenshots of affected pages
- Compare before/after screenshots for UI changes
