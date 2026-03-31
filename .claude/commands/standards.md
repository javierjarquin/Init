# /standards — Development best practices

Shows and applies development standards for the project. Documents correct vs incorrect patterns based on real team experience.

## Usage
```
/standards                → Show all standards summary
/standards front          → Frontend standards only
/standards back           → Backend standards only
/standards db             → Database standards only
/standards {pattern}      → Search specific pattern (eg: /standards forms, /standards rls)
```

## Frontend Standards

### React Components

**CORRECT:**
```tsx
"use client";
// ALL interface props must be in destructuring
export function MyComponent({ title, description, onSave }: MyComponentProps) {
```

**INCORRECT:**
```tsx
// NEVER forget a prop — causes ReferenceError at runtime
export function MyComponent({ title, description }: MyComponentProps) {
  // `onSave` is in interface but not destructured
```

### Hydration (Next.js)

**CORRECT:**
```tsx
const [mounted, setMounted] = useState(false);
const [value, setValue] = useState(defaultValue);
useEffect(() => { setMounted(true); setValue(localStorage.getItem("key")); }, []);
const displayValue = mounted ? value : defaultValue;
```

**INCORRECT:**
```tsx
// NEVER — causes hydration mismatch
const [value, setValue] = useState(localStorage.getItem("key"));
```

### CSS (Tailwind v4)

**CORRECT:**
```css
*, *::before, *::after { box-sizing: border-box; }
```

**INCORRECT:**
```css
/* NEVER — overrides ALL Tailwind padding/margin utilities */
* { padding: 0; margin: 0; }
```

### Forms (Zod + React Hook Form)

**CORRECT:**
```tsx
// Use preprocess for optional numbers
const optionalNumber = z.preprocess(
  (v) => (v === "" || v === undefined ? undefined : Number(v)),
  z.number().optional()
);
```

**INCORRECT:**
```tsx
// NEVER — fails with empty inputs
field: z.coerce.number().nullable(),
```

### Providers

**CORRECT:**
```tsx
// Separate "use client" file
// src/components/Providers.tsx
"use client";
export function Providers({ children }) {
  return <ToastProvider>{children}</ToastProvider>;
}
// layout.tsx (Server Component)
import { Providers } from "./Providers";
```

**INCORRECT:**
```tsx
// NEVER — import client provider directly in server layout
import { ToastProvider } from "@/components/ui";
// Causes hydration mismatch!
```

## Backend Standards

### Server Actions

**CORRECT:**
```tsx
export async function createSomethingAction(data) {
  const { tenant_id } = await getSessionContext(); // ALWAYS from server
  return await service.create({ ...data, tenant_id });
}
```

**INCORRECT:**
```tsx
// NEVER trust client-sent tenant_id
export async function createSomethingAction(tenantId: string, data) {
  return await service.create({ ...data, tenant_id: tenantId }); // Insecure!
}
```

## Database Standards

### RLS (Row Level Security)

**CORRECT:**
```sql
-- Use SECURITY DEFINER to avoid recursion
CREATE OR REPLACE FUNCTION public.get_my_tenant_id()
RETURNS UUID LANGUAGE sql STABLE SECURITY DEFINER
AS $$ SELECT tenant_id FROM public.users WHERE auth_user_id = auth.uid() LIMIT 1; $$;

CREATE POLICY items_select ON public.items
  FOR SELECT USING (tenant_id = public.get_my_tenant_id());
```

**INCORRECT:**
```sql
-- RLS enabled WITHOUT policies = BLOCKS EVERYTHING
ALTER TABLE items ENABLE ROW LEVEL SECURITY;
-- (no CREATE POLICY) → nobody can read or write

-- Recursive policy — causes infinite loop
CREATE POLICY bad ON public.users FOR SELECT
  USING (tenant_id = (SELECT tenant_id FROM public.users WHERE ...));
```

### Migrations

**CORRECT:**
```bash
# Apply migrations without losing data
npx supabase db push
# Or execute SQL directly
docker exec db psql -U postgres -c "ALTER TABLE ..."
```

**PROHIBITED:**
```bash
# NEVER — deletes ALL data
npx supabase db reset  # PROHIBITED
```

## API Security Standards

### Rate Limiting

**CORRECT:**
```typescript
// Express
import rateLimit from 'express-rate-limit';
const loginLimiter = rateLimit({ windowMs: 60 * 1000, max: 5, message: 'Too many login attempts' });
app.post('/auth/login', loginLimiter, loginHandler);

// NestJS
@Throttle({ default: { limit: 5, ttl: 60000 } })
@Post('auth/login')
async login(@Body() dto: LoginDto) { ... }
```

**INCORRECT:**
```typescript
// NEVER — endpoints without rate limiting
app.post('/auth/login', loginHandler); // Brute force vulnerable!
app.post('/auth/register', registerHandler); // Spam vulnerable!
```

### CSRF Protection

**CORRECT:**
```typescript
// Express — csrf middleware
import { doubleCsrf } from 'csrf-csrf';
const { doubleCsrfProtection } = doubleCsrf({ getSecret: () => process.env.CSRF_SECRET });
app.use(doubleCsrfProtection);

// Cookies — secure flags
res.cookie('session', token, { httpOnly: true, secure: true, sameSite: 'strict' });
```

**INCORRECT:**
```typescript
// NEVER — cookies without secure flags
res.cookie('session', token); // Missing httpOnly, secure, sameSite!
res.cookie('session', token, { httpOnly: false }); // XSS can steal session!
```

### Input Validation at Boundaries

**CORRECT:**
```typescript
// Validate ALL user input at the API boundary
const schema = z.object({
  email: z.string().email().max(255),
  name: z.string().min(1).max(100).trim(),
  age: z.number().int().min(0).max(150),
});
const validated = schema.parse(req.body);
```

**INCORRECT:**
```typescript
// NEVER trust raw user input
const { email, name } = req.body; // No validation!
await db.users.create({ email, name }); // Injection risk!
```

## Logging & Audit Trail Standards

### What to Log

**CORRECT:**
```typescript
// Log actions, NOT data
logger.info({ action: 'user.login', userId: user.id, ip: req.ip });
logger.info({ action: 'order.create', orderId: order.id, userId: user.id });
logger.warn({ action: 'auth.failed', email: maskEmail(email), ip: req.ip });
```

**INCORRECT:**
```typescript
// NEVER log sensitive data
logger.info('Login:', { email, password }); // PASSWORD IN LOGS!
logger.info('Request body:', req.body); // May contain PII/secrets!
console.log('Token:', jwt); // Token in logs!
```

### What Must Have Audit Trail
- User login/logout
- Password changes
- Role/permission changes
- Data deletion (soft delete preferred)
- Payment transactions
- Admin actions

## Destructive Operations — Safety Rules

### Git

**BLOCKED — require explicit user confirmation:**
```bash
git push --force          # Use --force-with-lease as safer alternative
git push -f               # Same as above
git reset --hard          # Discards uncommitted work
git push origin main      # Must go through PR, never direct push
git branch -D             # Permanent branch deletion
```

**SAFE alternatives:**
```bash
git push --force-with-lease  # Safer: fails if remote changed
git stash                    # Save work without discarding
git revert HEAD              # Undo commit without rewriting history
```

### Database

**BLOCKED — NEVER in production:**
```bash
npx prisma migrate reset      # Drops ALL data
npx supabase db reset          # Drops ALL data
DROP TABLE                     # Irreversible without backup
DROP DATABASE                  # Catastrophic
TRUNCATE TABLE                 # Deletes all rows
DELETE FROM table (no WHERE)   # Deletes all rows
```

**SAFE alternatives:**
```bash
npx prisma migrate deploy     # Apply pending migrations only
/migrate-db rollback          # Reverts last migration (dev only)
# For prod: create new migration that reverts changes
```

## Pre-commit Checklist

### Code Quality
- [ ] All interface props destructured in component?
- [ ] Actions get auth context server-side?
- [ ] Forms handle empty inputs correctly?
- [ ] No destructive CSS resets?
- [ ] No hydration differences between server/client?
- [ ] Tables with RLS have policies?
- [ ] Providers in separate "use client" file?
- [ ] TypeScript compiles without errors?

### Security
- [ ] No hardcoded secrets, API keys, or passwords?
- [ ] No .env files tracked by git?
- [ ] Input validated at API boundaries (Zod/Joi/class-validator)?
- [ ] Auth context resolved server-side (never trust client)?
- [ ] Rate limiting on auth endpoints?
- [ ] Cookies have httpOnly, secure, sameSite flags?
- [ ] No sensitive data in logs (passwords, tokens, PII)?
- [ ] No destructive DB commands (reset, drop, truncate)?
