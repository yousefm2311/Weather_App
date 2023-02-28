// ignore_for_file: unused_local_variable, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/model_weather.dart';
import 'package:weather_app/services/bloc/states.dart';
import "package:http/http.dart" as http;

class CubitWeather extends Cubit<WeatherState> {
  CubitWeather() : super(InitialState());

  static CubitWeather get(context) => BlocProvider.of(context);
  String baseUrl = "http://api.weatherapi.com/v1";
  String apiKey = "f9a04dbd33e24df9ae0221852230301";
  String city = "egypt";
  weatherModel? model;
  forecastdayModel? model2;
  List Hour = [];
  String? date;
  Map<String, dynamic> Icon1 = {};
  Map<String, dynamic> hour2 = {};
  Map<String, dynamic> Day = {};
  Map<String, dynamic> Location = {};
  Map<String, dynamic> Current = {};
  Map<String, dynamic> CurrentData = {};
  void getWeather() async {
    emit(LoadingState());
    Uri url = Uri.parse(
        "$baseUrl/forecast.json?key=$apiKey&q=$city&days=1&aqi=no&alerts=no");
    http.Response response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);
    Hour = data["forecast"]["forecastday"][0]['hour'];
    hour2 = data["forecast"]["forecastday"][0]['hour'][0]["condition"];
    Day = data["forecast"]["forecastday"][0]['day'];
    Icon1 = data["forecast"]["forecastday"][0]['day']['condition'];
    print("http:${Icon1['icon']}");
    date = data["forecast"]["forecastday"][0]['date'];
    Location = data["location"];
    Current = data["current"]["condition"];
    CurrentData = data["current"];
    print(CurrentData['humidity']);
    model = weatherModel.fromJson(data);
    emit(GetDatasuccessState());
  }

  String getImage() {
    if (Current['text'] == "Partly cloudy" ||
        Current['text'] == "Patchy rain possible") {
      return 'assets/images/rainy.png';
    } else if (Current['text'] == "Clear" || Current['text'] == "Sunny") {
      return 'assets/images/clear.png';
    } else if (Current['text'] == "Overcast") {
      return 'assets/images/overcast.png';
    } else if (Current['text'] == "Cloudy") {
      return 'assets/images/cloudy.png';
    } else {
      return 'assets/images/sunny.png';
    }
  }
}
