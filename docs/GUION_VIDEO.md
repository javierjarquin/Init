# Guion de Video — Claude Code Starter Kit

> **Duracion estimada:** 15-20 minutos
> **Audiencia:** Desarrolladores que quieren maximizar Claude Code
> **Formato:** Screencast con narración

---

## INTRO (1 min)

**[Pantalla: GitHub repo del starter kit]**

> "Que onda, soy Javier Jarquin. Hoy les voy a enseñar como usar Claude Code al 100% con un starter kit que desarrolle despues de construir un sistema SaaS completo — Mi Tallercito, un sistema de gestion para talleres mecanicos.
>
> Durante ese proyecto descubri que Claude Code es MUY poderoso, pero sin estructura se pierde. Asi que cree este kit con 29 skills, workflows y buenas practicas que hacen que Claude trabaje como un desarrollador senior."

**[Pantalla: Mostrar las carpetas del repo]**

> "El kit incluye:
> - 29 slash commands que Claude Code entiende
> - Templates de GitHub para PRs e issues
> - Documentacion de procesos: definition of done, releases, incidentes
> - Y lo mas importante: un archivo CLAUDE.md que le dice a Claude exactamente como trabajar en tu proyecto"

---

## SECCION 1: INSTALACION (2 min)

**[Pantalla: Terminal]**

> "Empecemos. Tengo un proyecto nuevo — una app de e-commerce. Voy a instalar el starter kit."

```bash
# Clonar el kit
git clone https://github.com/javierjarquin/Init.git claude-code-starter-kit

# Ejecutar el instalador
cd claude-code-starter-kit
setup.bat C:\Users\mi-usuario\proyectos\mi-ecommerce
```

**[Pantalla: Archivos copiados al proyecto]**

> "El script copia todo sin sobrescribir. Ahora mi proyecto tiene la carpeta `.claude/commands/` con los 29 skills, los templates de GitHub, y la documentacion de procesos."

**[Pantalla: Abrir CLAUDE.md]**

> "Lo primero que hago es editar CLAUDE.md. Este archivo es la CLAVE — Claude lo lee al inicio de cada conversacion. Aqui defino mi stack, mis comandos, mi estructura de proyecto."

```markdown
# CLAUDE.md — Mi E-Commerce

## Tech Stack
| Layer    | Technology      |
|----------|-----------------|
| Backend  | Next.js 14      |
| Database | PostgreSQL      |
| ORM      | Prisma          |

## Common Commands
pnpm dev      # Desarrollo
pnpm test     # Tests
pnpm build    # Build
```

---

## SECCION 2: PRIMER SKILL — /status (1 min)

**[Pantalla: Claude Code abierto en VS Code]**

> "Verificamos que todo funcione. Escribo `/status`."

```
> /status
```

**[Pantalla: Claude responde con dashboard del proyecto]**

> "Claude me da un dashboard completo: archivos, dependencias, tests, cobertura, issues abiertos. Esto es gratis — solo con tener el skill configurado."

---

## SECCION 3: CREAR UNA FEATURE — /feature (3 min)

**[Pantalla: Claude Code]**

> "Ahora voy a crear mi primera feature. El modulo de productos."

```
> /feature "products"
```

**[Pantalla: Claude crea branch, scaffold, archivos]**

> "Miren lo que hace Claude:
> 1. Crea la branch `feat/products`
> 2. Genera el servicio, las acciones, los tipos
> 3. Crea la pagina con formulario
> 4. Registra todo en el modulo principal
>
> En 30 segundos tengo el scaffold completo. Ahora le digo que implemente la logica."

```
> Implementa CRUD completo de productos con nombre, precio, stock, categoria.
> Usa React Hook Form con Zod para validacion.
```

**[Pantalla: Claude genera el codigo]**

> "Claude ya sabe mi stack porque lo defini en CLAUDE.md. Genera codigo que sigue mis convenciones."

---

## SECCION 4: TESTING — /test-unit y /e2e (2 min)

**[Pantalla: Claude Code]**

> "Ahora le pido tests."

```
> /test-unit create products
```

> "Claude crea tests unitarios con mocks para el servicio de productos."

```
> /e2e create "product CRUD flow"
```

> "Y tests E2E con Playwright que prueban el flujo completo: crear, editar, eliminar un producto en el browser real."

**[Pantalla: Tests corriendo y pasando]**

> "Todos pasan. Pero ojo — `/test-unit` y `/e2e` no solo CORREN tests. Tambien los CREAN si no existen. Esa es la diferencia con un script de CI."

---

## SECCION 5: CODE REVIEW — /code-review (2 min)

**[Pantalla: Claude Code]**

> "Antes de hacer commit, corro el code review. Este es uno de los skills que cree durante el proyecto de Mi Tallercito — basado en bugs REALES que encontre."

```
> /code-review --full
```

**[Pantalla: Claude ejecuta 10 checks]**

> "Claude revisa 10 puntos criticos:
> - Hydration mismatches — el error mas comun en Next.js
> - Props faltantes — que causan ReferenceError en runtime
> - CSS resets destructivos — que anulan Tailwind
> - Formularios con Zod que fallan con inputs vacios
> - RLS sin policies — que bloquea todo acceso a la DB
> - Y 5 mas.
>
> Cada punto viene de un bug REAL que me costo horas debuggear. Ahora Claude los detecta en segundos."

---

## SECCION 6: VALIDATE — El workflow pre-merge (2 min)

**[Pantalla: Claude Code]**

> "El skill mas poderoso es `/validate`. Combina 4 pasos en uno."

```
> /validate --fix
```

> "Ejecuta:
> 1. Code review tecnico — los 10 checks
> 2. Refactor check — imports muertos, tipos `any`, duplicados
> 3. Build check — TypeScript compila sin errores
> 4. Smoke test — Playwright verifica que la app funciona en el browser
>
> Si encuentra issues, los corrige automaticamente con `--fix`.
> Al final te da un reporte: PASS o FAIL con detalles."

**[Pantalla: Reporte de validate]**

```
| Paso         | Status | Detalles              |
|-------------|--------|-----------------------|
| Code Review | PASS   | 0 issues              |
| Refactor    | PASS   | 0 mejoras             |
| TypeScript  | PASS   | 0 errores             |
| Smoke Test  | PASS   | 5/5 tests pasaron     |
```

> "Si todo pasa, hago commit con confianza."

---

## SECCION 7: BUSINESS FLOWS — /flows y /flow-test (2 min)

**[Pantalla: Claude Code]**

> "Para proyectos con logica de negocio compleja, tengo dos skills clave."

```
> /flows add "order-lifecycle"
```

> "Claude investiga mi codigo y documenta el flujo real — no lo que yo CREO que hace, sino lo que REALMENTE hace. Genera la maquina de estados, la tabla paso a paso, y las reglas de negocio."

```
> /flow-test order-lifecycle fix
```

> "Despues lo pruebo con Playwright. `/flow-test` ejecuta el flujo completo en el browser real: login, crear orden, cambiar estado, verificar DB. Si algo falla, lo corrige automaticamente."

---

## SECCION 8: UX REVIEW — /ux-review (1 min)

**[Pantalla: Claude Code]**

> "Para frontend, tengo `/ux-review`."

```
> /ux-review mobile
```

> "Claude toma screenshots en desktop y mobile, y revisa:
> - Botones cortados o sin padding
> - Texto truncado
> - Overflow horizontal
> - Touch targets menores a 44px
> - Formularios inutilizables en movil
>
> Te da un reporte visual con PASS/FAIL por pagina."

---

## SECCION 9: STANDARDS — /standards (1 min)

**[Pantalla: Claude Code]**

> "Y cuando un developer nuevo se une al equipo, `/standards` es su biblia."

```
> /standards front
```

> "Claude muestra patrones CORRECTO vs INCORRECTO con codigo real:
> - Como manejar hydration
> - Como hacer forms con Zod
> - Como configurar Providers
> - Como hacer server actions seguras
>
> No es documentacion muerta — son patrones que se descubrieron debuggeando bugs reales."

---

## SECCION 10: DEPLOY Y HOTFIX (1 min)

**[Pantalla: Claude Code]**

> "Finalmente, el deploy."

```
> /deploy-dev
```

> "Claude hace commit, push, y crea PR a development."

```
> /deploy-prod
```

> "Mergea a main con verificacion. Y si algo falla..."

```
> /hotfix "payment crash"
```

> "Hotfix directo a main con el fix minimo necesario. Y si el hotfix rompe algo..."

```
> /rollback prod
```

> "Rollback inmediato al deploy anterior."

---

## SECCION 11: EL WORKFLOW COMPLETO (1 min)

**[Pantalla: Diagrama del workflow]**

> "Asi se ve el workflow completo de una feature:"

```
/feature → Desarrollo → /code-review → /validate → /deploy-dev → /qa → /deploy-prod
```

> "Y el quality gate antes de cada release:"

```
/code-review --full → /standards → /validate --fix → /flow-test → /ux-review → /qa → /deploy-prod
```

> "Todo esto viene INCLUIDO en el starter kit. Cero configuracion."

---

## CIERRE (1 min)

**[Pantalla: GitHub repo]**

> "El repo es open source. Lo encuentran en github.com/javierjarquin/Init
>
> Clonenlo, instalen en su proyecto, y empiecen a usar los skills desde el dia 1.
>
> Lo mas importante que aprendi: Claude Code no es solo un copilot que genera codigo. Con la estructura correcta, es un QA, un DevOps, un reviewer, y un arquitecto. Solo hay que decirle como trabajar.
>
> Eso es exactamente lo que hace este starter kit.
>
> Nos vemos en el siguiente video. Compartan y comenten si les sirvio."

---

## NOTAS DE PRODUCCION

### Pantallas a grabar:
1. GitHub repo (intro)
2. Terminal: clone + setup
3. CLAUDE.md editandose
4. Claude Code en VS Code: cada skill ejecutandose
5. Browser: app funcionando (smoke tests)
6. Reportes de cada skill (validate, code-review, ux-review)
7. Diagrama del workflow completo

### Tips de grabacion:
- Usar zoom 150% en VS Code para legibilidad
- Terminal con fuente grande (16px+)
- Pausar entre skills para que se vea el resultado
- Mostrar antes/despues cuando un skill corrige algo
- Cerrar notificaciones y pestañas innecesarias

### Musica/Transiciones:
- Intro: 3 segundos de logo + nombre
- Entre secciones: fade rapido (0.5s)
- Cierre: logo + URL del repo + "Like & Subscribe"
