# Branding (Name, Icon, Splash)

App Name
- Edit `pubspec.yaml` `name:` for the Dart package name (lowercase, underscores).
- Edit platform display names:
  - Android: `android/app/src/main/AndroidManifest.xml` (`android:label`) and `app_name` in `android/app/src/main/res/values/strings.xml`.
  - iOS: `ios/Runner/Info.plist` (`CFBundleName` / `CFBundleDisplayName`).

Package ID (Bundle Identifier)
- Android: update `applicationId` in `android/app/build.gradle` (defaultConfig) and the Kotlin/Java package if necessary.
- iOS: update `PRODUCT_BUNDLE_IDENTIFIER` in Xcode (Runner target > Signing & Capabilities).

App Icon
- Replace platform icons using `flutter_launcher_icons` (recommended) or assets manually:
  - Add dev dependency and run `flutter pub run flutter_launcher_icons:main`.
  - Or manually replace `android/app/src/main/res/mipmap-*` and `ios/Runner/Assets.xcassets/AppIcon.appiconset`.

Splash Screen
- Android 12+ uses the system splash; update logo/background in `android/app/src/main/res/drawable` and `mipmap-*` according to Flutter’s splash guidance.
- iOS: update `LaunchScreen.storyboard` in `ios/Runner/Base.lproj`.
- In-app animated splash is implemented in `lib/features/auth/ui/screens/splash_screen.dart` (fade + scale). Replace `AssetsPath.logoSvg` if needed.

Fonts
- Current font: CircularStd (bundled). Ensure you have the proper license to use and redistribute it. Alternatively, replace with a Google Font.
  - Update `pubspec.yaml` `fonts:` section and any text styles where necessary.

Colors & Theme
- Centralized theme: `lib/app/app_theme.dart`
- Primary color: `lib/app/app_colors.dart`

