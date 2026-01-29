import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

// Settings Page - Explanation in Dutch
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instellingen'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withAlpha(230),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Over deze app',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Deze app berekent de temperatuur van veel landen en steden wereldwijd en geeft de gevoelstemperatuur weer op basis van realtime weergegevens. De gevoelstemperatuur wordt berekend op basis van de temperatuur en de windsnelheid.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 20),
                Text(
                  '1. Selecteer een stad of land op de startpagina\n\n'
                  '2. De app haalt realtime weergegevens op via een weer-API\n\n'
                  '3. Er wordt een berekening gemaakt op basis van de temperatuur en windsnelheid\n\n'
                  '4. Je kunt de gevoelstemperatuur en het werkelijke temperatuur zien op de outputpagina',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 20),
                // Interactive Elements Panel
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withAlpha(180),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(100),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interactieve elementen',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        title: Text(
                          'Donker thema',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                        ),
                        subtitle: Text(
                          'Wissel tussen licht en donker thema\'s',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer.withAlpha(200),
                              ),
                        ),
                        value: themeProvider.themeMode == ThemeMode.dark,
                        onChanged: (bool value) {
                          themeProvider.toggleTheme();
                        },
                        secondary: Icon(
                          themeProvider.themeMode == ThemeMode.dark
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Divider(
                  thickness: 2,
                  color: Theme.of(context).colorScheme.primary,
                  height: 40,
                ),
                Text(
                  '• Realtime weerdata van over de hele wereld\n'
                  '• Automatische berekening van gevoelstemperatuur\n'
                  '• Licht en donker thema\n'
                  '• Eenvoudige users interface',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Terug naar Home'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
