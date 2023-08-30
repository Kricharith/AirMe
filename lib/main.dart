import 'package:airme/pmservices/pmTrackerservice.dart';
import 'package:airme/ui/connectBluetooth.dart';
import 'package:airme/ui/homepage.dart';
import 'package:airme/ui/weatherAll.dart';
import 'package:airme/ui/weatherCity.dart';
import 'package:airme/ui/weatherForecast.dart';
import 'package:airme/ui/weatherMain.dart';
import 'package:airme/ui/weatherMe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PmTrackerService(
          'https://api.waqi.info/feed/geo:13.7618;100.5324/?token=37f877675e52898d4a3dc3bce7c5bd6e3bd3eff4'),
      child: MaterialApp(
        home: buildMaterialApp(),
      ),
    );
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ปิดการแสดงข้อความ Debug
      title: 'Flutter Demo',
      /*theme: ThemeData(
        primarySwatch: Colors.amber,
      ),*/

      initialRoute: '/homepage',
      routes: {
        '/homepage': (context) => Homepage(),
        '/weatherAll': (context) => WeatherAll(),
        '/weatherMain': (context) => WeatherMain(),
        '/weatherMe': (context) => WeatherMe(),
        '/connectBluetooth': (context) => ConnectBluetooth(),
        '/weatherCity': (context) => WeatherCity(),
        '/weatherForecast': (context) => WeatherForcast(),
      },
    );
  }
}
