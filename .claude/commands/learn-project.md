# /learn-project — Aprende los estandares de un proyecto existente

Escanea el codigo fuente de un proyecto existente, extrae sus patrones, convenciones y estandares reales, y los almacena en archivos que Claude Code usara automaticamente en futuras sesiones.

## Uso
```
/learn-project              → Escaneo completo del proyecto
/learn-project backend      → Solo analiza backend
/learn-project frontend     → Solo analiza frontend
/learn-project db           → Solo analiza base de datos/SQL
/learn-project quick        → Escaneo rapido (solo estructura y naming)
```

## Instrucciones

### Fase 1: Descubrimiento del stack

1. **Detecta el lenguaje y framework** analizando:
   - Archivos de proyecto: `*.dpr`, `*.csproj`, `package.json`, `go.mod`, `Cargo.toml`, `requirements.txt`, `Gemfile`, `pom.xml`, `*.sln`
   - Extensiones predominantes: `.pas`, `.cs`, `.ts`, `.py`, `.go`, `.rs`, `.java`, `.rb`, `.php`
   - Archivos de configuracion: `tsconfig.json`, `pyproject.toml`, `.editorconfig`, etc.

2. **Detecta herramientas de build/test/lint**:
   - Build: `msbuild`, `make`, `gradle`, `webpack`, `vite`, etc.
   - Test: `DUnit`, `NUnit`, `Jest`, `pytest`, `go test`, etc.
   - Lint: `eslint`, `pylint`, `golint`, etc.
   - CI: `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`, etc.

3. **Detecta la base de datos**:
   - Archivos SQL, migraciones, schemas
   - Connection strings en configs
   - ORM: Prisma, SQLAlchemy, GORM, Entity Framework, IBX, etc.

4. Presenta resumen:
```
## Stack detectado
- Lenguaje: [detectado]
- Framework: [detectado]
- Base de datos: [detectado]
- Tests: [detectado]
- Build: [detectado]
- Estructura: [descripcion]
```

### Fase 2: Extraccion de patrones

Analiza entre 15-30 archivos representativos del proyecto (los mas grandes, mas editados, o mas importados) y extrae:

#### Naming conventions
- Clases/tipos: PascalCase? camelCase? snake_case? Prefijo T/I/C?
- Variables: camelCase? snake_case? Prefijo F/m_/p_?
- Funciones/metodos: camelCase? PascalCase? snake_case?
- Constantes: UPPER_SNAKE? k prefix?
- Archivos: kebab-case? PascalCase? snake_case?
- Tablas BD: singular? plural? snake_case? Prefijo tbl_?

#### Estructura de archivos
- Como se organizan los directorios (por feature? por tipo? por capa?)
- Donde van los tests (junto al archivo? en carpeta separada?)
- Donde van las migraciones, configs, utils

#### Patrones de codigo recurrentes
- Patron de acceso a datos (Repository? DAO? directo?)
- Manejo de errores (excepciones tipadas? codigos? Result type?)
- Inyeccion de dependencias (constructor? container? global?)
- Logging (que patron usan?)
- Autenticacion/autorizacion (donde se valida?)

#### Anti-patrones detectados (problemas comunes en el codigo)
- SQL concatenado (injection risk)
- Recursos sin liberar (memory leaks)
- Hardcoded secrets
- Sin manejo de errores
- God classes/forms (archivos de 1000+ lineas)

#### Patrones de base de datos
- Naming de tablas y columnas
- Uso de foreign keys y constraints
- Indices existentes
- Stored procedures / triggers
- Patron de migraciones

### Fase 3: Generacion de archivos

Genera los siguientes archivos con los patrones extraidos:

#### 1. Actualiza CLAUDE.md
Si los placeholders `{{}}` no estan reemplazados, los reemplaza con los valores detectados. Si ya tiene valores, sugiere actualizaciones.

#### 2. Genera reglas contextuales en `.claude/rules/`

Crea archivos `.md` con globs especificos para el proyecto. Ejemplo para Delphi:

```markdown
# .claude/rules/delphi-units.md
---
globs: "*.pas"
---
# Convenciones extraidas del proyecto
- Clases con prefijo T: TCustomer, TOrderService
- Campos privados con prefijo F: FName, FTotal
- Parametros con prefijo A: ACustomerId, AOrderData
- Usar try/finally para todo Create/Free
- Queries parametrizadas con ParamByName, nunca concatenar
...
```

#### 3. Genera `.claude/commands/standards.md` actualizado

Reemplaza los ejemplos genericos con ejemplos REALES del proyecto:

```markdown
# /standards — Estandares de [NOMBRE DEL PROYECTO]

## Naming
**CORRECTO** (extraido de src/models/Customer.pas):
  TCustomer = class / FName: string / ACustomerId: Integer

**INCORRECTO:**
  Customer = class / Name: string / customerId: Integer

## Acceso a datos
**CORRECTO** (extraido de src/datamodules/dmOrders.pas):
  qryOrders.ParamByName('customer_id').AsInteger := ACustomerId;

**INCORRECTO:**
  qryOrders.SQL.Text := 'SELECT * FROM orders WHERE customer_id = ' + IntToStr(Id);
...
```

#### 4. Actualiza el agente relevante

Si existe un agente generico, lo especializa con los patrones del proyecto.

### Fase 4: Resumen y recomendaciones

Presenta:

```
## Estandares extraidos y almacenados

### Archivos generados/actualizados
- [x] CLAUDE.md — Stack y comandos actualizados
- [x] .claude/rules/[lenguaje].md — N reglas contextuales
- [x] .claude/commands/standards.md — Ejemplos reales del proyecto
- [x] .claude/agents/[dominio].md — Agente especializado (si aplica)

### Patrones detectados
| Categoria | Patron | Ejemplo |
|-----------|--------|---------|
| Naming clases | PascalCase + T | TCustomer |
| Naming campos | F prefix | FName |
| ...

### Problemas detectados (revisar)
| # | Severidad | Archivo | Problema |
|---|-----------|---------|----------|
| 1 | CRITICO | dmOrders.pas:45 | SQL concatenado |
| 2 | ALTO | frmMain.pas | Form de 3200 lineas (god class) |
| ...

### Recomendaciones
1. [Recomendacion basada en anti-patrones encontrados]
2. [...]
```

## Notas importantes

- Este skill NO modifica codigo del proyecto — solo genera archivos de configuracion de Claude Code
- Si ya existen archivos de rules/standards, pregunta antes de sobrescribir
- Para proyectos grandes (100+ archivos), muestrea los mas representativos
- Incluye el hash o fecha del analisis para saber cuando se extrajo
