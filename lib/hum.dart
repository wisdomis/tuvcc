import 'package:flutter/material.dart';
import 'package:iot_friday/mqtt.dart';

class HumInfo extends StatefulWidget {
  const HumInfo({Key? key}) : super(key: key);

  @override
  State<HumInfo> createState() => _HumInfoState();
}

class _HumInfoState extends State<HumInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      //height: 360.0,
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
                  Icons.water,
                  color: Color(0xff3378F6),
                  size: 19,
                ),
                Text(
                  " 바깥 습도",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xff3378F6),
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              //bottom: 12,
              left: 10,
              right: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  nowHum,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    //fontWeight: FontWeight.w700,
                    fontFamily: "unr",
                    color: Color(0xff000000),
                    fontSize: 35,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                    left: 3,
                  ),
                  child: Text(
                    " %",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "apple",
                      color: Color(0xff959595),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
