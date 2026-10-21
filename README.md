# Gevoelstemperatuur App

School project by **Jaylee Wigley**, built with Flutter and Dart.

The app allows users to search for a city, retrieve current weather data, and calculate the perceived temperature based on air temperature and wind speed. It also includes a settings page and light/dark theme switching.

This repository is publicly available as part of my portfolio and for educational/source-code review.

## Data sources

- Open-Meteo Geocoding API for city suggestions.
- MET Norway Locationforecast 2.0 for weather data.

For the hosted web version, the Render/Nginx configuration proxies MET Norway requests so the deployment can identify itself with the required User-Agent. Coordinates are limited to four decimal places before the request is sent.

## Development

The project was created with Flutter and Dart.

For local development:

1. Install Flutter.
2. Run `flutter pub get`.
3. Run `flutter test`.
4. Run `flutter run` for a supported mobile or desktop target.

The production web version uses a server-side proxy for MET Norway. A normal `flutter run -d chrome` development session does not include that production proxy configuration.

## Live version

The official hosted version of this project is deployed and maintained by **Jaylee Wigley**.

The included deployment configuration is part of the project source and documents how the official portfolio demonstration is built. It is **not permission for third parties to deploy, host, mirror, redistribute, or operate their own public copy of this application**.

The live portfolio demonstration may run on a free hosting tier and can therefore take approximately one minute to start after a period of inactivity.

## Project documentation

The original exam documentation and wireframe are available in the `docs/` directory.

## Repository size

Generated Flutter folders and development artifacts such as:

- `build/`
- `.dart_tool/`
- Android Gradle caches
- editor state
- local Git data

are intentionally excluded from this repository. These files are generated locally and are not part of the project source.

## Copyright and usage

Copyright © Jaylee Wigley. All rights reserved.

This repository is publicly accessible for portfolio presentation, educational review, and source-code inspection.

No permission is granted to:

- host or deploy a public copy of the application;
- redistribute the application or its source code;
- publish modified versions;
- use the project as the basis of another hosted service;
- commercially exploit the project;
- present the project or substantial parts of it as someone else's work.

No open-source license has been granted.

The official hosted version and any authorized deployment remain under the control of **Jaylee Wigley**.
