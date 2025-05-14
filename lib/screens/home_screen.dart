import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false).fetchWeather('Nairobi');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchWeather() {
    final city = _searchController.text.trim();
    if (city.isNotEmpty) {
      Provider.of<WeatherProvider>(context, listen: false).fetchWeather(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final currentWeather = weatherProvider.currentWeather;
    final forecast = weatherProvider.forecast;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        title: const Text('BlueSky Weather App'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // users can search specific cities by typing a name
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Enter city name',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _searchWeather(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchWeather,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (weatherProvider.isOfflineData)
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 16),
                color: Colors.orange[100],
                child: const Text(
                  'You are viewing offline weather data',
                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              ),

            // Weather Display and appropriate Forecasts
            Expanded(
              child: weatherProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : currentWeather == null
                  ? const Center(child: Text('No weather data available. Please check later.'))
                  : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    Text(
                      currentWeather.cityName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${currentWeather.temperature}°C',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentWeather.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Last Updated: ${currentWeather.lastUpdated}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 24),

                    //  Forecast that will show the next five day updates
                    const Text(
                      'Upcoming City Forecast',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    if (forecast != null)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: forecast.length,
                        itemBuilder: (context, index) {
                          final item = forecast[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Image.network(
                                'http://openweathermap.org/img/wn/${item.icon}@2x.png',
                                width: 50,
                              ),
                              title: Text(
                                '${item.temperature}°C - ${item.description}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              subtitle: Text(
                                item.date.toLocal().toString().split(' ')[0],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
