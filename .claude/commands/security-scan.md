# /security-scan — Security scan

Ejecuta un escaneo completo de seguridad del proyecto.

## Uso
```
/security-scan          → Escaneo completo
/security-scan deps     → Solo dependencias
/security-scan secrets  → Solo buscar secrets
/security-scan code     → Solo análisis de código
```

## Instrucciones

### 1. Dependencias (vulnerabilidades conocidas)
```bash
# Node.js
npm audit / pnpm audit

# Python
pip-audit / safety check

# Go
govulncheck ./...
```
- Reportar total por severidad (low/moderate/high/critical)
- Listar las HIGH y CRITICAL con fix sugerido

### 2. Secrets en código
Buscar patrones de secrets que no deberían estar en el repo:
- API keys: `sk_live`, `pk_live`, `AKIA`, `ghp_`, `gho_`
- Passwords hardcodeados: `password.*=.*['"]`
- Archivos `.env` commiteados (que no sean `.env.example`)
- Archivos sensibles: `*.pem`, `*.key`, `credentials.json`, `*.p12`
- Private keys en código
- Connection strings con credenciales

### 3. Análisis de código
Buscar patrones inseguros:
- **SQL injection**: queries raw sin parametrizar
- **XSS**: `dangerouslySetInnerHTML`, `innerHTML`, `v-html` sin sanitizar
- **eval / Function**: `eval(`, `new Function(`
- **Command injection**: `exec(`, `spawn(` con input de usuario
- **Path traversal**: `../` en inputs de archivos
- **CORS misconfiguration**: `origin: '*'` en producción
- **Missing security headers**: Helmet/CSP/HSTS

### 4. Generar reporte
Mostrar tabla resumen:
| Categoría | Hallazgos | Severidad |
|-----------|-----------|-----------|

Si hay hallazgos HIGH/CRITICAL, preguntar si crear issue en GitHub.

### 5. CSRF (Cross-Site Request Forgery)
Verificar proteccion CSRF en formularios y endpoints que mutan datos:
- Buscar formularios POST/PUT/DELETE sin token CSRF
- Verificar que el framework tiene CSRF middleware habilitado:
  - Next.js: verificar `csrf` en middleware o usar `next-csrf`
  - Express: `csurf` o `csrf-csrf` middleware
  - Django: `CsrfViewMiddleware` habilitado
  - NestJS: `csurf` middleware
- Verificar `SameSite` en cookies de sesion (debe ser `Strict` o `Lax`, nunca `None` sin HTTPS)
- Buscar endpoints que aceptan `Content-Type: application/x-www-form-urlencoded` sin proteccion

### 6. Rate Limiting
Verificar que endpoints criticos tienen rate limiting:
- **Login/auth**: maximo 5-10 intentos por minuto por IP
- **Registro**: maximo 3-5 por hora por IP
- **API publica**: limites por API key o IP
- **Uploads**: limites de tamanio y frecuencia
- **Webhooks**: validacion de firma + rate limit
- Buscar si hay middleware de rate limiting configurado:
  - Express: `express-rate-limit`
  - NestJS: `@nestjs/throttler`
  - Next.js: middleware custom o `next-rate-limit`
  - Django: `django-ratelimit`
- Si NO hay rate limiting: marcar como HIGH

### 7. Encryption y Data Protection
Verificar:
- **En transito**: HTTPS obligatorio en produccion (no HTTP)
- **En reposo**: datos sensibles encriptados en BD (passwords, tokens, PII)
- **Passwords**: NUNCA en texto plano. Usar bcrypt/argon2/scrypt con salt
- **API keys**: almacenadas en variables de entorno, NUNCA en codigo
- **JWT**: verificar que usa algoritmo seguro (RS256 o ES256, no HS256 con secret debil)
- **Cookies**: flags `HttpOnly`, `Secure`, `SameSite`
- Buscar patrones inseguros:
  - `md5(`, `sha1(` para passwords (inseguros)
  - `algorithm: 'HS256'` con secret corto
  - `httpOnly: false` en cookies de sesion
  - `secure: false` en cookies de produccion

### 8. Audit Trail y Logging
Verificar que el proyecto tiene logging adecuado:
- **Acciones criticas loggeadas**: login, logout, cambio de password, cambios de roles, eliminacion de datos
- **NO loggear datos sensibles**: passwords, tokens, tarjetas de credito, PII
- **Formato estructurado**: JSON logs con timestamp, userId, action, resource
- Buscar patrones problematicos:
  - `console.log(password` o `console.log(token` — datos sensibles en logs
  - `console.log(req.body)` — puede exponer datos sensibles
  - Falta de logging en endpoints de auth

### 9. Checks OWASP Top 10
- [ ] A01 Broken Access Control — verificar RBAC en endpoints
- [ ] A02 Crypto Failures — verificar encryption (ver seccion 7)
- [ ] A03 Injection — verificar queries parametrizadas
- [ ] A04 Insecure Design — verificar aislamiento de datos
- [ ] A05 Security Misconfiguration — verificar headers, CORS, CSRF
- [ ] A06 Vulnerable Components — audit de dependencias
- [ ] A07 Auth Failures — verificar auth, lockout, rate limit (ver seccion 6)
- [ ] A08 Data Integrity — verificar audit log (ver seccion 8)
- [ ] A09 Logging — verificar logging seguro (ver seccion 8)
- [ ] A10 SSRF — verificar fetch/axios/http calls
