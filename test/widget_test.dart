import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:myapp/home_page.dart';
import 'package:myapp/main.dart';

void main() {
  testWidgets('Home page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Gevoelstemperatuurmeter'), findsOneWidget);
    expect(find.text('Selecteer een stad of land'), findsOneWidget);
    expect(find.byType(Autocomplete<City>), findsOneWidget);
  });
}
