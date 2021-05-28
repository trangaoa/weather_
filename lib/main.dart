import 'package:flutter/material.dart';
import 'weather_app.dart';
import 'package:wemapgl/wemapgl.dart' as WEMAP;

void main() {
  WEMAP.Configuration.setWeMapKey(YOUR_WEMAP_KEY);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherApp(),
    );
  }
}
