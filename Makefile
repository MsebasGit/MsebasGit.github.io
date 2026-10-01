# Comandos rápidos para el portafolio en Elm

build:
	elm make src/Main.elm --optimize --output=main.js

dev:
	elm reactor

clean:
	rm -rf elm-stuff main.js
