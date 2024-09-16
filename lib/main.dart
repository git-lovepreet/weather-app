import 'package:f_weather_app01/service_weather.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'model_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _weatherService = WeatherService('b85a8546bd9e24febf005b8f9e4d967f');
  Weather? _weather;

  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();

    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather =weather;
      });
    }
    catch(e){
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition){
    if(mainCondition==null) return 'assets/anim/sunny.json';

    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/anim/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/anim/rainy.json';
      case 'thunderstorm':
        return 'assets/anim/thunder.json';
      case 'clear':
        return 'assets/anim/sunny.json';
      default:
        return 'assets/anim/sunny.json';
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city..",
              style: TextStyle(fontSize: 32,fontWeight: FontWeight.w500),),
            SizedBox(height: 20,),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            SizedBox(height: 20,),
            Text('${_weather?.temprature.round()}°C',
              style: TextStyle(fontSize: 32,fontWeight: FontWeight.w500),),
            SizedBox(height: 5,width: 40,
            child: Divider(thickness: 2,),),
            Text(_weather?.mainCondition??"",
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.w300),)
          ],
        ),
      ),
    );
  }
}
