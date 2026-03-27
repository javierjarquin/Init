# /code-review — Technical code review

Analyzes code for technical errors, broken patterns, and production bugs based on real-world experience.

## Usage
```
/code-review                    → Review modified files (git diff)
/code-review {file}             → Review a specific file
/code-review {module}           → Review a module
/code-review --full             → Full project review
/code-review --fix              → Review + auto-fix
```

## Checklist

### 1. Hydration Mismatch (Next.js / React SSR)
- [ ] Client components (`"use client"`) must render identically on server and client
- [ ] Do NOT use `typeof window !== 'undefined'` for conditional rendering
- [ ] State from `localStorage` must initialize AFTER mount (`useEffect` + `mounted` flag)
- [ ] Do NOT use `style` props that differ between server and client
- [ ] `useState` with browser values must use mounted pattern

### 2. Props missing in destructuring
- [ ] Verify ALL interface props are destructured in the component
- [ ] If a prop is added to the interface, add it to destructuring too

### 3. Server Actions missing auth context
- [ ] Every action that does INSERT must get user/tenant context server-side
- [ ] NEVER trust client-sent IDs for authorization — always resolve server-side
- [ ] Global tables (shared across tenants) don't need tenant filtering

### 4. RLS without policies (Supabase)
- [ ] If a table has RLS enabled, it MUST have policies
- [ ] RLS enabled without policies = BLOCKS ALL access
- [ ] Policies with subqueries to the same table cause INFINITE RECURSION
- [ ] Use `SECURITY DEFINER` functions for self-referencing policy queries

### 5. CSS Reset conflicts (Tailwind v4)
- [ ] Do NOT use `* { padding: 0; margin: 0; }` — overrides Tailwind utilities
- [ ] Only use `* { box-sizing: border-box; }`
- [ ] For critical padding, use inline styles as fallback

### 6. Form validation (Zod + React Hook Form)
- [ ] `z.coerce.number().nullable()` fails with empty inputs — use preprocess helper
- [ ] Number inputs send `0` when empty, not `""`
- [ ] Test forms with empty submissions to catch validation gaps

### 7. Context Providers
- [ ] Providers must wrap the layout — verify they're not missing
- [ ] Client Providers in Server layouts cause hydration mismatch
- [ ] Create a `Providers.tsx` wrapper with `"use client"`

### 8. Imports and exports
- [ ] Server actions must be imported correctly in client components
- [ ] Do NOT import service functions in client components — use actions
- [ ] Verify `revalidatePath` uses the correct route

### 9. Database integrity
- [ ] Check for missing unique constraints on business-critical fields
- [ ] Verify foreign key relationships are not broken
- [ ] Check for orphaned records

### 10. Build and cache
- [ ] After client component changes, HMR may not reload — clear `.next` if needed
- [ ] NEVER use destructive DB commands without user confirmation

## Execution

1. **Identify files**: `git diff --name-only` or scan full project
2. **For each file**: Read, apply checklist, report issues with line/severity/fix
3. **Report format**:
   ```
   | # | File | Line | Severity | Issue | Fix |
   |---|------|------|----------|-------|-----|
   ```
4. **If `--fix`**: Apply fixes automatically and re-verify
