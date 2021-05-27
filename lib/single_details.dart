import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemapgl_example/single_time.dart';
import 'weather_location.dart';

class SingleDetails extends StatelessWidget {
  final int index;
  SingleDetails(this.index);

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Colors.white12,
      border: Border.all(
        width: 1.0,
        color: Colors.white30,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(10.0), //                 <--- border radius here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WeatherLocation weatherLocation = locationList[index];

    String bgimg = 'assets/bg/hanoi.jpg';
    var city = weatherLocation.city.toLowerCase().replaceAll(' ', '');
    bgimg = 'assets/bg/$city.jpg';

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
                duration: Duration(milliseconds: 200),
                child: SingleChildScrollView(
                  child: Container(
                    height: 1170,
                    padding: EdgeInsets.all(20),
                    child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 40,),
                                Center(
                                  child: Text(
                                    '${weatherLocation.city}',
                                    style: GoogleFonts.lato(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(height: 180,),
                                Text(
                                  '${weatherLocation.temperature}',
                                  style: GoogleFonts.lato(
                                    fontSize: 85,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      '${weatherLocation.iconUrl}',
                                      width: 34,
                                      height: 34,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10,),
                                    Text('${weatherLocation.description}', style: GoogleFonts.lato(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: weatherLocation.timeDetails.length,
                          itemBuilder: (context, i) => SingleTime(weatherLocation.timeDetails[i]),
                        ),
                      ),
                      //SizedBox(height: 30,),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: myBoxDecoration(),
                        //width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '${weatherLocation.dt}',
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  '${weatherLocation.dt_1d}',
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  '${weatherLocation.dt_2d}',
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            //SizedBox(width: 20,),
                            Column(
                              children: [
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '${weatherLocation.description}',
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      '${weatherLocation.description_1d}',
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      '${weatherLocation.description_2d}',
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            //SizedBox(width: 30,),
                            Column(
                              children: [
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '${weatherLocation.temp_min}/${weatherLocation.temp_max}',
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      '${weatherLocation.temp_min_1d}/${weatherLocation.temp_max_1d}',
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      '${weatherLocation.temp_max_2d}/${weatherLocation.temp_max_2d}',
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //SizedBox(height: 30,),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          Container(
                            //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: myBoxDecoration(),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Sunrise',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.sunrise}',
                                            style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Column(
                                      children: [
                                        Text(
                                          'Wind',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.wind.toStringAsFixed(2)} km/h',
                                            style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      children: [
                                        Text(
                                          'Feel like',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                            '${(weatherLocation.feel_like)}',
                                            style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      children: [
                                        Text(
                                          'Dew Point',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.dew_point}',
                                            style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Sunset',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.sunset}',
                                            style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Column(
                                      children: [
                                        Text(
                                          'Humidity',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.humidity.toString()} %',
                                            style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      children: [
                                        Text(
                                          'Pressure',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.pressure.toString()} mbar',
                                            style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      children: [
                                        Text(
                                          'UV',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.uvi.toString()}',
                                            style: GoogleFonts.lato(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),),
            )
          ]
        ),
      )
    );
  }
}