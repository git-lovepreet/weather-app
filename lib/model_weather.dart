class Weather{
  late final String cityName;
  late final double temprature;
  late final String mainCondition;

  Weather({required this.cityName,required this.temprature,required this.mainCondition});

  factory Weather.fromJson(Map<String,dynamic> json){
    return Weather(
        cityName: json['name'],
        temprature: json['main']['temp'].toDouble(),
        mainCondition: json['weather'][0]['main']);
  }
}