import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/models/model.dart';

Widget defaultText(
        {required String text,
        Color? color,
        required double size,
        required FontWeight fontWeight}) =>
    Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: size,
      ),
    );

Widget defaultColumn({
  required String text,
  required IconData icon,
  required String text2,
}) =>
    Column(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.white,
        ),
        const SizedBox(
          height: 5.0,
        ),
        defaultText(
          text: text,
          size: 11,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        defaultText(
          text: text2,
          size: 10,
          fontWeight: FontWeight.w400,
          color: Colors.white54,
        ),
      ],
    );

Widget defaultComponent(
        location, current, hour, day, date, icon, image, d, currentData) =>
    ConditionalBuilder(
      condition: hour != null,
      builder: (context) {
        return Column(
          children: [
            Image.asset(
              '$d',
              width: 200,
              height: 200,
            ),
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                defaultText(
                  fontWeight: FontWeight.bold,
                  size: 80,
                  text: "${day['avgtemp_c']}",
                  color: Colors.white,
                ),
                defaultText(
                  fontWeight: FontWeight.w400,
                  size: 20,
                  text: "o",
                  color: Colors.white60,
                )
              ],
            ),
            defaultText(
              fontWeight: FontWeight.w400,
              size: 18,
              text: "${current['text']}",
              color: Colors.white,
            ),
            defaultText(
              fontWeight: FontWeight.w400,
              size: 11,
              text: "$date",
              color: Colors.white54,
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 3,
              indent: 50,
              endIndent: 50,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                defaultColumn(
                  icon: Icons.wind_power,
                  text: "${day['maxwind_kph']} km/h",
                  text2: 'Wind',
                ),
                defaultColumn(
                  icon: Icons.water_drop_outlined,
                  text: "${currentData['humidity']}%",
                  text2: 'Humidity',
                ),
                defaultColumn(
                  icon: Icons.air_outlined,
                  text: "${day['daily_chance_of_rain']}%",
                  text2: 'Chance of rain',
                ),
              ],
            ),
          ],
        );
      },
      fallback: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
String datetime = DateTime.now().toString();
Widget defaultContainer(hour, icon) {
  return Container(
    width: 80,
    height: 20,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
        border: const Border(
          top: BorderSide(
            color: Colors.white12,
            width: 1,
          ),
          bottom: BorderSide(
            color: Colors.white12,
            width: 1,
          ),
          right: BorderSide(
            color: Colors.white12,
            width: 1,
          ),
          left: BorderSide(
            color: Colors.white12,
            width: 1,
          ),
        ),
        color: datetime == true ? Colors.blue : Colors.black,
        borderRadius: BorderRadius.circular(25.0)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultText(
              text: "${hour['temp_c']}",
              size: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            defaultText(
              text: 'o',
              size: 5,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ],
        ),
        Image(image: NetworkImage("http:${hour['condition']['icon']}")),
        defaultText(
          text: hour['time'],
          size: 8,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ],
    ),
  );
}

Widget buildData(list, icon) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        height: 130,
        child: ConditionalBuilder(
          condition: list.isNotEmpty,
          builder: ((context) {
            return ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return defaultContainer(list[index], icon[index]);
                },
                separatorBuilder: ((context, index) {
                  return const SizedBox(
                    width: 15,
                  );
                }),
                itemCount: list.length);
          }),
          fallback: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );

Widget defaultDays(buildDays days) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        defaultText(
          text: days.text1,
          size: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white60,
        ),
        Row(
          children: [
            days.image,
            const SizedBox(
              width: 5,
            ),
            defaultText(
              text: days.text2,
              size: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white60,
            )
          ],
        ),
        Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultText(
                  text: days.text3,
                  size: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                defaultText(
                  text: "o",
                  size: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultText(
                  text: days.text4,
                  size: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white60,
                ),
                defaultText(
                  text: "o",
                  size: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        )
      ],
    );

Widget containerDays() => Container(
      height: 230,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 9, 106, 204).withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 70,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 49, 178, 253),
            Color.fromARGB(255, 9, 106, 204)
          ],
        ),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        color: const Color.fromARGB(255, 49, 178, 253),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/cloudy.png",
                width: 120,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultText(
                    text: "Tommorow",
                    size: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      defaultText(
                        text: "20",
                        size: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      defaultText(
                        text: "/17",
                        size: 35,
                        fontWeight: FontWeight.w500,
                        color: Colors.white38,
                      ),
                    ],
                  ),
                  defaultText(
                      text: "Rainy-Cloudy",
                      size: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white54)
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            height: 5,
            indent: 50,
            endIndent: 50,
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              defaultColumn(
                icon: Icons.wind_power,
                text: "13 km/h",
                text2: 'Wind',
              ),
              defaultColumn(
                icon: Icons.water_drop_outlined,
                text: "24%",
                text2: 'Humidity',
              ),
              defaultColumn(
                icon: Icons.air_outlined,
                text: "87%",
                text2: 'Chance of rain',
              ),
            ],
          ),
        ],
      ),
    );

buildAppBar(title1, IconData icon, String title, IconData iconTitle,
        {required Function()? onpressed}) =>
    AppBar(
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconTitle,
          ),
          defaultText(
              text: title,
              size: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white)
        ],
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 49, 178, 253),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: const Color.fromARGB(255, 49, 178, 253),
    );

Widget buildHomeContainer(
        location, current, hour, day, date, icon, image, d, currentData) =>
    Container(
      height: 440,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 9, 106, 204).withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 70,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 49, 178, 253),
            Color.fromARGB(255, 9, 106, 204)
          ],
        ),
        color: Colors.blue[400],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
        ),
      ),
      child: defaultComponent(
          location, current, hour, day, date, icon, image, d, currentData),
    );

Widget buildArrowDay(context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          defaultText(
            text: 'Today',
            size: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "viewdays");
            },
            iconSize: 60,
            icon: Row(
              children: const [
                Expanded(
                  flex: 2,
                  child: Text(
                    '7 days',
                    style: TextStyle(color: Colors.white38),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Colors.white38,
                ),
              ],
            ),
          ),
        ],
      ),
    );
