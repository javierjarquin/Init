# /flow-test — E2E business flow testing

Executes a complete business flow using Playwright, validates each step, detects failures and applies fixes automatically.

## Usage
```
/flow-test                     → Run ALL main flows
/flow-test {flow}              → Run a specific flow
/flow-test {flow} fix          → Run + auto-fix failures
/flow-test {flow} dry-run      → Show steps without executing
```

## Instructions

### 1. Verify environment
- Dev server running (check with curl)
- Database running and accessible
- If not responding, start services

### 2. Read documented flows
- Open the business flows documentation
- Read the section for the requested flow
- Identify each step, actor, expected state, notifications

### 3. Execute with Playwright

For each step:
```javascript
async function executeStep(page, stepNumber, description, actions, validations) {
  console.log(`\n=== STEP ${stepNumber}: ${description} ===`);
  await actions(page);
  await page.screenshot({ path: `/tmp/flow-test/step_${stepNumber}.png` });
  const results = await validations(page);
  console.log(results.passed ? `  PASS: ${results.message}` : `  FAIL: ${results.message}`);
  return results;
}
```

### 4. Validations per step

For each step, verify:
- **UI**: element visible, correct text, visual state
- **URL**: correct navigation
- **DB**: record created/updated with expected values
- **Side effects**: notifications sent, stock reserved, etc.

### 5. When a step fails

1. Take screenshot of current state
2. Capture browser console errors
3. Diagnose root cause:
   - 404 → missing route
   - 500 → server error
   - UI unresponsive → JS error
   - Wrong state → business logic bug
4. If `fix` argument:
   - Read the involved component/service
   - Apply minimal fix
   - Re-execute step to validate
   - Continue to next step

### 6. Final Report

```markdown
## Flow Test Report — {flow name}

| Step | Description | Status | Time |
|------|------------|--------|------|
| 1 | Login | PASS | 2.1s |
| 2 | Create record | PASS | 4.3s |
| 3 | Verify | FAIL → FIXED | 1.2s |

### Issues found and fixed
| # | Step | Error | Fix applied | File |
|---|------|-------|-------------|------|
```

### 7. Configuration

- **Viewport**: Match user's resolution
- **Login**: Use test credentials
- **Screenshots**: `/tmp/flow-test/`
- **Timeout per step**: 10s
- **Total timeout**: 5min per flow

### 8. Critical thinking

IMPORTANT: Don't just check that steps "don't fail". For each step:
1. **Visually verify** the screenshot
2. **Verify DB state** — does the record exist with expected values?
3. **Verify side effects** — was the notification sent? Was stock reserved?
4. **Test error paths** — what happens with unexpected input?
5. **Compare against documentation** — does actual behavior match documented flow?
