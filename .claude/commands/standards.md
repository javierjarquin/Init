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

## Pre-commit Checklist

- [ ] All interface props destructured in component?
- [ ] Actions get auth context server-side?
- [ ] Forms handle empty inputs correctly?
- [ ] No destructive CSS resets?
- [ ] No hydration differences between server/client?
- [ ] Tables with RLS have policies?
- [ ] Providers in separate "use client" file?
- [ ] TypeScript compiles without errors?
