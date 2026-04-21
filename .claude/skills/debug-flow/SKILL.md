---
name: debug-flow
description: Debug sistematico de un bug — reproducir, aislar, hipotesis, validar, fix, test de regresion. Usa cuando hay un bug reportado o algo no funciona como se espera.
---

# Skill: Debug Flow

Protocolo de debug para bugs reales. Enfocado en NO hacer cambios aleatorios ("funciona en mi maquina"), sino aislar con rigor.

## Cuando activar

- "hay un bug en X — cuando hago Y, pasa Z"
- "no funciona el login despues del ultimo deploy"
- "los emails no se envian a veces"
- "falla solo en prod"

## Filosofia

1. **Primero reproducir.** Si no puedes reproducir, no puedes arreglar. Reproducir > teorizar.
2. **Una hipotesis a la vez.** No cambies 5 cosas y "a ver si funciona".
3. **Arreglo minimo.** Fix el bug, NO refactorices alrededor (eso es otra tarea).
4. **Test de regresion.** Cada bug fijado merece un test que garantiza que no vuelve.

## Proceso

### 1. Reproducir

Conseguir pasos exactos que fallan SIEMPRE (o con alta probabilidad):
- Input exacto (datos, estado, env)
- Entorno (local / dev / prod)
- Usuario/rol usado
- Expected vs actual

Si no reproduce al 100%:
- Es flaky / race condition / dependiente de datos
- Agregar logs antes de debuggear (tipo y timing importan)

### 2. Aislar

Reducir el caso minimo:
- Empezar por "en vacio": arranca el bug desde el menor estado posible
- Aislar capa: frontend? API? DB? red?
- `git bisect` si no sabes cuando aparecio el bug

### 3. Formular hipotesis

Escribe (en el chat o en el issue):
> "Creo que falla porque X. Si es verdad, entonces al hacer Y deberia ver Z."

### 4. Validar/refutar hipotesis

- Agregar log estrategico
- Breakpoint (con debugger)
- `console.log({ input, expected, actual })` en el punto critico
- Query directa a DB para ver estado real

Si la hipotesis es falsa: descartar y formular otra. NO acumular hipotesis en paralelo.

### 5. Fix minimo

Cuando encuentras la causa:
- Cambia SOLO lo necesario
- NO refactorizes alrededor (deja un TODO si quieres, pero NO mezcles cleanup con fix)
- Commit dedicado al fix: `fix: [bug resumido]`

### 6. Test de regresion

Escribir test que:
- Reproduce el bug EN SU FORMA ORIGINAL (falla sin el fix)
- Pasa con el fix aplicado
- Tiene nombre que explica el bug: `it('should not fail when user has no customers and filters by active')`

### 7. Documentar

Si el bug fue sutil / importante:
- Agregar comentario en el codigo SOLO si el por-que no es obvio
- Entrada en `docs/postmortems/` si fue incidente de prod
- Mencionar en PR description: root cause + fix + test

## Patrones comunes

### Race condition
- Hay await faltante? Promise no esperada?
- Dos renders en paralelo del mismo componente?
- Dos requests que mutan el mismo recurso?

### State stale
- Closure captura valor viejo?
- Cache no invalidada?
- `useEffect` con deps incompletas?

### Boundary errors
- Input vacio / null / undefined?
- Array con 0 / 1 elementos?
- Zonas horarias?
- Numeros float en dinero (deberia ser decimal)?

### Environment drift
- Funciona local pero no en prod → diff de env vars
- Diff de versiones de DB / Node / libs
- Secrets diferentes

## Reglas

- NUNCA pushear "fix probable" a prod sin validar local primero
- NUNCA combinar fix + refactor en mismo commit
- NUNCA saltar el test de regresion
- Siempre entender la causa ANTES de arreglar — "lo pongo y ya" es deuda tecnica

## Delegacion

- Bug de queries / performance DB: `@db-expert` o `@performance-profiler`
- Bug de UI / re-renders: `@frontend-reviewer`
- Bug en flujo completo: `@e2e-runner` para reproducir
- Bug de seguridad: `@security-auditor`
