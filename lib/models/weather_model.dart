class CurrentWeather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final DateTime lastUpdated;

  CurrentWeather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.lastUpdated,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      lastUpdated: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'main': {'temp': temperature},
      'weather': [
        {
          'description': description,
          'icon': icon,
        }
      ],
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class ForecastItem {
  final DateTime date;
  final double temperature;
  final String description;
  final String icon;

  ForecastItem({
    required this.date,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      date: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt_txt': date.toIso8601String(),
      'main': {'temp': temperature},
      'weather': [
        {
          'description': description,
          'icon': icon,
        }
      ],
    };
  }
}
