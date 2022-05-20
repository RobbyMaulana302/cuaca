import 'dart:convert';
import 'dart:html';
import 'package:aplikasi_cuaca/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as http;

class DataService {
  Future<Weather> fetchData(String cityName) async {
    try {
      //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
      final queryParameters = {
        'q': cityName,
        'appid': 'e3a34b38b556caeca5d131cac9055b29',
        'units': 'imperial'
      };
      final uri = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', queryParameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('fail to load weather');
      }
    } catch (e) {
      rethrow;
    }
  }
}
