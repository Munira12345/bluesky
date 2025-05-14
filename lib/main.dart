import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/weather_provider.dart';

void main() {
  runApp(const BlueSkyApp());
}

class BlueSkyApp extends StatelessWidget {
  const BlueSkyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MaterialApp(
        title: 'BlueSky Weather',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
