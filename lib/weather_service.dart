import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:weather_flutter_demo_app/models.dart';

class WeatherService {
  Future<WeatherResponse> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    //https://api.openweathermap.org/data/2.5/weather?q=Bruxelles&appid=e3c11cf55aa008c74dadb45114075c5d&units=metric

    final queryParameters = {
      'q': city,
      'appid': 'e3c11cf55aa008c74dadb45114075c5d',
      'units': 'metric'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}