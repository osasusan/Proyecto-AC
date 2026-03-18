# 📚 Manga AC — iOS App
 
> Aplicación iOS para descubrir y explorar manga usando la API de MyAnimeList.
 
---
 
## 📱 Capturas de pantalla
 
> 🖼️ *(Añade aquí tus capturas del simulador o dispositivo real)*
 
---
 
## 📖 Descripción
 
**Manga AC** es una aplicación nativa para iOS que permite a los usuarios explorar el catálogo de manga de [MyAnimeList](https://myanimelist.net/). La app muestra información detallada de cada título: sinopsis, autor, géneros y puntuación, todo desde una interfaz limpia y fluida construida con SwiftUI.
 
---
 
## ✨ Funcionalidades
 
- 🔍 **Búsqueda de manga** — Encuentra cualquier título en tiempo real a través de la API de MyAnimeList
- 📄 **Vista de detalle** — Consulta sinopsis, autor, géneros, puntuación y portada de cada manga
- ❤️ **Lista de favoritos** — Guarda tus mangas favoritos para acceder a ellos rápidamente
- 🌐 **Consumo de API REST** — Integración con la API pública de MyAnimeList (Jikan API)
 
---
 
## 🏗️ Arquitectura
 
El proyecto está desarrollado siguiendo el patrón **MVVM (Model-View-ViewModel)**, lo que permite:
 
- Separación clara de responsabilidades
- Código más testeable y mantenible
- Binding reactivo entre la vista y los datos mediante `@StateObject` y `@ObservedObject`
 
```
Proyecto-AC/
├── Models/         # Estructuras de datos (Manga, Author...)
├── ViewModels/     # Lógica de negocio y llamadas a la API
├── Views/          # Vistas SwiftUI
└── Services/       # Capa de red y gestión de peticiones
```
 
---
 
## 🛠️ Tecnologías utilizadas
 
| Tecnología | Uso |
|---|---|
| **Swift 5.10** | Lenguaje principal |
| **SwiftUI** | Framework de UI declarativa |
| **Async/Await** | Llamadas asíncronas a la API |
| **Jikan API (MyAnimeList)** | Fuente de datos de manga |
| **Xcode 15.3** | Entorno de desarrollo |
 
---
 
## ⚙️ Requisitos
 
- iOS **17.4** o superior
- Xcode **15.3** o superior
- Conexión a internet (para carga de datos y portadas)
 
---
 
## 🚀 Instalación
 
1. Clona el repositorio:
```bash
git clone https://github.com/osasusan/Proyecto-AC.git
```
2. Abre `Proyecto AC.xcodeproj` con Xcode
3. Selecciona un simulador o dispositivo con iOS 17.4+
4. Pulsa **⌘ + R** para compilar y ejecutar
 
> No se necesita ninguna API key para ejecutar el proyecto.
 
---
 
## 👤 Autor
 
**Osasu Sánchez Burrel**
- GitHub: [@osasusan](https://github.com/osasusan)
- LinkedIn: [osasu sánchez burrel](https://www.linkedin.com/in/osasu-sanchez-burrel)
- Email: osasusan@gmail.com
 
---
 
## 📄 Licencia
 
Este proyecto ha sido desarrollado con fines educativos y de aprendizaje.
