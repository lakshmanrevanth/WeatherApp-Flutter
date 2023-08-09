import 'package:flutter/material.dart';

class HourBriefPage extends StatefulWidget {
  final temperature;
  final sky;
  final windspeed;
  final pressure;
  final humidity;
  HourBriefPage({
    required this.temperature,
    required this.sky,
    required this.windspeed,
    required this.pressure,
    required this.humidity,
  });
  @override
  State<HourBriefPage> createState() => _HourBriefPageState(
      temperature: temperature,
      sky: sky,
      windspeed: windspeed,
      pressure: pressure,
      humidity: humidity);
}

class _HourBriefPageState extends State<HourBriefPage> {
  final temperature;
  final sky;
  final windspeed;
  final pressure;
  final humidity;
  _HourBriefPageState({
    this.temperature,
    this.sky,
    this.windspeed,
    this.pressure,
    this.humidity,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hour Page"),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: temperature == 0
          ? const CircularProgressIndicator()
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        temperature.toString(),
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "°c",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Cloudy",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25, right: 25, top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Wind Speed",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.7),
                                ),
                                Text(
                                  "2.86",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25, right: 25, top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pressure",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.7),
                                ),
                                Text(
                                  "1009",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Humidity",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.7),
                                ),
                                Text(
                                  "69",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
