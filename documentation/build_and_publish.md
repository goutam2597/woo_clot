# Build & Publish

Prerequisites
- Flutter stable 3.9.x+
- Android SDK / Xcode set up

Install dependencies
- flutter pub get

Android
- Debug run: flutter run -d emulator-5554
- Release APK (with obfuscation + split debug info):
  - flutter build apk --release --obfuscate --split-debug-info=build/symbols --dart-define=USE_DUMMY_DATA=false
  - Output: `build/app/outputs/flutter-apk/app-release.apk`
- App Bundle (Play Store):
  - flutter build appbundle --release --obfuscate --split-debug-info=build/symbols --dart-define=USE_DUMMY_DATA=false
- Signing:
  - Create/upload a keystore and configure `android/key.properties`. Reference in `android/app/build.gradle`.

iOS
- Open `ios/Runner.xcworkspace` in Xcode.
- Select a team, set bundle identifier, and run on device/simulator.
- Release archive:
  - flutter build ipa --release --obfuscate --split-debug-info=build/symbols --dart-define=USE_DUMMY_DATA=false
  - Or archive from Xcode.

Quality Checklist (CodeCanyon)
- Remove the `build/` directory and any derived artifacts from your final ZIP.
- Include this `documentation/` folder and `CHANGELOG.md` in the root.
- Ensure icons, fonts, and images are licensed for redistribution.
- Verify splash/logo are replaced with your branding.
- Confirm release builds with demo data disabled unless intended for preview.
- Provide test credentials if your build requires authentication (not applicable here).

Troubleshooting
- Run `flutter doctor -v` and ensure no red issues.
- Clean build: `flutter clean && flutter pub get`.
- Android Gradle errors: make sure Java 17+ is installed and selected.

