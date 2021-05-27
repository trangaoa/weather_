import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:http/http.dart' as http;
import 'package:wemapgl_example/single_details.dart';
import 'package:wemapgl_example/time_details.dart';
import 'constants.dart';
import 'full_map.dart';
import 'single_weather.dart';
import 'weather_location.dart';
import 'slider_dot.dart';
import 'building_transformer.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
  String bgimg;
  WeatherLocation _weatherLocation = WeatherLocation();

  @override
  void initState() {
    super.initState();
    fetchLocation(_weatherLocation);
  }

  void fetchSearch(WeatherLocation weatherLocation) async {
    String lat = weatherLocation.lat.toStringAsFixed(4);
    String lon = weatherLocation.lon.toStringAsFixed(4);
    String searchApiUrl = "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=cf6752c51d18cdd4ebabe52da8d74aea";

    print(searchApiUrl);

    var searchResult = await http.get(searchApiUrl);

    setSearchState(weatherLocation, searchResult);
  }

  void setSearchState(WeatherLocation weatherLocation, var searchResult){
    Map<String, dynamic> result = jsonDecode(searchResult.body);
    //print(result.toString());

    List<dynamic> resultHourly = result['hourly'];

    for (int i = 0; i < 24; i++) {
      List<dynamic> timeWeather = resultHourly[i + 1]['weather'];
      var timeMain = timeWeather[0]['main'].toString();
      TimeDetails timer = TimeDetails(
        time: formatTime(resultHourly[i + 1]['dt']),
        icon: 'assets/$timeMain.svg',
        temperature: (resultHourly[i + 1]['temp']/10).toStringAsFixed(1) + '\u2103',
      );
      weatherLocation.timeDetails.add(timer);
    }

    var time = - 25200 + result['timezone_offset'];
    var resultCurrent = result['current'];

    List<dynamic> resultDaily = result['daily'];
    var current = resultDaily[0];
    var result_1d = resultDaily[1];
    var result_2d = resultDaily[2];

    var temp = current['temp'];
    var temp_1d = result_1d['temp'];
    var temp_2d = result_2d['temp'];

    weatherLocation.temp_min = (temp['min']/10).toStringAsFixed(1) + '\u2103';
    weatherLocation.temp_max = (temp['max']/10).toStringAsFixed(1) + '\u2103';

    List<dynamic> weather_1d = resultCurrent['weather'];
    weatherLocation.description_1d = weather_1d[0]['description'];
    weatherLocation.temp_min_1d = (temp_1d['min']/10).toStringAsFixed(1) + '\u2103';
    weatherLocation.temp_max_1d = (temp_1d['max']/10).toStringAsFixed(1) + '\u2103';
    weatherLocation.dt_1d = formatDate(result_1d['dt'] + time).toString();

    List<dynamic> weather_2d = resultCurrent['weather'];
    weatherLocation.description_2d = weather_2d[0]['description'];
    weatherLocation.temp_min_2d = (temp_2d['min']/10).toStringAsFixed(1) + '\u2103';
    weatherLocation.temp_max_2d = (temp_2d['max']/10).toStringAsFixed(1) + '\u2103';
    weatherLocation.dt_2d = formatDate(result_2d['dt'] + time).toString();

    var unixTimestampVN = resultCurrent['dt'] + time;
    String formattedDay = formatDay(unixTimestampVN);

    var feelLike = resultCurrent['feels_like']/10;

    var sunrise = resultCurrent['sunrise'] + time;
    var sunset = resultCurrent['sunset'] + time;
    weatherLocation.feel_like = feelLike.toStringAsFixed(1) + '\u2103';
    weatherLocation.pressure = resultCurrent['pressure'];
    weatherLocation.visibility = resultCurrent['visibility'];
    weatherLocation.wind_deg = resultCurrent['wind_deg'];
    weatherLocation.sunrise = formatTime(sunrise);
    weatherLocation.sunset = formatTime(sunset);
    weatherLocation.dew_point = resultCurrent['dew_point'];
    weatherLocation.uvi = resultCurrent['uvi'];

    weatherLocation.dt = formatDate(resultCurrent['dt']);
    weatherLocation.dateTime = formattedDay.toString();
  }

  void fetchLocation(WeatherLocation weatherLocation) async{
    for (var i = 0; i < locationList.length; i++){
      weatherLocation = locationList[i];

      var city = locationList[i].city;
      String searchApiUrl = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=cf6752c51d18cdd4ebabe52da8d74aea";

      //print(searchApiUrl);

      var searchResult = await http.get(searchApiUrl);
      setWeatherState(weatherLocation, searchResult);
      fetchSearch(weatherLocation);
    }
  }

  void setWeatherState(WeatherLocation weatherLocation, var searchResult){
    Map<String, dynamic> result = jsonDecode(searchResult.body);
    print(result.toString());

    var main = result['main'];
    List<dynamic> weather = result['weather'];
    //print(weather.toString());

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
    weatherLocation.description = weather[0]['description'];
    weatherLocation.iconUrl = 'assets/${weatherLocation.weatherType}.svg';
    weatherLocation.wind = wind['speed'] * 3.6;

    if (weatherLocation.weatherType == 'Rain') {
      var rain = result['rain'];
      weatherLocation.rain = rain['1h'];
    } else if (weatherLocation.weatherType == 'Clouds'){
      var clouds = result['clouds'];
      weatherLocation.rain = clouds['all'];
    } else if (weatherLocation.weatherType == 'Clear') {
      weatherLocation.rain = 20;
    }

    //print(weatherLocation.rain);

    weatherLocation.humidity = main['humidity'];
    // print(weatherLocation.city + '\n' + weatherLocation.dateTime + '\n' + weatherLocation.temperature
    //     + '\n' + weatherLocation.weatherType + '\n' + weatherLocation.wind.toString()
    //     + '\n' + weatherLocation.rain.toString() + '\n' + weatherLocation.humidity.toString());
  }

  String formatDay(unixTimestamp){
    var date = new DateTime.fromMillisecondsSinceEpoch(unixTimestamp*1000);
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

  String formatTime(unixTimestamp){
    var date = new DateTime.fromMillisecondsSinceEpoch(unixTimestamp*1000);
    var hours = "0" + date.hour.toString();
    var minutes = "0" + date.minute.toString();
    //var seconds = "0" + date.second.toString();

    var formattedTime = hours.substring(hours.length - 2) + ':' + minutes.substring(minutes.length - 2);
        //+ ':' + seconds.substring(seconds.length - 2);

    return formattedTime;
  }

  String formatDate(unixTimestamp){
    var date = new DateTime.fromMillisecondsSinceEpoch(unixTimestamp*1000);
    var day = '0' + date.day.toString();
    var month = '0' + date.month.toString();

    var formattedDate = day.substring(day.length - 2) + '/' + month.substring(month.length - 2);
    return formattedDate;
  }

_onPageChanged(int index){
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var description = locationList[_currentPage].description.toString().replaceAll(' ', '');
    bgimg = 'assets/$description.jpeg';

    void choiceAction(String choice){
      if (choice == Constants.details){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SingleDetails(_currentPage)),
        );
        print('Get details of ${locationList[_currentPage].city}');
      } else if (choice == Constants.delete){
        print('Delete ${locationList[_currentPage].city} from location list');
        locationList.removeAt(_currentPage);
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FullMapPage()),
            );
            print("Search clicked!");
          },
          icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
          ),
        ),

        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: PopupMenuButton(
                elevation: 3.2,
                initialValue: Constants.choices[0],
                onSelected: choiceAction,
                // ignore: missing_return
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem <String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
            ),
          //)
        ],
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
             decoration: BoxDecoration(color: Colors.black38),
           ),
            Container(
              margin: EdgeInsets.only(top: 140, left: 15),
              child: Row(
                children: [
                  for (int i = 0; i < locationList.length; i++)
                    if (i == _currentPage)
                      SliderDot(true)
                    else
                      SliderDot(false)
                ],
              ),
            ),
            TransformerPageView(
              scrollDirection: Axis.horizontal,
              transformer: ScaleAndFadeTransformer(),
              viewportFraction: 0.8,
              onPageChanged: _onPageChanged,
              itemCount: locationList.length,
              itemBuilder: (ctx, i) => SingleWeather(locationList[i]),
            ),
          ],
        ),
      ),
    );
  }
}
