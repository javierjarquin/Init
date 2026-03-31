# /env-check — Validacion de variables de entorno

Verifica que todas las variables de entorno requeridas estan configuradas y son validas.

## Uso
```
/env-check             → Validacion completa
/env-check missing     → Solo variables faltantes
/env-check compare     → Comparar .env con .env.example
/env-check generate    → Generar .env.example desde el codigo
/env-check secrets     → Verificar que no hay secrets en el repo
```

## Instrucciones

### Comando: (default / sin argumentos)
Ejecutar todas las verificaciones en orden:

1. **Buscar variables referenciadas en el codigo:**
   - Node.js: `process.env.VARIABLE`, `env.VARIABLE`, `import.meta.env.VARIABLE`
   - Python: `os.environ["VARIABLE"]`, `os.getenv("VARIABLE")`, `env("VARIABLE")`
   - Go: `os.Getenv("VARIABLE")`
   - Ruby: `ENV["VARIABLE"]`, `ENV.fetch("VARIABLE")`

2. **Buscar archivos .env:**
   - `.env` — variables locales actuales
   - `.env.example` / `.env.template` — template de referencia
   - `.env.local` — overrides locales
   - `.env.development` / `.env.production` — por entorno

3. **Comparar y reportar:**

| Variable | En codigo | En .env | En .env.example | Estado |
|----------|:---------:|:-------:|:---------------:|--------|
| DATABASE_URL | ✅ | ✅ | ✅ | OK |
| API_KEY | ✅ | ❌ | ✅ | FALTA |
| OLD_VAR | ❌ | ✅ | ✅ | SOBRA |

4. **Validar formatos comunes:**
   - URLs: verificar que son URLs validas (DATABASE_URL, API_URL, etc.)
   - Puertos: verificar que son numeros entre 1-65535
   - Booleanos: verificar que son true/false, 1/0
   - Emails: formato basico de email
   - Secrets/keys: verificar que no son valores placeholder ("changeme", "xxx", "your-key-here")

5. **Resumen:**
   - Total variables en codigo: X
   - Configuradas: X
   - Faltantes: X (CRITICO si > 0)
   - Sobrantes: X (limpieza recomendada)

### Comando: `missing`
Solo listar variables que estan en el codigo pero NO en `.env`:
```
❌ MISSING: DATABASE_URL — referenciado en src/db/connection.ts:5
❌ MISSING: STRIPE_KEY — referenciado en src/payments/stripe.ts:12
```

### Comando: `compare`
Comparar `.env` actual con `.env.example`:
- Variables en .env.example pero no en .env → FALTANTES
- Variables en .env pero no en .env.example → NO DOCUMENTADAS
- Sugerir actualizar .env.example si hay variables no documentadas

### Comando: `generate`
Generar o actualizar `.env.example` a partir del codigo:
1. Escanear TODAS las variables referenciadas en el codigo fuente
2. Agrupar por modulo/funcionalidad
3. Generar `.env.example` con:
   - Comentarios por seccion
   - Valores placeholder seguros (no secrets reales)
   - Indicar cuales son obligatorias vs opcionales

**Formato de salida:**
```bash
# ===================
# App
# ===================
NODE_ENV=development
PORT=3000

# ===================
# Database (required)
# ===================
DATABASE_URL=postgresql://user:password@localhost:5432/mydb

# ===================
# Auth (required)
# ===================
JWT_SECRET=change-me-in-production
JWT_EXPIRES_IN=7d

# ===================
# External Services (optional)
# ===================
# STRIPE_SECRET_KEY=sk_test_...
# SENDGRID_API_KEY=SG...
```

4. Si ya existe `.env.example`, mostrar diff y preguntar si actualizar

### Comando: `secrets`
Verificar que no hay secrets reales en el repositorio:
1. Revisar que `.env` esta en `.gitignore`
2. Buscar archivos `.env` trackeados por git: `git ls-files | grep -E "^\.env$|\.env\.local$|\.env\.production$"`
3. Buscar valores que parecen secrets reales en archivos commiteados:
   - Strings largos que parecen API keys
   - Connection strings con passwords
   - Tokens JWT hardcodeados
4. Si encuentra algo, marcar como CRITICO y sugerir:
   - Agregar a .gitignore
   - Rotar el secret comprometido
   - Limpiar del historial con `git filter-branch` o BFG

## Reglas
- NUNCA mostrar valores reales de variables de entorno en el output
- NUNCA leer ni mostrar el contenido completo de archivos .env
- Solo reportar NOMBRES de variables, no sus valores
- Si detecta secrets en el repo, alertar inmediatamente
- Usar mascaras para valores sensibles: `DATABASE_URL=postgres://***:***@localhost/db`
