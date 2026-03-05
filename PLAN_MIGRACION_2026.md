# Plan de Migracion Flutter 2026

Objetivo: actualizar la app existente para publicacion en App Store y Play Store, sin soporte web, minimizando riesgo de regresiones.

## Checklist general

- [ ] Fase: 0 - Preparacion
  Tarea: Congelar base de trabajo
  Descripcion: Crear rama de migracion, respaldar llaves/certificados, documentar version actual de Flutter/Dart y estado inicial de `flutter analyze` y `flutter test`. Estado actual: rama `main` creada y publicada, remoto actualizado, tag `phase0-baseline` creado; pendiente respaldo externo de llaves/certificados.

- [x] Fase: 0 - Preparacion
  Tarea: Definir criterio de exito
  Descripcion: Acordar metricas minimas para liberar (build release iOS/Android, analisis sin errores, pruebas de humo funcionales).

## Estado de congelamiento

- [x] Fase: 0 - Preparacion
  Tarea: Publicar base en nuevo repositorio
  Descripcion: Se creo `main` desde `v1.0`, se actualizo `origin` a `https://github.com/nhoamx/abasmerceria_app.git` y se publico `origin/main`.

- [x] Fase: 0 - Preparacion
  Tarea: Retirar rama anterior
  Descripcion: Se elimino `v1.0` local y se verifico que en el remoto nuevo no existe `v1.0`.

- [x] Fase: 0 - Preparacion
  Tarea: Congelar baseline
  Descripcion: Se creo y publico el tag `phase0-baseline` sobre el commit `10ae89d`.

- [x] Fase: 1 - Desbloqueo de compilacion
  Tarea: Corregir API removida en botones
  Descripcion: Reemplazar `primary:` en `ElevatedButton.styleFrom(...)` por API vigente (`backgroundColor`) en pantallas afectadas. Aplicado en `lib/views/product_check.dart` y `lib/views/support.dart`.

- [x] Fase: 1 - Desbloqueo de compilacion
  Tarea: Resolver registrant web obsoleto
  Descripcion: Eliminar o mover fuera de `lib/` el archivo `generated_plugin_registrant.dart` que rompe analisis por imports inexistentes. Eliminado por no requerir soporte web.

- [ ] Fase: 1 - Desbloqueo de compilacion
  Tarea: Normalizar imports y warnings criticos
  Descripcion: Limpiar imports no usados y warnings que bloqueen CI, manteniendo cambios acotados para recuperar compilacion estable.

- [ ] Fase: 1 - Desbloqueo de compilacion
  Tarea: Validar estado base
  Descripcion: Ejecutar `flutter clean`, `flutter pub get`, `flutter analyze` y `flutter test`; registrar resultados en el documento de migracion.

- [ ] Fase: 2 - Actualizacion Android (Play Store)
  Tarea: Migrar toolchain Android
  Descripcion: Actualizar Gradle wrapper, Android Gradle Plugin, Kotlin y configuracion de plugins Flutter a formato moderno compatible con 2026.

- [ ] Fase: 2 - Actualizacion Android (Play Store)
  Tarea: Subir niveles de SDK
  Descripcion: Ajustar `compileSdkVersion`, `targetSdkVersion` y revisar `minSdkVersion` segun requisitos actuales de Play y de plugins.

- [ ] Fase: 2 - Actualizacion Android (Play Store)
  Tarea: Modernizar Java/Kotlin
  Descripcion: Migrar de Java/Kotlin 1.8 a version recomendada por stack actual (incluyendo ajustes de `jvmTarget` y compatibilidad de plugins).

- [ ] Fase: 2 - Actualizacion Android (Play Store)
  Tarea: Verificar manifiesto y recursos
  Descripcion: Revisar `AndroidManifest.xml`, permisos, nombre de icono (`launcger_icon`) y configuracion release para evitar fallos de build/publicacion.

- [ ] Fase: 3 - Actualizacion iOS (App Store)
  Tarea: Elevar deployment target
  Descripcion: Subir `IPHONEOS_DEPLOYMENT_TARGET` y `MinimumOSVersion` a valor vigente para Xcode/App Store moderno.

- [ ] Fase: 3 - Actualizacion iOS (App Store)
  Tarea: Regenerar configuracion CocoaPods
  Descripcion: Asegurar presencia y salud de `Podfile`, ejecutar `pod install` y alinear integracion de plugins en entorno iOS actual.

- [ ] Fase: 3 - Actualizacion iOS (App Store)
  Tarea: Actualizar proyecto Xcode legado
  Descripcion: Ajustar proyecto con compatibilidad antigua (`Xcode 9.3`) a configuracion moderna sin romper firma ni capacidades.

- [ ] Fase: 3 - Actualizacion iOS (App Store)
  Tarea: Verificar firma y perfiles
  Descripcion: Validar `Bundle Identifier`, certificados, provisioning profiles y modo release para distribucion a TestFlight/App Store.

- [ ] Fase: 4 - Dependencias y calidad
  Tarea: Alinear restricciones de SDK
  Descripcion: Corregir inconsistencia entre `pubspec.yaml` (Dart 2) y `pubspec.lock` (Dart 3), dejando constraints coherentes con Flutter actual.

- [ ] Fase: 4 - Dependencias y calidad
  Tarea: Actualizar lints y deprecaciones
  Descripcion: Subir `flutter_lints` y reemplazar APIs deprecadas (`ButtonBar`, `withOpacity`, etc.) para reducir deuda tecnica futura.

- [ ] Fase: 4 - Dependencias y calidad
  Tarea: Revisar plugins criticos
  Descripcion: Confirmar mantenimiento y compatibilidad de plugins clave (scanner, html, navegacion) con Android/iOS actuales.

- [ ] Fase: 5 - Pruebas funcionales
  Tarea: Sustituir prueba de plantilla
  Descripcion: Reemplazar `widget_test.dart` basico por pruebas de humo reales sobre flujos de negocio (busqueda, escaneo, carrito, soporte).

- [ ] Fase: 5 - Pruebas funcionales
  Tarea: Ejecutar matriz de pruebas
  Descripcion: Validar en emulador/dispositivo iOS y Android: arranque, red, escaneo, carrito, envio de sugerencias, manejo de errores.

- [ ] Fase: 6 - Release
  Tarea: Generar builds firmados
  Descripcion: Construir `appbundle/apk` y `ipa` en modo release, verificar tamano, permisos y arranque en frio.

- [ ] Fase: 6 - Release
  Tarea: Publicacion escalonada
  Descripcion: Subir primero a pruebas internas/TestFlight, monitorear errores y luego liberar a produccion de forma gradual.

- [ ] Fase: 6 - Release
  Tarea: Checklist post-lanzamiento
  Descripcion: Monitorear crash reports, errores de red, feedback de usuarios y definir backlog de mejoras para el siguiente sprint.

## Entregables por fase

- [ ] Fase: 1
  Tarea: Evidencia tecnica
  Descripcion: Capturas/salida de consola con `flutter analyze` y `flutter test` sin errores bloqueantes.

- [ ] Fase: 2 y 3
  Tarea: Evidencia de plataforma
  Descripcion: Build release Android e iOS exitoso en entorno local/CI.

- [ ] Fase: 4 y 5
  Tarea: Evidencia de calidad
  Descripcion: Reporte de pruebas de humo y lista de deprecaciones resueltas.

- [ ] Fase: 6
  Tarea: Evidencia de publicacion
  Descripcion: Version subida a canales de prueba y aprobacion de checklist de salida.
