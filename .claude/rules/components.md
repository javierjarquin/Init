---
globs: "**/*.tsx,**/*.jsx,**/components/**"
---

# Reglas para componentes frontend

- Componentes pequenos y con responsabilidad unica
- Props tipadas con interface o type (nunca `any`)
- Usa composicion sobre herencia
- Maneja estados de loading, error y empty explicitamente
- Accesibilidad: usa elementos semanticos (button, nav, main, article)
- Accesibilidad: agrega aria-labels a elementos interactivos sin texto visible
- Accesibilidad: asegura contraste de colores WCAG AA (4.5:1 texto, 3:1 UI)
- No uses `dangerouslySetInnerHTML` sin sanitizar el contenido
- Prefiere CSS modules, Tailwind o styled-components sobre estilos inline
- Imagenes: siempre incluye alt text descriptivo
