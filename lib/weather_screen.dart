import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './addtional_info_widget.dart';
import 'package:weatherapp/forecast-widget-card.dart';
import 'keys/api_key.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  ///
  ///
  ///
  ///
  Future<Map<String, dynamic>> getWeather() async {
    try {
      String cityName = 'London';
      final result = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$apikey'),
      );
      final data = jsonDecode(result.body);

      if (data['cod'] != '200') {
        throw 'An Unexpected Error Occured';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  //
  //
  @override
  void initState() {
    super.initState();
    weather = getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      //
      //
      //
      appBar: AppBar(
        title: const Text(
          'weather app',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () {
                setState(() {
                  weather = getWeather();
                });
              },
              child: const Icon(Icons.refresh)),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      //
      //
      //
      //
      //
      //MAIN CARD
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("error occured"));
          }

          final data = snapshot.data!;

          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final humidity = data['list'][0]['main']['humidity'];
          final wind = data['list'][0]['wind']['speed'];
          final pressure = data['list'][0]['main']['pressure'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp k',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 75,
                              ),
                              Text(
                                currentSky,
                                style: const TextStyle(fontSize: 22),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //
                //
                //
                //
                //weather forecast cards
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Weather Forecast ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //
                //
                //
                //
                //
                //,
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index + 1];
                        final hourlySky = hourlyForecast['weather'][0]['main'];
                        final time = DateTime.parse(hourlyForecast['dt_txt']);
                        return ForecastWidgetCard(
                          icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                          temp: hourlyForecast['main']['temp'].toString(),
                          time: DateFormat.j().format(time),
                        );
                      }),
                ),
                //aditional INFO
                const SizedBox(
                  height: 20,
                ),

                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Aditional Info.',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

                ///
                ///
                ///
                ///
                //additonal info WIDGET
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AditionalInfoWidget(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: humidity.toString(),
                    ),
                    AditionalInfoWidget(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: wind.toString(),
                    ),
                    AditionalInfoWidget(
                      icon: Icons.speed,
                      label: 'pressure',
                      value: pressure.toString(),
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
