import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  CurrentWeather? _currentWeather;
  List<ForecastItem>? _forecast;
  bool _isLoading = false;
  String? _error;
  bool _isOfflineData = false;

  CurrentWeather? get currentWeather => _currentWeather;
  List<ForecastItem>? get forecast => _forecast;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isOfflineData => _isOfflineData;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _error = null;
    _isOfflineData = false;
    notifyListeners();

    // checking for connectivity to determine if we show cached weather
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity != ConnectivityResult.none) {
      try {
        _currentWeather = await _weatherService.fetchCurrentWeather(city);
        _forecast = await _weatherService.fetch5DayForecast(city);
        _isOfflineData = false;
        await _cacheData();
      } catch (e) {
        _error = 'Failed to fetch weather: $e';
      }
    } else {
      // if yes, we try loading cached data
      await _loadCachedData();
      _isOfflineData = true;
      if (_currentWeather == null || _forecast == null) {
        _error = 'No internet and no cached data found';
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _cacheData() async {
    final prefs = await SharedPreferences.getInstance();
    if (_currentWeather != null && _forecast != null) {
      prefs.setString('currentWeather', json.encode(_currentWeather!.toJson()));
      prefs.setString('forecast', json.encode(_forecast!.map((e) => e.toJson()).toList()));
    }
  }

  Future<void> _loadCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final currentWeatherString = prefs.getString('currentWeather');
    final forecastString = prefs.getString('forecast');

    if (currentWeatherString != null && forecastString != null) {
      final currentWeatherJson = json.decode(currentWeatherString);
      final forecastJson = json.decode(forecastString) as List;

      _currentWeather = CurrentWeather.fromJson(currentWeatherJson);
      _forecast = forecastJson.map((e) => ForecastItem.fromJson(e)).toList().cast<ForecastItem>();
    }
  }
}
