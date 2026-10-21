import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'output_page.dart';

class City {
  final String name;
  final double latitude;
  final double longitude;
  final String? admin1;
  final String? country;

  City({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.admin1,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      admin1: json['admin1'],
      country: json['country'],
    );
  }

  @override
  String toString() {
    return '$name, ${admin1 ?? ''}, ${country ?? ''}';
  }
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  City? _selectedCity;

  Future<Iterable<City>> _fetchCitySuggestions(String query) async {
    if (query.isEmpty) {
      return [];
    }

    final url =
        'https://geocoding-api.open-meteo.com/v1/search?name=$query&count=5&language=nl&format=json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          final results = data['results'] as List;
          return results.map((json) => City.fromJson(json));
        }
      }
    } catch (_) {
      return [];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gevoelstemperatuurmeter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            tooltip: 'Instellingen',
          ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selecteer een stad of land',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 40),
              Autocomplete<City>(
                displayStringForOption: (City option) => option.name,
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<City>.empty();
                  }
                  return _fetchCitySuggestions(textEditingValue.text);
                },
                onSelected: (City selection) {
                  setState(() {
                    _selectedCity = selection;
                  });
                },
                fieldViewBuilder:
                    (
                      BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted,
                    ) {
                      return TextField(
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        decoration: InputDecoration(
                          labelText: 'Voer stad of land in',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Theme.of(
                            context,
                          ).colorScheme.surface.withAlpha(204),
                        ),
                      );
                    },
                optionsViewBuilder:
                    (
                      BuildContext context,
                      AutocompleteOnSelected<City> onSelected,
                      Iterable<City> options,
                    ) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4.0,
                          child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final City option = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: ListTile(
                                    title: Text(option.name),
                                    subtitle: Text(
                                      '${option.admin1 ?? ''}, ${option.country ?? ''}',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _selectedCity != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OutputPage(city: _selectedCity!),
                          ),
                        );
                      }
                    : null,
                child: const Text('Controleer Temperatuur'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
