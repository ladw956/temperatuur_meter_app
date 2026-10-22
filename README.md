# Gevoelstemperatuur App

School project by **Jaylee Wigley**, built with Flutter and Dart.

This repository is publicly available as part of my portfolio and for educational/source-code review.

The app lets a user search for a city, retrieve current weather data, and calculate the perceived temperature from air temperature and wind speed. It also includes a settings page and light/dark theme switching.

## Data sources

- Open-Meteo Geocoding API for city suggestions.
- MET Norway Locationforecast 2.0 for weather data.

Coordinates are limited to four decimal places before weather requests are sent.

## Development

For local mobile/desktop development:

1. Install Flutter.
2. Run `flutter pub get`.
3. Run `flutter test`.
4. Run `flutter run` for a supported mobile or desktop target.

The official browser deployment uses a server-side weather proxy maintained separately from this public source repository. A plain `flutter run -d chrome` session does not include that production proxy.

## Official live demonstration

The official hosted portfolio demonstration is deployed and maintained by **Jaylee Wigley**.

Hosting and deployment configuration for the official environment is maintained in a separate private deployment repository and is not included here.

The live portfolio demonstration may run on a free hosting tier and can therefore take approximately one minute to start after a period of inactivity.

## Project documentation

The original exam documentation and wireframe are available in the `docs/` directory.

## Repository size

Generated Flutter folders and development artifacts such as `build/`, `.dart_tool/`, Android Gradle caches, editor state, and local Git data are intentionally excluded.

## Copyright and usage

Copyright © Jaylee Wigley. All rights reserved.

This repository is publicly accessible for portfolio presentation, educational review, and source-code inspection.

No permission is granted to host or deploy a public copy of the application, redistribute the application or its source code, publish modified versions, commercially exploit the project, or present the project or substantial parts of it as someone else's work.

No open-source license has been granted.
