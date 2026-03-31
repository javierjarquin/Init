# /manual — Generar manuales PDF

Genera manuales PDF interactivos con screenshots reales del sistema.

## Uso
```
/manual superadmin     → Manual Super Admin
/manual owner          → Manual del Dueño
/manual admin          → Manual del Administrador
/manual professional   → Manual del Profesional
/manual receptionist   → Manual del Recepcionista
/manual booking        → Guía de Reservas (cliente final)
/manual quickstart     → Guía de Inicio Rápido
/manual all            → Todos los manuales
```

## Instrucciones

1. **Verificar** que el entorno dev remoto está disponible (`dev-miagendita.construyeconia.com`)

2. **Ejecutar** el script correspondiente:
   - Individual: `npx tsx scripts/generate-manual-superadmin.ts` (para superadmin)
   - Todos: `npx tsx scripts/generate-all-manuals.ts`

3. **Output**: PDFs en `docs/manuales/`

## Credenciales
- Super Admin: `admin@agendadigitalpro.mx` (sin slug)
- Owner: `bboy49949@gmail.com` / slug: `airbnb-test`

## Notas
- Los screenshots se toman del entorno DEV, no producción
- Los PDFs incluyen branding MiAgendita (paleta teal, Plus Jakarta Sans)
- Cada PDF tiene portada, TOC con links, screenshots embebidos en base64
