import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wemapgl_example/time_details.dart';

class WeatherLocation {
  String city;
  String dateTime, dt, dt_1d, dt_2d;
  String temperature;
  String weatherType;
  String description = 'clear sky';
  String iconUrl;
  var wind, rain;
  int humidity;
  var lat, lon;
  String feel_like, temp_min, temp_max;
  int pressure, visibility, wind_deg;
  String sunrise, sunset;
  var dew_point, uvi;
  String temp_min_1d, temp_max_1d, description_1d;
  String temp_min_2d, temp_max_2d, description_2d;
  String bgimg;
  List<TimeDetails> timeDetails = [];

  WeatherLocation({
    @required this.city,
    @required this.dateTime,
    @required this.temperature,
    @required this.weatherType,
    @required this.iconUrl,
    @required this.wind,
    @required this.rain,
    @required this.humidity,
  });
}

final locationList = [
  WeatherLocation(
    city: 'Thai Binh',
    dateTime: '10:42:38 - Sunday, 16 May 2021',
    temperature: '30.3\u2103',
    weatherType: 'Clouds',
    iconUrl: 'assets/moon.svg',
    wind: 3.6,
    rain: 50,
    humidity: 84,
  ),
  WeatherLocation(
      city: 'Hanoi',
      dateTime: '10:31:21 - Sunday, 16 May 2021',
      temperature: '31\u2103',
      weatherType: 'Night',
      iconUrl: 'assets/moon.svg',
      wind: 34, rain: 43,
      humidity: 89,
  ),
  WeatherLocation(
    city: 'London',
    dateTime: '02:20 PM — Monday, 9 Nov 2020',
    temperature: '15\u2103',
    weatherType: 'Cloudy',
    iconUrl: 'assets/cloudy.svg',
    wind: 4,
    rain: 7,
    humidity: 82,
  ),
  WeatherLocation(
    city: 'Saigon',
    dateTime: '09:20 AM — Monday, 9 Nov 2020',
    temperature: '17\u2103',
    weatherType: 'Sunny',
    iconUrl: 'assets/sun.svg',
    wind: 5,
    rain: 15,
    humidity: 61,
  ),
  // WeatherLocation(
  //   city: 'Sydney',
  //   dateTime: '01:20 AM — Tuesday, 10 Nov 2020',
  //   temperature: '10\u2103',
  //   weatherType: 'Rainy',
  //   iconUrl: 'assets/rain.svg',
  //   wind: 4.5,
  //   rain: 70,
  //   humidity: 91,
  // ),
];