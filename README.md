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

## Despliegue en GitHub Pages (`https://bassgt.github.io`)

1. En GitHub, crea el repositorio con el nombre exacto: `BassGT.github.io` (o clónalo si ya lo creaste).
2. Copia los archivos del portafolio (`index.html`, `style.css`, `main.js`, `cv.pdf`) a la raíz de ese repositorio.
3. Haz commit y push a la rama `main`:
   ```bash
   git add .
   git commit -m "Deploy portfolio built with Elm"
   git push origin main
   ```
4. ¡Listo! En segundos tu sitio estará publicado y disponible globalmente en:
   **https://bassgt.github.io**
