import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:bluesky/screens/home_screen.dart';
import 'package:bluesky/providers/weather_provider.dart';

void main() {
  testWidgets('HomeScreen basic UI renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => WeatherProvider(),
          child: const HomeScreen(),
        ),
      ),
    );

    // our appBar title displays
    expect(find.text('BlueSky Weather App'), findsOneWidget);

    // Search input field is available for the user
    expect(find.byType(TextField), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Enter city name'), findsOneWidget);

    // Search button is shown for user to click
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Default loading or empty state when no weather shows
    expect(find.text('No weather data available. Please check later.'), findsOneWidget);
  });
}
