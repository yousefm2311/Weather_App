// ignore_for_file: camel_case_types, must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/services/bloc/cubit.dart';
import 'package:weather_app/services/bloc/states.dart';
import 'package:weather_app/shared/component/component.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitWeather, WeatherState>(
      builder: (context, state) {
        var list = CubitWeather.get(context).Hour;
        var location = CubitWeather.get(context).Location;
        var current = CubitWeather.get(context).Current;
        var day = CubitWeather.get(context).Day;
        var date = CubitWeather.get(context).date;
        var icon = CubitWeather.get(context).hour2;
        var image = CubitWeather.get(context).Icon1;
        var currentData = CubitWeather.get(context).CurrentData;
        var d = CubitWeather.get(context).getImage();
        return Scaffold(
          appBar: buildAppBar(
            location,
            Icons.space_dashboard_rounded,
            "${location['name']}",
            Icons.location_on,
            onpressed: () {},
          ),
          body: SafeArea(
            child: Column(
              children: [
                buildHomeContainer(
                    location, current, list, day, date, icon, image,d,currentData),
                buildArrowDay(context),
                buildData(list, icon)
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is loadingState) {
          
        }
      },
    );
  }
}
