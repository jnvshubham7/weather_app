import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();

class WeatherService {
  final String apiKey =
      'PUT_YOUR_API_KEY'; // Replace with your API key
  Future<Map<String, dynamic>> getWeather(String city) async {
    final queryParameters = {
      'q': city,
      'appid': apiKey,
      'units': 'metric',
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    // Debugging: Print the status code and response body
    logger.i('Response status: ${response.statusCode}');
    logger.i('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'temp': data['main']['temp'].toString(),
        'description': data['weather'][0]['description'],
        'city': data['name'],
      };
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }
}
