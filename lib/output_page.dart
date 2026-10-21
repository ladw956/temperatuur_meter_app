import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'home_page.dart';

class OutputPage extends StatefulWidget {
  final City? city;

  const OutputPage({super.key, this.city});

  @override
  OutputPageState createState() => OutputPageState();
}

class OutputPageState extends State<OutputPage> {
  String _weatherInfo = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.city != null) {
      _fetchWeather(widget.city!);
    }
  }

  double _calculateFeelsLike(double temp, double windSpeed) {
    if (temp > 10) return temp;
    return 13.12 +
        0.6215 * temp -
        11.37 * pow(windSpeed * 3.6, 0.16) +
        0.3965 * temp * pow(windSpeed * 3.6, 0.16);
  }

  Future<void> _fetchWeather(City city) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final latitude = city.latitude.toStringAsFixed(4);
      final longitude = city.longitude.toStringAsFixed(4);
      final weatherUrl = kIsWeb
          ? '/weatherapi/locationforecast/2.0/compact?lat=$latitude&lon=$longitude'
          : 'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=$latitude&lon=$longitude';
      final weatherResponse = await http.get(
        Uri.parse(weatherUrl),
        headers: kIsWeb
            ? const {}
            : const {
                'User-Agent':
                    'JayleeWigleyTemperatureApp/1.0 https://github.com/ladw956/temperatuur_meter_app',
              },
      );

      if (weatherResponse.statusCode == 200) {
        final weatherData = jsonDecode(weatherResponse.body);
        final timeseries = weatherData['properties']['timeseries'][0];
        final details = timeseries['data']['instant']['details'];
        final temp = details['air_temperature'].toDouble();
        final windSpeed = details['wind_speed'].toDouble();
        final windSpeedKmh = windSpeed * 3.6;

        final feelsLike = _calculateFeelsLike(temp, windSpeed);

        setState(() {
          _weatherInfo =
              'Gevoel: ${feelsLike.toStringAsFixed(1)}°C\nActueel: ${temp.toStringAsFixed(1)}°C\nWind: ${windSpeedKmh.toStringAsFixed(1)} km/u';
        });
      } else {
        setState(() {
          _weatherInfo =
              'Kan geen weergegevens ophalen. Status: ${weatherResponse.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _weatherInfo = 'Er is een fout opgetreden: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city?.name ?? 'Weer Output'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Thema wisselen',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              const Color.fromRGBO(0, 0, 0, 0.3),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (widget.city != null)
                Text(
                  '${widget.city!.name}, ${widget.city!.country ?? ''}',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              Expanded(
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : _weatherInfo.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surface.withAlpha(230),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(0, 0, 0, 0.2),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.thermostat,
                                size: 64,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                _weatherInfo,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : const Text('Geen weergegevens beschikbaar'),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Terug naar Home'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
