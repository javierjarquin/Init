---
name: "QA Finding"
about: "Document a QA audit finding"
title: "qa: "
labels: ["qa", "triage"]
assignees: []
---

## Hallazgo QA
- **ID:** <!-- ej: QA-001 -->
- **Flujo auditado:** <!-- ej: Login, Dashboard, Checkout -->
- **Tipo de prueba:** <!-- Funcional / Integración / Edge Case / Seguridad / UX / Regresión -->
- **Criticidad:** <!-- 🔴 CRÍTICO / 🟠 ALTO / 🟡 MEDIO / 🟢 BAJO -->

## Test E2E
- **Archivo:** <!-- ruta al spec file -->
- **Test:** <!-- nombre exacto del test -->
- **Resultado:** <!-- ❌ FALLÓ / ⚠️ SIN COBERTURA -->

## Error
```
<!-- Pegar el error completo aquí -->
```

## Análisis
- **¿Es bug real o test desactualizado?** <!-- análisis -->
- **Módulos afectados:** <!-- listar módulos -->
- **Archivos sospechosos:** <!-- rutas de código -->

## Recomendación
<!-- Qué se debe corregir y cómo -->

## Evidencia
<!-- Screenshots, logs, HTML report -->

## Resolución sugerida
- [ ] `/fix-qa` — Es un bug de código
- [ ] `/refactor` — Necesita refactoring
- [ ] `/e2e create` — Falta cobertura E2E
