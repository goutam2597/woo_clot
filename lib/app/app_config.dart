/// Centralized, compile-time configuration for white‑label releases.
/// Override via --dart-define on build, e.g.:
/// flutter run --dart-define=USE_DUMMY_DATA=false
/// flutter build apk --release --dart-define=USE_DUMMY_DATA=false
class AppConfig {
  /// Seed dummy/local data providers (for previews and screenshots).
  static const bool useDummyData = bool.fromEnvironment(
    'USE_DUMMY_DATA',
    defaultValue: true,
  );

  /// Enable verbose logs in-app (no-op unless used explicitly).
  static const bool enableLogs = bool.fromEnvironment(
    'ENABLE_LOGS',
    defaultValue: false,
  );

  /// Controls visual polish that can be toned down for ultra‑light builds.
  static const bool enableAnimations = bool.fromEnvironment(
    'ENABLE_ANIMATIONS',
    defaultValue: true,
  );
}
