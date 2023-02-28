import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/modules/home_page/home.dart';
import 'package:weather_app/modules/view_days/view_days.dart';
import 'package:weather_app/services/bloc/cubit.dart';
import 'package:weather_app/services/bloc/states.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => CubitWeather() ..getWeather(),)
        ],
        child: BlocConsumer<CubitWeather, WeatherState>(
            builder: ((context, state) {
              return MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    scaffoldBackgroundColor: Colors.black,
                    appBarTheme: const AppBarTheme(
                      elevation: 0,
                      color: Color.fromARGB(255, 49, 178, 253),
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color.fromARGB(255, 49, 178, 253),
                        statusBarIconBrightness: Brightness.dark,
                        statusBarBrightness: Brightness.light,
                      ),
                    ),
                  ),
                  debugShowCheckedModeBanner: false,
                  themeMode: ThemeMode.light,
                  initialRoute: "home",
                  routes: {
                    'home': (context) =>const HomePage(),
                    'viewdays': (context) => const ViewDays()
                  });
            }),
            listener: ((context, state) {})));
  }
}
