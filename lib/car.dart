import 'package:flutter/material.dart';
import 'package:iot_friday/mqtt.dart';


const carState_safe = "안전하게 주차되어 있습니다.";
const carState_book = "예약 중입니다.";
const carState_bye = "안녕하세요";
var carState = "";

class CarInfo extends StatefulWidget {
  const CarInfo({Key? key}) : super(key: key);

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE9E9E9),
          ),
          color: const Color(0xFFFFFFFF),
          shape: BoxShape.rectangle,
          borderRadius:  BorderRadius.circular(7.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.umbrella,
                    color: Color(0xffFF5B24),
                    size: 19,
                  ),
                  Text(
                    " 날씨",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xffFF5B24),
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                //bottom: 12,
                left: 10,
                right: 10,
              ),
              child:Text(
                textAlign: TextAlign.left,
                carNum,
                style: const TextStyle(
                  //fontWeight: FontWeight.w500,
                  color: Color(0xff959595),
                  fontSize: 19,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 10,
                right: 10,
              ),
              child:Text(
                carState,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff4A4A4A),
                  fontSize: 16,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                //bottom: 12,
                left: 10,
                right: 10,
              ),
              child:Text(
                textAlign: TextAlign.left,
                nowCarLoc,
                style: const TextStyle(
                  //fontWeight: FontWeight.w500,
                  fontFamily: "unr",
                  color: Color(0xff000000),
                  fontSize: 35,
                ),
              ),
            ),
          ],
        )
    );
  }
}
