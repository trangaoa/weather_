import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wemapgl/wemapgl.dart';
import 'package:wemapgl_example/weather_api.dart';
import 'package:wemapgl_example/weather_location.dart';
import 'ePage.dart';
import 'package:http/http.dart' as http;

class FullMapPage extends ePage {
  FullMapPage() : super(const Icon(Icons.map), 'Full screen map');

  @override
  Widget build(BuildContext context) {
    return const FullMap();
  }
}

class FullMap extends StatefulWidget {
  const FullMap();

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  WeMapController mapController;
  int searchType = 1; //Type of search bar
  String searchInfoPlace = "Tìm kiếm ở đây"; //Hint text for InfoBar
  String searchPlaceName;
  LatLng myLatLng = LatLng(21.038282, 105.782885);
  bool reverse = true;
  WeMapPlace place;
  void _onMapCreated(WeMapController controller) {
    mapController = controller;
  }

  void setPlaceState(WeatherLocation weatherLocation, var placeJSON) async{
    var geometry = placeJSON['geometry'];
    var properties = placeJSON['properties'];

    List<dynamic> coord = geometry['coordinates'];
    var lat = coord[1];
    var lon = coord[0];
    String searchApiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=cf6752c51d18cdd4ebabe52da8d74aea";
    print(searchApiUrl);

    weatherLocation.lat = lat;
    weatherLocation.lon = lon;
    weatherLocation.city = properties['region'];

    var searchResult = await http.get(searchApiUrl);

    setWeatherState(weatherLocation, searchResult);
  }

  void setWeatherState(WeatherLocation weatherLocation, var searchResult){
    Map<String, dynamic> result = jsonDecode(searchResult.body);
    print(result.toString());

    var main = result['main'];
    List<dynamic> weather = result['weather'];
    print(weather.toString());

    var wind = result['wind'];

    var unix_timestamp_VN = result['dt'] - 25200 + result['timezone'];
    String formattedDay = formatDay(unix_timestamp_VN);

    var temperature = main['temp']/10;

    var coord = result['coord'];
    var feel_like = main['feels_like']/10;
    var temp_min = main['temp_min']/10;
    var temp_max = main['temp_max']/10;
    var sys = result['sys'];
    var sunrise = sys['sunrise'] - 25200 + result['timezone'];
    var sunset = sys['sunset'] - 25200 + result['timezone'];

    weatherLocation.lat = coord['lat'];
    weatherLocation.lon = coord['lon'];
    weatherLocation.feel_like = feel_like.toStringAsFixed(1) + '\u2103';
    weatherLocation.temp_min = temp_min.toStringAsFixed(1) + '\u2103';
    weatherLocation.temp_max = temp_max.toStringAsFixed(1) + '\u2103';
    weatherLocation.pressure = main['pressure'];
    weatherLocation.visibility = result['visibility'];
    weatherLocation.wind_deg = wind['deg'];
    weatherLocation.sunrise = formatTime(sunrise);
    weatherLocation.sunset = formatTime(sunset);

    weatherLocation.city = result['name'];
    weatherLocation.dateTime = formattedDay.toString();
    weatherLocation.temperature = temperature.toStringAsFixed(1) + '\u2103';
    weatherLocation.weatherType = weather[0]['main'].toString();
    weatherLocation.iconUrl = 'assets/${weatherLocation.weatherType}.svg';
    weatherLocation.wind = wind['speed'];
    if (weatherLocation.weatherType == 'Rain') {
      var rain = result['rain'];
      weatherLocation.rain = rain['1h'];
    } else if (weatherLocation.weatherType == 'Clouds'){
      var clouds = result['clouds'];
      weatherLocation.rain = clouds['all'];
    } else if (weatherLocation.weatherType == 'Clear') {
      weatherLocation.rain = 90;
    }
    weatherLocation.humidity = main['humidity'];
    print(weatherLocation.city + '\n' + weatherLocation.dateTime + '\n' + weatherLocation.temperature
        + '\n' + weatherLocation.weatherType + '\n' + weatherLocation.wind.toString()
        + '\n' + weatherLocation.rain.toString() + '\n' + weatherLocation.humidity.toString());
  }

  String formatDay(unix_timestamp){
    var date = new DateTime.fromMillisecondsSinceEpoch(unix_timestamp*1000);
    var hours = "0" + date.hour.toString();
    var minutes = "0" + date.minute.toString();
    var seconds = "0" + date.second.toString();
    var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    var weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    var year = date.year;
    var month = months[date.month - 1];
    var day = date.day;
    var weekday = weekDays[date.weekday - 1];

    // Will display time in 10:30:23 format
    var formattedDay = hours.substring(hours.length - 2) + ':' + minutes.substring(minutes.length - 2) + ':' + seconds.substring(seconds.length - 2)
        + ' — ' + weekday.toString() + ', ' + day.toString() + ' ' + month.toString() + ' ' + year.toString();

    return formattedDay;
  }

  String formatDate(unix_timestamp){
    var date = new DateTime.fromMillisecondsSinceEpoch(unix_timestamp*1000);
    var day = '0' + date.day.toString();
    var month = '0' + date.month.toString();

    var formattedDate = day.substring(day.length - 2) + '/' + month.substring(month.length - 2);
    return formattedDate;
  }

  String formatTime(unix_timestamp){
    var date = new DateTime.fromMillisecondsSinceEpoch(unix_timestamp*1000);
    var hours = "0" + date.hour.toString();
    var minutes = "0" + date.minute.toString();
    var seconds = "0" + date.second.toString();

    var formattedTime = hours.substring(hours.length - 2) + ':' + minutes.substring(minutes.length - 2)
        + ':' + seconds.substring(seconds.length - 2);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          WeMap(
            onMapClick: (point, latlng, _place) async {
              WeatherLocation weatherLocation = WeatherLocation();
              place = _place;
              var placeJSON = place.fullJSON;

              print(placeJSON);

              setPlaceState(weatherLocation, placeJSON);

              //Future<void> onMapClick()=>
              Future.delayed(const Duration(seconds: 2), (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      WeatherApi(weatherLocation)),
                );
                print('success');
              });
            },
            onPlaceCardClose: () {
              // print("Place Card closed");
            },
            reverse: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.036029, 105.782950),
              zoom: 16.0,
            ),
            destinationIcon: "assets/symbols/destination.png",
          ),
          WeMapSearchBar(
            location: myLatLng,
            onSelected: (_place) {
              setState(() {
                place = _place;
              });
              mapController.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: place.location,
                    zoom: 14.0,
                  ),
                ),
              );
              mapController.showPlaceCard(place);
            },
            onClearInput: () {
              setState(() {
                place = null;
                mapController.showPlaceCard(place);
              });
            },
          ),
        ],
      ),
    );
  }
}
