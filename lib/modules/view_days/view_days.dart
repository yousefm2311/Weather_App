import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/models/list.dart';
import 'package:weather_app/services/bloc/cubit.dart';

import 'package:weather_app/shared/component/component.dart';

import '../../services/bloc/states.dart';

class ViewDays extends StatelessWidget {
  const ViewDays({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitWeather, WeatherState>(
      builder: (context, state) {
        var location = CubitWeather.get(context).Location;
        return Scaffold(
          appBar: buildAppBar(
            location,
            Icons.arrow_back_ios_new_rounded,
            " 7 days",
            Icons.calendar_today_rounded,
            isLoading: true,
            onpressed: () {
              Navigator.pop(context);
            },
          ),
          body: Column(
            children: [
              containerDays(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return defaultDays(days[index]);
                      }),
                      separatorBuilder: ((context, index) {
                        return const SizedBox(
                          height: 30,
                        );
                      }),
                      itemCount: days.length))
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
