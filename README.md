# SwiftUI Lab

Proyecto de Xcode (iOS 26+) que sirve como **catálogo para experimentar con
distintos tipos de UI en SwiftUI**. Cada pantalla es una demo independiente
accesible desde el menú principal.

## Showcases incluidos

| Showcase | Qué demuestra |
|----------|---------------|
| **Liquid Glass** | `glassEffect` / `GlassEffectContainer` de iOS 26 con fallback a materiales |
| **Layouts & Grids** | `LazyVGrid`, bento grid, carrusel horizontal, grid adaptativo |
| **Formularios** | `Form`, validación con un servicio `@Observable` (`@MainActor`) |
| **Animaciones** | springs, `matchedGeometryEffect`, transiciones, `phaseAnimator` |
| **Listas Interactivas** | secciones, swipe actions, `onMove`, `onDelete`, `EditButton` |
| **Gráficos** | Swift Charts: barras, línea + área, sectores |

## Buenas prácticas aplicadas

- Navegación con `NavigationStack` + `NavigationPath` (navegación programática).
- Estado con `@Observable` + `@State` (en lugar de `ObservableObject`/`@StateObject`).
- Lógica de negocio fuera de las vistas, en servicios testeables.
- Adopción de Liquid Glass con `#available(iOS 26, *)` y fallback.
- Swift 6, agrupación de archivos por responsabilidad.

## Estructura

```
SwiftUILab/
├── project.yml              # Especificación de XcodeGen
├── Sources/
│   ├── App/                 # Punto de entrada + menú principal
│   ├── Components/          # Componentes reutilizables (glass, fondo)
│   └── Showcases/           # Una pantalla por tipo de UI
└── Resources/
    └── Assets.xcassets      # AccentColor, AppIcon
```

## Regenerar / abrir

El proyecto `.xcodeproj` se genera con [XcodeGen](https://github.com/yonaskolb/XcodeGen):

```bash
xcodegen generate      # regenera SwiftUILab.xcodeproj desde project.yml
open SwiftUILab.xcodeproj
```

> Añade nuevos `.swift` dentro de `Sources/` y vuelve a ejecutar `xcodegen generate`.

## Créditos / Inspiración

Este proyecto es un **challenge de práctica**: una recreación en SwiftUI inspirada
en el concepto _"Self-care Mobile App Design Concept"_ publicado en Dribbble.

- Inspiración: <https://dribbble.com/shots/23278774-Self-care-Mobile-App-Design-Concept>
- Diseño original por **RonasIT**: <https://dribbble.com/ronasit>

Todo el crédito del diseño visual es de sus autores originales.
