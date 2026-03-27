# /ux-review — Visual UX/UI audit

Takes screenshots of the application and reviews visual quality, alignment, responsiveness and usability.

## Usage
```
/ux-review                → Review all main pages
/ux-review {page}         → Review a specific page
/ux-review mobile         → Review mobile responsiveness
/ux-review --fix          → Review + auto-fix issues
```

## Instructions

### 1. Take screenshots
Use Playwright to capture each page at:
- Desktop: 1536x864 (common resolution)
- Mobile: 390x844 (iPhone 14)

### 2. For each screenshot, check:

#### Layout
- [ ] Sidebar visible and functional (desktop)
- [ ] Bottom nav visible (mobile)
- [ ] Content doesn't overflow horizontally
- [ ] Proper spacing between sections
- [ ] No elements clipped at edges

#### Typography
- [ ] Page title (h1) visible and readable
- [ ] Description text present where expected
- [ ] Labels aligned with inputs
- [ ] No truncated text that hides critical info

#### Buttons
- [ ] All action buttons visible and not clipped
- [ ] Button text has proper padding (not touching edges)
- [ ] Primary actions use accent color
- [ ] Destructive actions use danger color
- [ ] Buttons have minimum 44px touch target (mobile)

#### Tables/Lists
- [ ] Headers visible
- [ ] Data rows alternate background (zebra)
- [ ] Empty state shows helpful message
- [ ] Pagination visible if needed

#### Forms
- [ ] Labels present for all fields
- [ ] Required fields marked
- [ ] Validation errors visible
- [ ] Submit button visible and reachable
- [ ] Forms work on mobile (full-width inputs)

#### Modals/Overlays
- [ ] Modal has close button
- [ ] Backdrop visible
- [ ] Content scrollable if tall
- [ ] Not cut off on mobile

### 3. Check for hydration errors
```javascript
page.on('console', msg => {
  if (msg.text().includes('hydration')) errors.push(msg.text());
});
```

### 4. Report
```markdown
## UX Review Report

| Page | Desktop | Mobile | Issues |
|------|---------|--------|--------|
| /inicio | PASS | PASS | — |
| /ordenes | PASS | WARN | table overflow on small screens |

### Issues found
| # | Page | Severity | Issue | Fix |
|---|------|----------|-------|-----|
```

### 5. Critical thinking

- Does it look PROFESSIONAL? Would a paying customer trust this UI?
- Are interactive elements obviously clickable?
- Does the empty state guide the user on what to do next?
- Is the information hierarchy clear (what's most important)?
- Does the mobile version feel native or like a shrunken desktop?
