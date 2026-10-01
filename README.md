# Portafolio Web en Elm — Sebastian Medrano (BassGT)

Portafolio personal desarrollado con **Elm 0.19.1** (arquitectura funcional pura con cero excepciones en tiempo de ejecución), estilizado con una paleta moderna para desarrolladores de sistemas (Catppuccin Macchiato) e iconos de Devicon y FontAwesome.

## Estructura del Proyecto

```text
portfolio/
├── src/
│   └── Main.elm         # Código fuente funcional en Elm (TEA)
├── elm.json             # Configuración y dependencias de Elm
├── index.html           # Punto de entrada HTML que monta la app Elm
├── style.css            # Estilos CSS modernos y responsivos
├── main.js              # JavaScript generado y optimizado por Elm
├── cv.pdf               # Copia del CV compilado para descarga directa
├── Makefile             # Comandos de compilación rápida
└── README.md            # Esta guía
```

## Compilación y Desarrollo

- **Compilar para producción (optimizado):**
  ```bash
  make build
  # O directamente:
  elm make src/Main.elm --optimize --output=main.js
  ```

- **Servidor de desarrollo local:**
  ```bash
  make dev
  # O bien con cualquier servidor HTTP local:
  python3 -m http.server 8000
  ```
  Luego abre en tu navegador `http://localhost:8000`.

## Despliegue en GitHub Pages

El repositorio Git local ya está inicializado y listo para subir a GitHub Pages:

### Opción A: Desplegar en MsebasGit (`https://msebasgit.github.io`)
1. En GitHub (con la cuenta **MsebasGit**), crea un repositorio público llamado:
   `MsebasGit.github.io` (en blanco, sin inicializar con README/license).
2. Ejecuta en tu terminal dentro de la carpeta `portfolio`:
   ```bash
   git push -u origin main
   ```
3. ¡Listo! En segundos tu sitio estará en vivo en **https://msebasgit.github.io**.

### Opción B: Desplegar en BassGT (`https://bassgt.github.io`)
1. En GitHub (con la cuenta **BassGT**), crea un repositorio público llamado:
   `BassGT.github.io`.
2. Ejecuta:
   ```bash
   git push -u bassgt main
   ```
3. ¡Listo! Tu sitio estará disponible en **https://bassgt.github.io**.
