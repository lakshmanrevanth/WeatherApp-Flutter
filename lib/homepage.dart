import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weatherapp/hourbriefpage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, dynamic>> getcurrentweather() async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=Potheri,ind&APPID=66ff0597e61aca357884cbfedb2f434d'),
      );

      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw "an error occurred";
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getcurrentweather(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final temp = data['list'][0]['main']['temp'] - 270;
          final formater = NumberFormat.decimalPattern();

          final sky = data['list'][0]['weather'][0]['main'];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                formater.format(temp) + "°c",
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                sky == "Clouds" || sky == "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 70,
                              ),
                              Text(
                                "$sky ",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hourly Forecast",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 5; i++)
                //         Container(
                //           width: 100,
                //           height: 100,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(12),
                //           ),
                //           child: Card(
                //             child: Column(children: [
                //               SizedBox(
                //                 height: 5,
                //               ),
                //               Text(data['list'][i + 1]['dt'].toString()),
                //               Icon(data['list'][i + 1]['weather'][0]['main'] ==
                //                           "Clouds" ||
                //                       data['list'][i + 1]['weather'][0]['main'] ==
                //                           "Rain"
                //                   ? Icons.cloud
                //                   : Icons.sunny),
                //               Text(data['list'][i + 1]['weather'][0]['main']),
                //             ]),
                //           ),
                //         ),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: ((context, index) {
                        final time =
                            DateTime.parse(data['list'][index + 1]['dt_txt']);
                        final temp =
                            data['list'][index + 1]['main']['temp'] - 270;
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HourBriefPage(
                                        temperature: formater.format(temp),
                                        sky: data['list'][index + 1]['weather']
                                            [0]['main'],
                                        windspeed: data['list'][index + 1]
                                                ['wind']['speed']
                                            .toString(),
                                        pressure: data['list'][index + 1]
                                                ['main']['pressure']
                                            .toString(),
                                        humidity: data['list'][index + 1]
                                                ['main']['humidity']
                                            .toString(),
                                      ))),
                          child: Center(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Card(
                                child: Column(children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    DateFormat.Hm().format(time),
                                    maxLines: 1,
                                  ),
                                  Icon(data['list'][index + 1]['weather'][0]
                                                  ['main'] ==
                                              "Clouds" ||
                                          data['list'][index + 1]['weather'][0]
                                                  ['main'] ==
                                              "Rain"
                                      ? Icons.cloud
                                      : Icons.sunny),
                                  Text(data['list'][index + 1]['weather'][0]
                                      ['main']),
                                ]),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Additional information",
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.water_drop),
                        Text("Humidity"),
                        Text(data['list'][0]['main']['humidity'].toString()),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.power_input),
                        Text("Pressure"),
                        Text(data['list'][0]['main']['pressure'].toString()),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.wind_power),
                        Text("wind"),
                        Text(data['list'][0]['wind']['speed'].toString()),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
