import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/services/weatherservice.dart';

import '../models/weathermodel.dart';

class weatherApp extends StatefulWidget {
  const weatherApp({super.key});

  @override
  State<weatherApp> createState() => _weatherAppState();
}

class _weatherAppState extends State<weatherApp> {
  //api key
  final _weatherService = WeatherService('853762467190d191835d9d3e2e9d1881');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get cityname
    String cityName = await _weatherService.getCurrentCity();

    //get cityweather
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'smoke':
      case 'haze':
      case 'dust':
        return 'assets/cloudy.json';
      case 'mist':
        return 'assets/mist.json';
      case 'fog':
        return 'assets/fog.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //cityname
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_pin,size: 30),
                SizedBox(width: 20,),
                Text(
                  _weather?.cityName ?? 'loading city..',style: TextStyle(fontSize: 40),
                )
              ],
            ),
            SizedBox(height: 80),

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //temperature
            Text('${_weather?.temperature.round()}°C'),

            //main condition
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
