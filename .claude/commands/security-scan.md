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

### 5. Checks OWASP Top 10
- [ ] A01 Broken Access Control — verificar RBAC en endpoints
- [ ] A02 Crypto Failures — verificar encryption
- [ ] A03 Injection — verificar queries parametrizadas
- [ ] A04 Insecure Design — verificar aislamiento de datos
- [ ] A05 Security Misconfiguration — verificar headers, CORS
- [ ] A06 Vulnerable Components — audit de dependencias
- [ ] A07 Auth Failures — verificar auth, lockout, rate limit
- [ ] A08 Data Integrity — verificar audit log
- [ ] A09 Logging — verificar logging de errores
- [ ] A10 SSRF — verificar fetch/axios/http calls
