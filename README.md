# WooClot Flutter – Documentation

Welcome! This guide helps you set up, customize, and publish the app for CodeCanyon buyers.

If you are reviewing this item for submission, skim through this index and the linked guides to validate build, branding, and configuration flows.

Contents
- Getting Started and Requirements
- Configuration via AppConfig (no code edits required)
- Branding (app name, icon, splash)
- Building Releases (Android/iOS) with obfuscation
- Feature Overview and Demo Data
- Credits and Licenses

Quick Links
- Configuration: documentation/configuration.md
- Branding: documentation/branding.md
- Build & Publish: documentation/build_and_publish.md
- Changelog: CHANGELOG.md

Getting Started
1) Install Flutter (channel stable) and platform toolchains.
    - Flutter: 3.9.x or newer (Dart SDK ^3.9.0)
    - Android: Android Studio + SDK; iOS: Xcode (on macOS)
2) From the project root, run:
    - flutter pub get
    - flutter run

Feature Highlights
- Clean architecture with Provider state management
- Product browsing, details, cart, wishlist, orders, profiles
- Global smooth transitions and scroll behavior
- Animated splash intro
- Sticky checkout button in Cart screen

Demo Data
The app ships with optional in-memory demo data for cart, wishlist, notifications, and orders. This is ideal for screenshots and quick verification without backend setup. It is controlled at compile time; see documentation/configuration.md.

Support
For item support (installation questions, small fixes), please reach out using your marketplace purchase email and include:
- Order ID
- Flutter doctor output
- Steps to reproduce (if bug)

Thank you for choosing WooClot!

