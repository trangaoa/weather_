import 'package:flutter/material.dart';
import 'package:wemapgl_example/single_details.dart';

import 'ePage.dart';

class WeatherDetailsPage extends ePage {
  final int index;
  WeatherDetailsPage(this.index) : super(null, '');

  @override
  Widget build(BuildContext context) {
    return const WeatherDetailsBody();
  }
}

class WeatherDetailsBody extends StatefulWidget {
  const WeatherDetailsBody();

  @override
  State<StatefulWidget> createState() => WeatherDetailsBodyState();
}

class WeatherDetailsBodyState extends State<WeatherDetailsBody> {
  WeatherDetailsBodyState();
  String bgimg;

  @override
  void initState() {
    super.initState();
    //fetchLocation(_weatherLocation);
  }

  @override
  Widget build(BuildContext context) {
    bgimg = 'assets/bg/thaibinh.jpg';
    final int index = 2;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              bgimg,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black54),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
                alignment: Alignment.topCenter,
                //height: closeTopContainer? 0 : double.infinity,
                child: SingleDetails(index),
            ),
          ],
        ),
      ),
    );
  }
}
