# /audit — Business coherence audit

Analiza módulos del sistema para detectar inconsistencias entre frontend, backend y lógica de negocio.

## Uso
```
/audit all              → Auditoría completa de todos los módulos
/audit {module}         → Solo un módulo específico
```

## Instrucciones

1. **Para cada módulo**, analizar:
   - **Frontend**: ¿Qué pantallas existen? ¿Qué acciones puede hacer cada rol?
   - **Backend**: ¿Qué endpoints existen? ¿Qué DTOs validan? ¿Qué roles tienen acceso?
   - **Coherencia**: ¿El frontend puede llamar endpoints que no existen? ¿Hay endpoints sin UI?
   - **RBAC**: ¿Los permisos del frontend coinciden con los del backend?
   - **Flujo E2E**: ¿Se puede completar el flujo completo sin errores?

2. **Clasificar hallazgos**:
   - 🔴 **CRÍTICO**: Rompe funcionalidad (endpoint no existe, crash)
   - 🟠 **ALTO**: Inconsistencia de negocio (rol sin acceso a feature que debería tener)
   - 🟡 **MEDIO**: UX confusa pero funcional (botón que no hace nada visible)
   - 🟢 **BAJO**: Mejora sugerida (falta validación visual)

3. **Generar reporte** con:
   - Tabla resumen de hallazgos por módulo y severidad
   - Detalle por hallazgo
   - Plan de acción priorizado

4. **Crear issues en GitHub** para hallazgos CRÍTICO y ALTO (preguntar antes)
