import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemapgl_example/time_details.dart';

// ignore: must_be_immutable
class SingleTime extends StatelessWidget {
  //final int index;
  TimeDetails timeDetails = TimeDetails();
  SingleTime(this.timeDetails);

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Colors.white12,
      border: Border.all(
        width: 1.0,
        color: Colors.white30,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(10.0) //                 <--- border radius here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 60,
        //color: Colors.green,
        decoration: myBoxDecoration(),
        //padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Text(
                        '${timeDetails.temperature}',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5,),
                      SvgPicture.asset(
                        '${timeDetails.icon}',
                        width: 30,
                        height: 30,
                        color: timeDetails.color,
                      ),
                      SizedBox(height: 5,),
                      Text(
                          '${timeDetails.time}',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ],
                  ),
              ])
            )
          ],
        ),
      );
  }
}
