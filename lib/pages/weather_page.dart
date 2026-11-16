import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final String _apiKey = '2344a779d3123e4bce9a2afa3eb74092';
  final String _city = 'Kayseri';
  String _temperature = '';
  String _description = '';
  String _cityName = '';
  String _weatherIconUrl = '';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$_city&appid=$_apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          _cityName = data['name'];
          _temperature = '${data['main']['temp']}°C';
          _description = data['weather'][0]['description'];
          _weatherIconUrl =
          'http://openweathermap.org/img/wn/${data['weather'][0]['icon']}@2x.png';
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      setState(() {
        _cityName = 'Error';
        _temperature = 'N/A';
        _description = 'Could not fetch data';
        _weatherIconUrl = '';
      });
      print('Error fetching weather data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in Kayseri'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Color(0xFFFFF5E1),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_weatherIconUrl.isNotEmpty)
                  Image.network(
                    _weatherIconUrl,
                    width: 100,
                    height: 100,
                  ),
                SizedBox(height: 20),
                Text(
                  _cityName,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _temperature,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  _description.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: fetchWeatherData,
                  child: Text(
                    'Refresh',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding:
                    EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
