# /flows — Business flow management

Consult, validate and implement documented business flows.

## Usage
```
/flows                    → List all available flows
/flows {name}             → View flow detail
/flows validate           → Validate all flows against code
/flows validate {name}    → Validate a specific flow
/flows add {name}         → Document a new flow
/flows diagram {name}     → Generate ASCII diagram
```

## Instructions

### 1. Read flow documentation
- Main file: `docs/BUSINESS_FLOWS.md`
- Requirements: `docs/REQUIREMENTS.md`
- State machines: `docs/data-model/DATA_MODEL.md`

### 2. By argument

#### No argument → List flows
Show table of all flows with:
- Number and name
- Implementation status (check if service/action exists)
- Modules involved

#### `{name}` → Flow detail
1. Read the corresponding section
2. Show: state machine, step-by-step table, business rules, code files
3. Verify each step has implementation

#### `validate` → Validate all flows
For each documented flow:
1. Verify functions/actions mentioned exist in code
2. Verify state machines match DB enums
3. Verify notifications are sent at documented points
4. Verify business rules are implemented (guards, validations)
5. Report discrepancies

Format:
```
| # | Flow | Status | Issues |
|---|------|--------|--------|
| 1 | Lifecycle | OK | — |
| 3 | Quotes | WARN | missing max-resend guard |
```

#### `validate {name}` → Validate specific flow
More detailed:
1. Read each step
2. Find implementation (grep for function, action, service)
3. Verify preconditions, postconditions, side effects
4. Verify notifications and cross-module calls
5. Verify error handling (alternative paths)

#### `add {name}` → Document new flow
1. Ask user for context
2. Investigate existing code
3. Document in `docs/BUSINESS_FLOWS.md`:
   - State machine (if applicable)
   - Step-by-step table: Step, Action, Actor, State, Detail
   - Business rules
   - Modules involved
4. Update document index

#### `diagram {name}` → ASCII diagram
Generate flow diagram showing:
- States as `[state]`
- Transitions as `--action-->`
- Decision points as `{condition?}`
- Cross-module calls as `>> module.function()`

### 3. Rules
- Do NOT modify code when consulting or validating — read only
- DO modify `docs/BUSINESS_FLOWS.md` when adding or correcting flows
- Be strict when validating: if docs say notification is sent and code doesn't, it's an issue
- When adding flows, investigate code first to document reality, not intention
