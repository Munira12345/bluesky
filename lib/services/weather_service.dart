import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const String _apiKey = 'cfe577b09f43deea2722462eea76e473';
  static const String _baseUrl = 'http://api.openweathermap.org/data/2.5';


  Future<CurrentWeather> fetchCurrentWeather(String cityName) async {
    final url = Uri.parse('$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric');
    final response = await http.get(url);

    // if the get call is successful we get the weather details, if not we throw an error exception
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return CurrentWeather.fromJson(jsonBody);
    } else {
      throw Exception('Failed to load current weather');
    }
  }


  Future<List<ForecastItem>> fetch5DayForecast(String cityName) async {
    final url = Uri.parse('$_baseUrl/forecast?q=$cityName&appid=$_apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List<dynamic> forecastList = jsonBody['list'];


      final filtered = forecastList.where((item) {
        final dateTime = DateTime.parse(item['dt_txt']);
        return dateTime.hour == 12;
      }).toList();

      return filtered.map((item) => ForecastItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
