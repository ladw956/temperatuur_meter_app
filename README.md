# Gevoelstemperatuur App

School project by Jaylee Wigley, built with Flutter and Dart.

The app lets a user search for a city, loads current weather data, and calculates a perceived temperature from the air temperature and wind speed. It also includes a settings page and light/dark theme switching.

## Data sources

- Open-Meteo Geocoding API for city suggestions.
- MET Norway Locationforecast 2.0 for weather data.

For the web build, the included Render/Nginx configuration proxies MET Norway requests so the deployment can identify itself with the required User-Agent. Coordinates are limited to four decimals before the request is sent.

## Run locally

1. Install Flutter.
2. Run `flutter pub get`.
3. Run `flutter test`.
4. Run `flutter run` for a mobile/desktop target.

For the browser build, the production Render setup supplies the MET Norway proxy. A plain `flutter run -d chrome` session does not include that proxy.

## Render deployment

This repository includes `render.yaml` and a Dockerfile. In Render, create a Blueprint from the repository. The free web service can spin down when idle, so the first visit after inactivity can take approximately a minute to start.

## Project documentation

The original exam documentation and wireframe are in `docs/`.

## Repository size

Generated Flutter folders such as `build/`, `.dart_tool/`, Android Gradle caches, editor state, and the local Git database are intentionally excluded. They are generated locally and should not be committed.

## License

No open-source license has been selected yet. Add a license file before describing the repository as formally open-source licensed.
