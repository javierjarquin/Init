---
globs: "*"
---

# Reglas anti-alucinacion (aplica a TODOS los archivos)

## Antes de referenciar algo, VERIFICALO

- NUNCA menciones una funcion, clase, tabla, endpoint o archivo sin haberlo BUSCADO primero
- Si no lo encontraste con Grep/Glob/Read, NO EXISTE — dilo claramente
- Usa los nombres EXACTOS del codigo, no los del requerimiento del usuario
  - Usuario dice "tabla de clientes" → busca primero si se llama CLIENTES, customers, tbl_cliente, etc.
  - Usuario dice "endpoint de login" → busca si es /auth/login, /api/login, /users/signin, etc.

## Antes de editar, LEE el archivo

- NUNCA edites un archivo que no hayas leido en esta sesion
- Verifica que la linea/funcion que vas a modificar EXISTE tal como la describes
- Si el archivo cambio desde la ultima lectura, vuelve a leerlo

## Antes de implementar, VERIFICA dependencias

- Si creas un nuevo archivo, verifica que los imports/uses que vas a poner EXISTEN
- Si modificas una funcion, verifica quien la llama (puede romper otros archivos)
- Si modificas una tabla, verifica foreign keys y queries que la usan

## Cuando NO encuentres algo

- DI CLARAMENTE: "No encontre X en el proyecto. ¿Se llama diferente o hay que crearlo?"
- NO inventes: "probablemente se llama..." o "deberia estar en..."
- NO asumas estructura: cada proyecto es diferente

## Numeros y datos

- No inventes metricas, tiempos, o conteos — usa herramientas para obtenerlos
- Si no puedes verificar un dato, di "no puedo confirmar esto sin acceso a..."
