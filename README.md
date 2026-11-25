# Yordan Modz — iPhone

App de ejemplo en SwiftUI con un panel oscuro/neón para gestionar un perfil y preferencias personales en el iPhone.

## Funciones

- Editar el nombre del perfil.
- Ajustar y restablecer los valores personales de sensibilidad de cámara y mira.
- Activar preferencias de accesibilidad y apariencia.
- Guardar automáticamente la configuración mediante `@AppStorage` en el dispositivo.
- Consultar una nota de privacidad y uso seguro.

La aplicación no se conecta a juegos, no modifica otras apps y no incluye cheats ni automatización de juego.

## Abrir en Xcode

1. En Xcode, crea un proyecto **iOS > App** llamado `YordanModz`, con interfaz **SwiftUI** y lenguaje **Swift**.
2. Usa iOS 16 o posterior como versión mínima.
3. Reemplaza el `ContentView.swift` generado por `YordanModz/ContentView.swift`.
4. Añade `YordanModz/YordanModzApp.swift` al target de la aplicación (o sustituye el archivo `App` generado por su contenido; asegúrate de que solo haya un `@main`).
5. Selecciona un simulador de iPhone y pulsa **Run**.

Los valores se guardan localmente y permanecen después de cerrar y volver a abrir la app.
