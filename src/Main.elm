module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (alt, attribute, class, classList, controls, href, id, preload, rel, src, style, target, title)
import Html.Events exposing (onClick)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { activeTab : TerminalTab
    , activeProjectTab : ProjectTab
    , activeModal : ActiveModal
    , showcaseTab : ShowcaseTab
    , isLightPaper : Bool
    }


type TerminalTab
    = TabPodman
    | TabHackage
    | TabSystemd
    | TabUname


type ProjectTab
    = TabAll
    | TabFuyuGpio
    | TabFuyuGpioDirect
    | TabWaterTank


type ActiveModal
    = NoModal
    | ModalWaterTank


type ShowcaseTab
    = ShowcaseVideos
    | ShowcaseFlows
    | ShowcaseArch


initialModel : Model
initialModel =
    { activeTab = TabPodman
    , activeProjectTab = TabAll
    , activeModal = NoModal
    , showcaseTab = ShowcaseVideos
    , isLightPaper = False
    }



-- UPDATE


type Msg
    = SelectTab TerminalTab
    | SelectProjectTab ProjectTab
    | SelectShowcaseTab ShowcaseTab
    | OpenModal ActiveModal
    | CloseModal
    | ToggleTheme
    | NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectTab tab ->
            { model | activeTab = tab }

        SelectProjectTab pTab ->
            { model | activeProjectTab = pTab }

        SelectShowcaseTab sTab ->
            { model | showcaseTab = sTab }

        OpenModal modal ->
            { model | activeModal = modal }

        CloseModal ->
            { model | activeModal = NoModal }

        ToggleTheme ->
            { model | isLightPaper = not model.isLightPaper }

        NoOp ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ classList
            [ ( "app-container", True )
            , ( "theme-paper", model.isLightPaper )
            , ( "theme-slackware", not model.isLightPaper )
            , ( "modal-open", model.activeModal /= NoModal )
            ]
        ]
        [ viewNavbar model
        , viewHero model
        , viewProjects model
        , viewSkills
        , viewCertificates
        , viewFooter
        , viewModal model
        ]


viewNavbar : Model -> Html Msg
viewNavbar model =
    header [ class "navbar" ]
        [ div [ class "nav-brand" ]
            [ span [ class "status-dot" ] []
            , span [ class "brand-name" ] [ text "BassGT" ]
            , span [ class "brand-role" ] [ text "/ Sebastian Medrano" ]
            ]
        , nav [ class "nav-links" ]
            [ a [ href "#proyectos" ] [ text "Proyectos" ]
            , button [ class "nav-link-btn", onClick (OpenModal ModalWaterTank) ]
                [ text "Tanque IoT (Demo)" ]
            , a [ href "#habilidades" ] [ text "Habilidades" ]
            , a [ href "#certificaciones" ] [ text "Certificaciones" ]
            , a [ href "cv.pdf", target "_blank", rel "noopener noreferrer", class "btn-cv" ]
                [ i [ class "fa-solid fa-file-pdf" ] []
                , text " Descargar CV (PDF)"
                ]
            , button [ class "btn-theme-toggle", onClick ToggleTheme, title "Alternar modo claro / modo oscuro" ]
                [ i [ class (if model.isLightPaper then "fa-solid fa-moon" else "fa-regular fa-sun") ] []
                , text (if model.isLightPaper then " Modo Oscuro" else " Modo Blanco")
                ]
            ]
        ]


viewHero : Model -> Html Msg
viewHero model =
    section [ class "hero-section" ]
        [ div [ class "hero-content" ]
            [ div [ class "badge-available" ]
                [ span [ class "pulse-dot" ] []
                , text "Disponible para Pasantía / Prácticas Profesionales"
                ]
            , h1 [ class "hero-title" ]
                [ text "Sebastian Jorge "
                , span [ class "text-highlight" ] [ text "Medrano Chacolla" ]
                ]
            , h2 [ class "hero-subtitle" ]
                [ text "Ingeniería de Sistemas "
                , span [ class "separator" ] [ text "•" ]
                , text " Linux, Haskell, C++ & IoT / Edge"
                ]
            , p [ class "hero-bio" ]
                [ text "Desarrollador de software de sistemas enfocado en el kernel Linux, programación funcional pura y microcontroladores. Creador y mantenedor de las librerías oficiales en Hackage "
                , strong [] [ text "fuyu-gpio" ]
                , text " y "
                , strong [] [ text "fuyu-gpio-direct" ]
                , text " con bindings FFI a libgpiod v2. Construyo drivers de periféricos, pasarelas Edge con Podman sobre SBCs y software concurrente seguro en Haskell, C++ y Elm."
                ]
            , div [ class "hero-actions" ]
                [ a [ href "https://github.com/BassGT", target "_blank", rel "noopener noreferrer", class "btn-primary" ]
                    [ i [ class "fa-brands fa-github" ] []
                    , text " GitHub (BassGT)"
                    ]
                , a [ href "https://github.com/MsebasGit", target "_blank", rel "noopener noreferrer", class "btn-secondary" ]
                    [ i [ class "fa-brands fa-github" ] []
                    , text " GitHub (MsebasGit)"
                    ]
                , a [ href "https://hackage.haskell.org/package/fuyu-gpio", target "_blank", rel "noopener noreferrer", class "btn-secondary" ]
                    [ i [ class "fa-solid fa-box-open" ] []
                    , text " Paquetes en Hackage"
                    ]
                , button [ class "btn-secondary btn-demo-hero", onClick (OpenModal ModalWaterTank) ]
                    [ i [ class "fa-solid fa-circle-play" ] []
                    , text " Demo Tanque IoT"
                    ]
                , a [ href "mailto:sebastian11medrano@gmail.com", class "btn-ghost" ]
                    [ i [ class "fa-solid fa-envelope" ] []
                    , text " Contactar"
                    ]
                ]
            ]
        , div [ class "hero-terminal-wrapper" ]
            [ viewTerminal model ]
        ]


viewTerminal : Model -> Html Msg
viewTerminal model =
    div [ class "terminal-card" ]
        [ div [ class "terminal-header" ]
            [ div [ class "terminal-dots" ]
                [ span [ class "dot dot-1" ] []
                , span [ class "dot dot-2" ] []
                , span [ class "dot dot-3" ] []
                ]
            , div [ class "terminal-title" ] [ text "bass@orangepi-edge:~ (monochrome session)" ]
            ]
        , div [ class "terminal-tabs" ]
            [ button
                [ classList [ ( "term-tab", True ), ( "active", model.activeTab == TabHackage ) ]
                , onClick (SelectTab TabHackage)
                ]
                [ text "cabal info" ]
            , button
                [ classList [ ( "term-tab", True ), ( "active", model.activeTab == TabPodman ) ]
                , onClick (SelectTab TabPodman)
                ]
                [ text "podman ps" ]
            , button
                [ classList [ ( "term-tab", True ), ( "active", model.activeTab == TabSystemd ) ]
                , onClick (SelectTab TabSystemd)
                ]
                [ text "systemctl" ]
            , button
                [ classList [ ( "term-tab", True ), ( "active", model.activeTab == TabUname ) ]
                , onClick (SelectTab TabUname)
                ]
                [ text "uname -a" ]
            ]
        , div [ class "terminal-body" ]
            [ case model.activeTab of
                TabHackage ->
                    pre [ class "code-output" ]
                        [ span [ class "prompt" ] [ text "bass@orangepi:~$ " ]
                        , span [ class "cmd" ] [ text "cabal info fuyu-gpio fuyu-gpio-direct\n" ]
                        , text "* fuyu-gpio          (library)\n"
                        , text "  Synopsis:          High-level, type-safe Linux GPIO via libgpiod v2\n"
                        , text "  Latest version:    0.1.1.0\n"
                        , text "  License:           LGPL-2.1-or-later\n"
                        , text "* fuyu-gpio-direct   (library)\n"
                        , text "  Synopsis:          Direct Haskell bindings for Linux libgpiod v2\n"
                        , text "  Latest version:    0.2.0.0\n"
                        , text "  Author:            Sebastian Medrano (BassGT)\n"
                        , span [ class "term-highlight" ] [ text "  Category:          System, Hardware, Linux\n" ]
                        , span [ class "term-dim" ] [ text "  Repo:              https://github.com/BassGT/fuyu-gpio" ]
                        ]

                TabPodman ->
                    pre [ class "code-output" ]
                        [ span [ class "prompt" ] [ text "bass@orangepi:~$ " ]
                        , span [ class "cmd" ] [ text "podman ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'\n" ]
                        , text "NAMES               STATUS              PORTS\n"
                        , span [ class "term-highlight" ] [ text "mosquitto-broker    Up 14 days (healthy) 0.0.0.0:1883->1883/tcp\n" ]
                        , span [ class "term-highlight" ] [ text "nodered-flow        Up 14 days (healthy) 0.0.0.0:1880->1880/tcp\n" ]
                        , span [ class "term-highlight" ] [ text "ollama-phi35        Up 5 days (healthy)  0.0.0.0:11434->11434/tcp\n" ]
                        , span [ class "term-dim" ] [ text "# Telemetria en tiempo real: ESP32 -> Mosquitto -> NodeRED -> phi3.5" ]
                        ]

                TabSystemd ->
                    pre [ class "code-output" ]
                        [ span [ class "prompt" ] [ text "bass@orangepi:~$ " ]
                        , span [ class "cmd" ] [ text "systemctl status iot-water-monitor.service\n" ]
                        , span [ class "term-highlight" ] [ text "● iot-water-monitor.service - Smart Water Tank Daemon\n" ]
                        , text "     Loaded: loaded (/etc/systemd/system/iot-water-monitor.service; enabled)\n"
                        , span [ class "term-highlight" ] [ text "     Active: active (running) " ]
                        , text "since Wed 2026-09-30 08:00:00 -04\n"
                        , text "      Tasks: 4 (limit: 4124)\n"
                        , text "     Memory: 24.8M\n"
                        , span [ class "term-dim" ] [ text "   Main PID: 1248 (telegram-bot-router)\n" ]
                        , span [ class "term-dim" ] [ text "     Status: \"Telemetry OK. Tank level: 82% | MQTT connected\"" ]
                        ]

                TabUname ->
                    pre [ class "code-output" ]
                        [ span [ class "prompt" ] [ text "bass@orangepi:~$ " ]
                        , span [ class "cmd" ] [ text "uname -srmo && cat /etc/os-release | grep PRETTY\n" ]
                        , span [ class "term-highlight" ] [ text "Linux 6.6.45-current-sunxi64 aarch64 GNU/Linux\n" ]
                        , text "PRETTY_NAME=\"Armbian Linux 24.8 (Noble)\""
                        ]
            ]
        ]


viewProjects : Model -> Html Msg
viewProjects model =
    section [ id "proyectos", class "section-container" ]
        [ div [ class "section-header" ]
            [ span [ class "section-tag" ] [ text "§ 1.0 — PROYECTOS Y SISTEMAS" ]
            , h2 [ class "section-title" ] [ text "Obras Técnicas Destacadas" ]
            , p [ class "section-desc" ]
                [ text "Librerías de bajo nivel en Linux con tipado formal en Haskell, bindings FFI a libgpiod v2 y arquitectura integral de control distribuido Edge / IoT." ]
            ]
        , div [ class "category-filters" ]
            [ button
                [ classList [ ( "filter-btn", True ), ( "active", model.activeProjectTab == TabAll ) ]
                , onClick (SelectProjectTab TabAll)
                ]
                [ text "Todos los Proyectos (3)" ]
            , button
                [ classList [ ( "filter-btn", True ), ( "active", model.activeProjectTab == TabFuyuGpio ) ]
                , onClick (SelectProjectTab TabFuyuGpio)
                ]
                [ text "fuyu-gpio" ]
            , button
                [ classList [ ( "filter-btn", True ), ( "active", model.activeProjectTab == TabFuyuGpioDirect ) ]
                , onClick (SelectProjectTab TabFuyuGpioDirect)
                ]
                [ text "fuyu-gpio-direct" ]
            , button
                [ classList [ ( "filter-btn", True ), ( "active", model.activeProjectTab == TabWaterTank ) ]
                , onClick (SelectProjectTab TabWaterTank)
                ]
                [ text "Sistema IoT Tanque de Agua" ]
            ]
        , div [ class "projects-grid" ] (filteredProjectCards model.activeProjectTab)
        ]


filteredProjectCards : ProjectTab -> List (Html Msg)
filteredProjectCards tab =
    case tab of
        TabAll ->
            [ cardFuyuGpio
            , cardFuyuGpioDirect
            , cardWaterTankIoT
            ]

        TabFuyuGpio ->
            [ cardFuyuGpio ]

        TabFuyuGpioDirect ->
            [ cardFuyuGpioDirect ]

        TabWaterTank ->
            [ cardWaterTankIoT ]


cardFuyuGpio : Html Msg
cardFuyuGpio =
    div [ class "project-card featured" ]
        [ div [ class "project-card-header" ]
            [ div [ class "project-badges" ]
                [ span [ class "badge" ] [ text "Haskell" ]
                , span [ class "badge" ] [ text "libgpiod v2" ]
                , span [ class "badge" ] [ text "Linux Kernel 6.x" ]
                , span [ class "badge" ] [ text "Hackage" ]
                , span [ class "badge badge-accent" ] [ text "v0.1.1.0" ]
                ]
            , a [ href "https://hackage.haskell.org/package/fuyu-gpio", target "_blank", rel "noopener noreferrer", class "card-ext-link", title "Ver en Hackage" ]
                [ i [ class "fa-solid fa-arrow-up-right-from-square" ] [] ]
            ]
        , h3 [ class "project-title" ] [ text "fuyu-gpio" ]
        , p [ class "project-subtitle" ] [ text "Interfaz de alto nivel, tipado estricto y gestión determinista de recursos para Linux GPIO" ]
        , p [ class "project-summary" ]
            [ text "Biblioteca Haskell de nivel de producción publicada en Hackage. Ofrece una capa segura y funcional para interactuar con los character devices del kernel Linux (subsistema "
            , code [] [ text "gpiochip" ]
            , text " moderno), erradicando las vulnerabilidades y limitaciones de tiempo de ejecución del arcaico "
            , code [] [ text "sysfs" ]
            , text ". Construida sobre bases matemáticas estrictas de Haskell."
            ]
        , div [ class "project-spec-box" ]
            [ h4 [ class "spec-box-title" ] [ text "Principios Arquitectónicos & Especificación:" ]
            , ul [ class "spec-list" ]
                [ li []
                    [ strong [] [ text "Gestión Determinista de Recursos: " ]
                    , text "Garantía estricta de ciclo de vida mediante patrones "
                    , code [] [ text "bracket" ]
                    , text " y funciones controladas ("
                    , code [] [ text "withChip" ]
                    , text ", "
                    , code [] [ text "withLineRequest" ]
                    , text "), asegurando que los descriptores de archivos (FDs) del kernel y las líneas reservadas se liberen automáticamente aún en presencia de excepciones asíncronas."
                    ]
                , li []
                    [ strong [] [ text "Monitoreo Reactivo de Eventos (Edge Events): " ]
                    , text "Subsistema "
                    , code [] [ text "Fuyu.GPIO.EdgeEvent" ]
                    , text " con buffers dedicados para captura de flancos (subida, bajada o ambos) con mínima latencia y soporte asíncrono."
                    ]
                , li []
                    [ strong [] [ text "Snapshots Inmutables de Metadatos: " ]
                    , text "Introspección exhaustiva de hardware mediante "
                    , code [] [ text "ChipInfo" ]
                    , text " y "
                    , code [] [ text "LineInfo" ]
                    , text " (dirección, polaridad activa, resistencias pull-up/down y drive mode) inmunes a condiciones de carrera."
                    ]
                , li []
                    [ strong [] [ text "Suite Demostrativa Completa: " ]
                    , text "Cinco aplicaciones de referencia incluidas en el paquete: "
                    , code [] [ text "01-blink" ]
                    , text " (salidas digitales), "
                    , code [] [ text "02-button" ]
                    , text " (entradas y debouncing), "
                    , code [] [ text "03-monitor" ]
                    , text " (escucha continua de interrupciones), "
                    , code [] [ text "04-led-and-button" ]
                    , text " y "
                    , code [] [ text "05-request-config" ]
                    , text " (reconfiguración en caliente)."
                    ]
                ]
            ]
        , div [ class "project-card-footer" ]
            [ a [ href "https://hackage.haskell.org/package/fuyu-gpio", target "_blank", rel "noopener noreferrer", class "project-link" ]
                [ i [ class "fa-solid fa-box-open" ] [], text " Hackage (fuyu-gpio)" ]
            , a [ href "https://github.com/BassGT/fuyu-gpio", target "_blank", rel "noopener noreferrer", class "project-link" ]
                [ i [ class "fa-brands fa-github" ] [], text " Repositorio GitHub" ]
            ]
        ]


cardFuyuGpioDirect : Html Msg
cardFuyuGpioDirect =
    div [ class "project-card featured" ]
        [ div [ class "project-card-header" ]
            [ div [ class "project-badges" ]
                [ span [ class "badge" ] [ text "Haskell" ]
                , span [ class "badge" ] [ text "C / FFI" ]
                , span [ class "badge" ] [ text "libgpiod v2" ]
                , span [ class "badge" ] [ text "Zero-Copy" ]
                , span [ class "badge badge-accent" ] [ text "v0.2.0.0" ]
                ]
            , a [ href "https://hackage.haskell.org/package/fuyu-gpio-direct", target "_blank", rel "noopener noreferrer", class "card-ext-link", title "Ver en Hackage" ]
                [ i [ class "fa-solid fa-arrow-up-right-from-square" ] [] ]
            ]
        , h3 [ class "project-title" ] [ text "fuyu-gpio-direct" ]
        , p [ class "project-subtitle" ] [ text "Bindings directos (FFI de bajo y medio nivel) para la API C libgpiod v2 del kernel Linux" ]
        , p [ class "project-summary" ]
            [ text "Capa fundacional que conecta el compilador GHC con la biblioteca en C "
            , strong [] [ text "libgpiod v2" ]
            , text ". Diseñada específicamente para eliminar la sobrecarga de abstracciones innecesarias, permitiendo interactuar directamente con estructuras de datos en memoria compartida y llamadas "
            , code [] [ text "ioctl" ]
            , text " sobre dispositivos de caracteres "
            , code [] [ text "/dev/gpiochip*" ]
            , text "."
            ]
        , div [ class "project-spec-box" ]
            [ h4 [ class "spec-box-title" ] [ text "Creación de Bindings FFI & Arquitectura de Bajo Nivel:" ]
            , ul [ class "spec-list" ]
                [ li []
                    [ strong [] [ text "Bindings FFI Precisos: " ]
                    , text "Mapeo uno a uno de la especificación oficial de libgpiod v2 ("
                    , code [] [ text "gpiod_chip" ]
                    , text ", "
                    , code [] [ text "gpiod_line_request" ]
                    , text ", "
                    , code [] [ text "gpiod_line_settings" ]
                    , text ", "
                    , code [] [ text "gpiod_edge_event_buffer" ]
                    , text ") distribuidos entre los módulos "
                    , code [] [ text "Fuyu.GPIO.Direct.Bindings" ]
                    , text " y "
                    , code [] [ text "Fuyu.GPIO.Direct.Types" ]
                    , text "."
                    ]
                , li []
                    [ strong [] [ text "Gestión Segura de Punteros C: " ]
                    , text "Uso riguroso de "
                    , code [] [ text "ForeignPtr" ]
                    , text " con finalizadores automáticos registrados en runtime C, garantizando ausencia absoluta de punteros colgantes (dangling pointers) o fugas de memoria nativa."
                    ]
                , li []
                    [ strong [] [ text "Transmisión Zero-Copy con Storable Vectors: " ]
                    , text "Soporte nativo con "
                    , code [] [ text "Data.Vector.Storable" ]
                    , text " para lectura y escritura masiva de pines en una sola operación atómica de kernel, eliminando duplicación de memoria en SBCs de recursos limitados."
                    ]
                , li []
                    [ strong [] [ text "Compatibilidad ABI & Soporte Multiplataforma: " ]
                    , text "Integración con tipos POSIX mediante el paquete "
                    , code [] [ text "unix" ]
                    , text ", probado y verificado en arquitecturas aarch64 (Orange Pi, Armbian) y x86_64."
                    ]
                ]
            ]
        , div [ class "project-card-footer" ]
            [ a [ href "https://hackage.haskell.org/package/fuyu-gpio-direct", target "_blank", rel "noopener noreferrer", class "project-link" ]
                [ i [ class "fa-solid fa-box-open" ] [], text " Hackage (fuyu-gpio-direct)" ]
            , a [ href "https://github.com/BassGT/fuyu-gpio-direct", target "_blank", rel "noopener noreferrer", class "project-link" ]
                [ i [ class "fa-brands fa-github" ] [], text " Repositorio GitHub" ]
            ]
        ]


cardWaterTankIoT : Html Msg
cardWaterTankIoT =
    div [ class "project-card featured" ]
        [ div [ class "project-card-header" ]
            [ div [ class "project-badges" ]
                [ span [ class "badge" ] [ text "C++ (ESP32)" ]
                , span [ class "badge" ] [ text "Podman (Rootless)" ]
                , span [ class "badge" ] [ text "MQTT Mosquitto" ]
                , span [ class "badge" ] [ text "Ollama phi3.5" ]
                , span [ class "badge" ] [ text "Telegram Bot" ]
                , span [ class "badge" ] [ text "SQLite" ]
                ]
            , button [ class "card-ext-btn", onClick (OpenModal ModalWaterTank), title "Abrir Demostración & Arquitectura" ]
                [ i [ class "fa-solid fa-circle-play" ] [] ]
            ]
        , h3 [ class "project-title" ] [ text "Sistema IoT Tanque de Agua Inteligente" ]
        , p [ class "project-subtitle" ] [ text "Telemetría Edge en tiempo real con ESP32, Orange Pi, Node-RED y Telegram" ]
        , p [ class "project-summary" ]
            [ text "Monitoreo de nivel, control de bombas manual/auto y protección por desborde en "
            , strong [] [ text "ESP32 (C++)" ]
            , text ". Servidor en Orange Pi con contenedores "
            , strong [] [ text "Podman (rootless)" ]
            , text ": broker Mosquitto, Node-RED con base de datos SQLite y modelo "
            , strong [] [ text "phi3.5:latest" ]
            , text " para responder preguntas en lenguaje natural y ejecutar comandos vía bot de Telegram."
            ]
        , div [ class "project-spec-box" ]
            [ h4 [ class "spec-box-title" ] [ text "Componentes Clave del Sistema:" ]
            , ul [ class "spec-list" ]
                [ li [] [ text "Firmware embebido en C++ con filtrado digital de lecturas ultrasónicas y accionamiento seguro de relés." ]
                , li [] [ text "Broker MQTT Mosquitto en Podman (rootless) para intercambio liviano de telemetría de eventos." ]
                , li [] [ text "Máquina de estados finitos, endpoints HTTP y series temporales en Node-RED & SQLite." ]
                , li [] [ text "Inferencia local en el Edge con Ollama (phi3.5:latest) y despacho de comandos autenticados en Telegram." ]
                ]
            ]
        , div [ class "project-card-footer" ]
            [ button [ class "btn-modal-trigger", onClick (OpenModal ModalWaterTank) ]
                [ i [ class "fa-solid fa-circle-play" ] []
                , text " Ver Demostración en Vivo & Arquitectura"
                ]
            ]
        ]



-- MODAL POP-UP (DEMOSTRACIÓN EN VIVO & ARQUITECTURA)


viewModal : Model -> Html Msg
viewModal model =
    case model.activeModal of
        NoModal ->
            text ""

        ModalWaterTank ->
            div [ class "modal-container" ]
                [ div [ class "modal-backdrop", onClick CloseModal ] []
                , div [ class "modal-window", attribute "role" "dialog", attribute "aria-modal" "true" ]
                    [ div [ class "modal-header" ]
                        [ div [ class "modal-header-text" ]
                            [ span [ class "section-tag" ] [ text "DEMOSTRACIÓN EN VIVO & ARQUITECTURA" ]
                            , h2 [ class "modal-title" ] [ text "Tanque IoT: Hardware, Edge AI & Node-RED" ]
                            , p [ class "modal-desc" ]
                                [ text "Sistema integral de telemetría y control automático con ESP32, broker MQTT Mosquitto, API Gateway en Node-RED, base de datos SQLite y modelo phi3.5:latest vía Telegram." ]
                            ]
                        , button [ class "btn-close-modal", onClick CloseModal, title "Cerrar ventana emergente" ]
                            [ i [ class "fa-solid fa-xmark" ] []
                            , span [] [ text " Cerrar" ]
                            ]
                        ]
                    , div [ class "showcase-tabs" ]
                        [ button
                            [ classList [ ( "showcase-tab-btn", True ), ( "active", model.showcaseTab == ShowcaseVideos ) ]
                            , onClick (SelectShowcaseTab ShowcaseVideos)
                            ]
                            [ i [ class "fa-solid fa-film" ] []
                            , text " Videos de Funcionamiento"
                            ]
                        , button
                            [ classList [ ( "showcase-tab-btn", True ), ( "active", model.showcaseTab == ShowcaseFlows ) ]
                            , onClick (SelectShowcaseTab ShowcaseFlows)
                            ]
                            [ i [ class "fa-solid fa-diagram-project" ] []
                            , text " Flujos en Node-RED"
                            ]
                        , button
                            [ classList [ ( "showcase-tab-btn", True ), ( "active", model.showcaseTab == ShowcaseArch ) ]
                            , onClick (SelectShowcaseTab ShowcaseArch)
                            ]
                            [ i [ class "fa-solid fa-server" ] []
                            , text " Arquitectura & Router IA"
                            ]
                        ]
                    , div [ class "modal-scrollable-body" ]
                        [ case model.showcaseTab of
                            ShowcaseVideos ->
                                viewShowcaseVideos

                            ShowcaseFlows ->
                                viewShowcaseFlows

                            ShowcaseArch ->
                                viewShowcaseArch
                        ]
                    , div [ class "modal-footer" ]
                        [ button [ class "btn-modal-close-bottom", onClick CloseModal ]
                            [ i [ class "fa-solid fa-check" ] []
                            , text " Finalizar / Cerrar Demostración"
                            ]
                        ]
                    ]
                ]


viewShowcaseVideos : Html Msg
viewShowcaseVideos =
    div [ class "videos-showcase-grid" ]
        [ div [ class "media-card" ]
            [ div [ class "media-card-header" ]
                [ span [ class "media-tag" ] [ text "HARDWARE FÍSICO" ]
                , h4 [] [ text "Operación de Bombas y Corte por Desborde" ]
                , p [] [ text "ESP32 con botones de control manual, sensor de nivel ultrasónico y protección automática ante excepciones de desborde." ]
                ]
            , div [ class "video-wrapper" ]
                [ video
                    [ controls True
                    , preload "metadata"
                    , src "assets/prueba_tanque_funcionamiento.mp4"
                    ]
                    []
                ]
            ]
        , div [ class "media-card" ]
            [ div [ class "media-card-header" ]
                [ span [ class "media-tag" ] [ text "EDGE AI (PHI-3.5)" ]
                , h4 [] [ text "Consultas Abiertas y Control por Telegram" ]
                , p [] [ text "Interacción en lenguaje natural con el modelo phi3.5:latest corriendo en Ollama sobre la Orange Pi. Diagnóstico del sistema y recomendaciones en tiempo real." ]
                ]
            , div [ class "video-wrapper" ]
                [ video
                    [ controls True
                    , preload "metadata"
                    , src "assets/prueba_tanque_IA.mp4"
                    ]
                    []
                ]
            ]
        ]


viewShowcaseFlows : Html Msg
viewShowcaseFlows =
    div [ class "flows-showcase-grid" ]
        [ div [ class "flow-card" ]
            [ div [ class "media-card-header" ]
                [ span [ class "media-tag" ] [ text "MQTT & ESTADO DEL TANQUE" ]
                , h4 [] [ text "Ingesta MQTT, Máquina de Estados y Excepciones" ]
                , p [] [ text "Conexión bidireccional con ESP32 vía Mosquitto, control de modos (AUTO / MANUAL), cálculo de volumen/caudal y persistencia de eventos en SQLite." ]
                ]
            , a [ href "assets/NODE-RED_mqtt.png", target "_blank", rel "noopener noreferrer", class "img-zoom-wrapper" ]
                [ img [ src "assets/NODE-RED_mqtt.png", class "flow-img", alt "Flujo Node-RED MQTT y control del tanque" ] []
                , div [ class "zoom-hint" ] [ i [ class "fa-solid fa-magnifying-glass-plus" ] [], text " Clic para ver en resolución completa (1920x1048)" ]
                ]
            ]
        , div [ class "flow-card" ]
            [ div [ class "media-card-header" ]
                [ span [ class "media-tag" ] [ text "ROUTER TELEGRAM + OLLAMA" ]
                , h4 [] [ text "Despacho de Comandos y Pipeline con phi3.5" ]
                , p [] [ text "Recepción de mensajes de Telegram, verificación de autorización de usuario (chatId), teclado persistente interactivo y ruteo a Ollama local." ]
                ]
            , a [ href "assets/NODE-RED_telegramIA.png", target "_blank", rel "noopener noreferrer", class "img-zoom-wrapper" ]
                [ img [ src "assets/NODE-RED_telegramIA.png", class "flow-img", alt "Flujo Node-RED Telegram e integración IA" ] []
                , div [ class "zoom-hint" ] [ i [ class "fa-solid fa-magnifying-glass-plus" ] [], text " Clic para ver en resolución completa (1920x1048)" ]
                ]
            ]
        ]


viewShowcaseArch : Html Msg
viewShowcaseArch =
    div [ class "arch-showcase-container" ]
        [ div [ class "arch-specs-grid" ]
            [ div [ class "arch-spec-box" ]
                [ h4 [] [ i [ class "fa-solid fa-microchip" ] [], text " Capa Embebida (C++)" ]
                , ul []
                    [ li [] [ text "Microcontrolador ESP32 con conexión WiFi 802.11 b/g/n" ]
                    , li [] [ text "Lectura de nivel y caudal con filtrado de ruido digital" ]
                    , li [] [ text "Control seguro de relés de bombas A y B con enclave de protección" ]
                    , li [] [ text "Publicación / suscripción MQTT en formato JSON liviano" ]
                    ]
                ]
            , div [ class "arch-spec-box" ]
                [ h4 [] [ i [ class "fa-brands fa-linux" ] [], text " Pasarela Edge (Orange Pi)" ]
                , ul []
                    [ li [] [ text "Contenedores Podman (daemonless / rootless / systemd user units)" ]
                    , li [] [ text "Broker Eclipse Mosquitto en host.containers.internal" ]
                    , li [] [ text "Inferencia local con Ollama (modelo phi3.5:latest aarch64)" ]
                    , li [] [ text "Base de datos SQLite (/data/tanque.db) con series temporales" ]
                    ]
                ]
            , div [ class "arch-spec-box" ]
                [ h4 [] [ i [ class "fa-solid fa-network-wired" ] [], text " APIs & Conectividad" ]
                , ul []
                    [ li [] [ text "14 Endpoints REST HTTP para monitoreo e integración externa" ]
                    , li [] [ text "WebSocket en /ws/tanque para telemetría en tiempo real" ]
                    , li [] [ text "Bot de Telegram interactivo con teclado persistente" ]
                    , li [] [ text "Router de comandos en JavaScript (a.js) con filtro de seguridad" ]
                    ]
                ]
            ]
        , div [ class "arch-code-snippet" ]
            [ div [ class "snippet-header" ]
                [ span [] [ text "Extracto de la lógica del Router en Node-RED (a.js)" ]
                , span [ class "snippet-lang" ] [ text "JavaScript (ES6)" ]
                ]
            , pre [ class "code-output" ]
                [ span [ class "term-dim" ] [ text "// Ruteo de comandos y consulta inteligente con phi3.5\n" ]
                , text "const ADMIN_AUTORIZADO = 330659223; // Solo Bass (@BassGT12)\n"
                , text "if (rawChatId && rawChatId !== ADMIN_AUTORIZADO) {\n"
                , text "    node.warn(\"⛔ Intento de acceso bloqueado: \" + rawChatId);\n"
                , text "    return [ msgDenegado, null, null, null, null, null, null ];\n"
                , text "}\n"
                , text "\n"
                , span [ class "term-highlight" ] [ text "// Si el texto no es un comando predefinido, se despacha a Ollama phi3.5\n" ]
                , text "let promptIA = `Eres el asistente inteligente del Tanque IoT. Estado actual: ${st.nivel}% (${st.modo}). Pregunta: ${text}`;\n"
                , text "return [ null, null, null, null, { payload: { model: 'phi3.5', prompt: promptIA } } ];"
                ]
            ]
        ]



-- SKILLS SECTION


viewSkills : Html Msg
viewSkills =
    section [ id "habilidades", class "section-container" ]
        [ div [ class "section-header" ]
            [ span [ class "section-tag" ] [ text "§ 2.0 — STACK TÉCNICO" ]
            , h2 [ class "section-title" ] [ text "Habilidades & Herramientas de Sistemas" ]
            , p [ class "section-desc" ]
                [ text "Tecnologías, lenguajes y metodologías utilizadas en ingeniería de software de bajo nivel, kernel y sistemas embebidos." ]
            ]
        , div [ class "skills-grid" ]
            [ skillCategory "Lenguajes & Paradigmas" "fa-solid fa-code"
                [ skillItem "Haskell" "devicon-haskell-plain" "Funcional puro, FFI, Concurrencia, Tipos"
                , skillItem "C++" "devicon-cplusplus-plain" "ESP32, Pico, STL, Algoritmos eficientes"
                , skillItem "C" "devicon-c-plain" "Interoperabilidad kernel y llamadas POSIX"
                , skillItem "Elm" "devicon-elm-plain" "Frontend web funcional puro sin runtime exceptions"
                , skillItem "Bash" "devicon-bash-plain" "Automatización avanzada y scripting en GNU/Linux"
                ]
            , skillCategory "IoT & Microcontroladores" "fa-solid fa-microchip"
                [ skillItem "Orange Pi & RPi" "devicon-raspberrypi-line" "SBCs aarch64, Gateways Edge"
                , skillItem "ESP32 & RP2040" "fa-solid fa-microchip" "Firmware C++, Sensores, Relés, PWM"
                , skillItem "Interfaces Kernel" "fa-solid fa-memory" "libgpiod v2, spidev, i2c-tools, character devs"
                , skillItem "MQTT Mosquitto" "fa-solid fa-network-wired" "Broker en Podman, mensajería QoS"
                , skillItem "Edge AI (Ollama)" "fa-solid fa-robot" "phi3.5:latest corriendo localmente"
                ]
            , skillCategory "Sistemas Operativos & DevOps" "fa-solid fa-server"
                [ skillItem "GNU/Linux" "devicon-linux-plain" "Administración avanzada, subsistemas kernel"
                , skillItem "systemd" "fa-solid fa-gears" "systemctl, journalctl, loginctl, timers"
                , skillItem "OpenSSH Suite" "fa-solid fa-terminal" "SSH, SCP, montaje remoto SSHFS, llaves ed25519"
                , skillItem "Podman & Docker" "devicon-podman-plain" "Contenedores rootless seguros en SBCs"
                , skillItem "Git & Vim" "devicon-vim-plain" "Flujo de trabajo ágil y versionado en terminal"
                ]
            , skillCategory "Seguridad & Redes" "fa-solid fa-shield-halved"
                [ skillItem "Cisco IT Essentials" "fa-solid fa-certificate" "Hardware, SO y redes fundamentales"
                , skillItem "Cisco Cybersecurity" "fa-solid fa-user-shield" "Defensa en profundidad y mitigación"
                , skillItem "Hardening Linux" "fa-solid fa-bug" "Auditoría de servicios y permisos de sistema"
                , skillItem "Protocolos de Red" "fa-solid fa-diagram-project" "TCP/IP, UDP, WebSockets, REST, MQTT"
                ]
            ]
        ]


skillCategory : String -> String -> List (Html Msg) -> Html Msg
skillCategory catTitle iconClass items =
    div [ class "skill-card" ]
        [ div [ class "skill-card-header" ]
            [ i [ class iconClass ] []
            , h3 [] [ text catTitle ]
            ]
        , div [ class "skill-items-list" ] items
        ]


skillItem : String -> String -> String -> Html Msg
skillItem name icon info =
    div [ class "skill-item" ]
        [ i [ class ("skill-icon " ++ icon) ] []
        , div [ class "skill-text" ]
            [ span [ class "skill-name" ] [ text name ]
            , span [ class "skill-desc" ] [ text info ]
            ]
        ]



-- CERTIFICATES SECTION


viewCertificates : Html Msg
viewCertificates =
    section [ id "certificaciones", class "section-container" ]
        [ div [ class "section-header" ]
            [ span [ class "section-tag" ] [ text "§ 3.0 — RECONOCIMIENTO Y CERTIFICACIONES" ]
            , h2 [ class "section-title" ] [ text "Credenciales Oficiales & Honores" ]
            , p [ class "section-desc" ]
                [ text "Verificación pública directa de credenciales oficiales, especializaciones técnicas y distinciones académicas." ]
            ]
        , div [ class "certs-grid" ]
            [ certCard "Cisco IT Essentials" "Cisco Networking Academy (Credly)" "https://www.credly.com/badges/66f583fb-b653-4cc3-86fa-70591cda2a8a" "fa-solid fa-certificate" "Insignia Oficial"
            , certCard "Introduction to Cybersecurity" "Cisco Networking Academy (Credly)" "https://www.credly.com/badges/22284be5-3fc5-40ed-90cf-297192a36869" "fa-solid fa-shield-cat" "Insignia Oficial"
            , certCard "Ruta Linux para Programadores" "EDteam (Especialidad Completa)" "https://ed.team/u/sebastianmedrano/ruta/linux/linux" "fa-brands fa-linux" "Ver Ruta"
            , certCard "Ruta Ciberseguridad y Hacking Ético" "EDteam (Especialidad Completa)" "https://ed.team/u/sebastianmedrano/ruta/ciberseguridad-hacking/ciberseguridad-hacking" "fa-solid fa-user-secret" "Ver Ruta"
            , certCard "The Complete Haskell Course" "Udemy (From Zero to Expert)" "http://ude.my/UC-174e10ef-9df7-41f0-9501-4b696e6e57db" "fa-solid fa-laptop-code" "Certificado"
            , certCard "Computer Networks Fundamentals" "Udemy" "http://ude.my/UC-b952d86f-90c9-49c5-a01f-a1ce322b9a13" "fa-solid fa-network-wired" "Certificado"
            , certCard "Fundamentos del Cálculo Lambda" "Udemy" "http://ude.my/UC-a8347af1-17ff-4171-b50a-200d0e87ef2c" "fa-solid fa-square-root-variable" "Certificado"
            , certCard "Ecuaciones Diferenciales Universitarias" "Udemy" "http://ude.my/UC-2e2e9b87-b26c-46aa-83d7-cf6c7623db7f" "fa-solid fa-chart-line" "Certificado"
            , certCard "Excelencia Académica (2024 & 2025)" "Universidad San Francisco de Asís (USFA)" "#" "fa-solid fa-award" "Reconocimiento de Honor"
            ]
        ]


certCard : String -> String -> String -> String -> String -> Html Msg
certCard certTitle issuer url iconClass actionLabel =
    a [ href url, target "_blank", rel "noopener noreferrer", class "cert-card" ]
        [ div [ class "cert-icon" ] [ i [ class iconClass ] [] ]
        , div [ class "cert-info" ]
            [ h4 [ class "cert-title" ] [ text certTitle ]
            , p [ class "cert-issuer" ] [ text issuer ]
            ]
        , span [ class "cert-badge" ]
            [ text actionLabel
            , i [ class "fa-solid fa-arrow-up-right-from-square" ] []
            ]
        ]



-- FOOTER


viewFooter : Html Msg
viewFooter =
    footer [ class "footer" ]
        [ div [ class "footer-content" ]
            [ p []
                [ text "© 2026 "
                , strong [] [ text "Sebastian Jorge Medrano Chacolla" ]
                , text " • Desarrollado con "
                , a [ href "https://elm-lang.org", target "_blank", rel "noopener noreferrer" ] [ text "Elm 0.19.1" ]
                , text " (Arquitectura funcional pura sin excepciones en tiempo de ejecución)"
                ]
            , div [ class "footer-links" ]
                [ a [ href "https://github.com/BassGT", target "_blank", rel "noopener noreferrer" ] [ text "GitHub (BassGT)" ]
                , a [ href "https://github.com/MsebasGit", target "_blank", rel "noopener noreferrer" ] [ text "GitHub (MsebasGit)" ]
                , a [ href "https://hackage.haskell.org/package/fuyu-gpio", target "_blank", rel "noopener noreferrer" ] [ text "fuyu-gpio (Hackage)" ]
                , a [ href "https://hackage.haskell.org/package/fuyu-gpio-direct", target "_blank", rel "noopener noreferrer" ] [ text "fuyu-gpio-direct (Hackage)" ]
                , a [ href "mailto:sebastian11medrano@gmail.com" ] [ text "Email" ]
                ]
            ]
        ]
