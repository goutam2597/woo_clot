# Configuration

AppConfig centralizes build-time flags using Dart defines. You don’t need to modify source code; pass flags to `flutter run` or `flutter build`.

File: lib/app/app_config.dart

Flags
- USE_DUMMY_DATA (bool, default: true)
  - Seeds in-memory demo content for Cart, Wishlist, Notifications, Orders, Coupons.
  - Set to `false` for production.
- ENABLE_LOGS (bool, default: false)
  - Reserved for verbose logs when used in code. Currently a no-op.
- ENABLE_ANIMATIONS (bool, default: true)
  - Reserved to globally reduce animations for ultra‑light builds.

Examples
- Disable demo data in release APK:
  - flutter build apk --release --dart-define=USE_DUMMY_DATA=false
- Disable demo data when running locally:
  - flutter run --dart-define=USE_DUMMY_DATA=false

Notes
- Demo data is purely local and suitable for previews. Integrating with a live backend or WooCommerce REST API will replace or supplement these providers.
