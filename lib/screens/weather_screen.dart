import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  String? temperature;
  String? description;
  String? location;

  void fetchWeather(String city) async {
    var weatherData = await WeatherService().getWeather(city);
    setState(() {
      temperature = weatherData['temp'];
      description = weatherData['description'];
      location = weatherData['city'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    fetchWeather(_controller.text);
                    
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            if (temperature != null && description != null && location != null)
              Column(
                children: [
                  Text(
                    'Temperature: $temperature°C',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  Text(
                    'Condition: $description',
                    style: TextStyle(fontSize: 20,color: Colors.green),
                  ),
                  Text(
                    'Location: $location',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}