# SwiftUI Lab

Un solo repo, **muchos proyectos**. Cada proyecto es la recreación en SwiftUI de un
diseño de Dribbble. Todo vive dentro de una única app-galería: abres la app, ves el
índice de recreaciones y entras a cualquiera con un toque.

> iOS 26 · Swift 6 · SwiftUI · generado con [XcodeGen](https://github.com/yonaskolb/XcodeGen)

---

## 📒 Índice de proyectos

| # | Proyecto | Diseño | Estado | Añadido |
|---|----------|--------|--------|---------|
| 1 | [Craftyo](Sources/Projects/Craftyo) | [Craftyo — Flight Booking Mobile App](https://dribbble.com/shots/26848568-Craftyo-Flight-booking-mobile-app) (Dribbble) — home con buscador de vuelos, cupones y últimos viajes | ✅ Listo | Jun 2026 |
| 2 | [Payvia](Sources/Projects/Payvia) | Finance Mobile App (Behance) — splash + onboarding, tipografía Bricolage Grotesque | ✅ Listo | Jun 2026 |
| 3 | [Mood Check-In](Sources/Projects/MoodCheckIn) | Onboarding de bienestar (self-care) | ✅ Listo | Jun 2026 |

> Cada fila apunta a la carpeta del proyecto dentro de `Sources/Projects/`.

### 🧩 Showcases generales

Demos reutilizables de SwiftUI, **compartidos entre todos los proyectos** (no se
duplican por proyecto). Accesibles desde la galería:

`Animations` · `Lists` · `Charts` · `Forms` · `Layouts` · `Liquid Glass`

Viven en [`Sources/Showcases/`](Sources/Showcases).

---

## 🗂 Estructura del repo

```
SwiftUILab/
├── project.yml              # Spec de XcodeGen (el .xcodeproj se regenera)
├── README.md                # Este índice
├── Resources/               # Assets + fuentes (Poppins, Bricolage Grotesque) compartidos
└── Sources/
    ├── App/
    │   ├── SwiftUILabApp.swift   # @main → GalleryView
    │   ├── GalleryView.swift     # Pantalla índice (galería de proyectos)
    │   ├── LabCatalog.swift      # Registro: añade un proyecto aquí
    │   └── AppFont.swift         # Tipografía Poppins
    ├── Projects/            # 👈 Una carpeta por recreación de Dribbble
    │   └── MoodCheckIn/
    ├── Showcases/           # Demos generales reutilizables
    └── Components/          # Componentes compartidos
```

---

## ▶️ Cómo correr

```bash
# 1. Genera el proyecto Xcode (no está versionado; se regenera desde project.yml)
xcodegen generate

# 2. Ábrelo
open SwiftUILab.xcodeproj
```

O compila desde la terminal:

```bash
xcodebuild -project SwiftUILab.xcodeproj -scheme SwiftUILab \
  -destination 'generic/platform=iOS Simulator' build
```

---

## ➕ Cómo añadir un proyecto nuevo

1. Crea la carpeta `Sources/Projects/<NombreProyecto>/` con tus vistas SwiftUI.
2. Añade **una** entrada a `LabCatalog.projects` en
   [`Sources/App/LabCatalog.swift`](Sources/App/LabCatalog.swift):

   ```swift
   LabProject(
       id: "nombre-proyecto",
       title: "Título",
       designer: "Crédito del shot de Dribbble",
       summary: "Descripción corta.",
       accent: .blue,
       symbol: "sparkles",          // SF Symbol
       added: "Jul 2026",
       destination: { AnyView(MiVistaPrincipal()) }
   )
   ```

3. Corre `xcodegen generate` (XcodeGen toma los archivos automáticamente).
4. Agrega la fila correspondiente a la tabla del índice de arriba. ✨

La galería y la navegación se actualizan solas a partir del catálogo — no hace falta
tocar `GalleryView`.
