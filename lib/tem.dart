import 'package:flutter/material.dart';

import 'mqtt.dart';

class TemInfo extends StatefulWidget {
  const TemInfo({Key? key}) : super(key: key);

  @override
  State<TemInfo> createState() => _TemInfoState();
}

class _TemInfoState extends State<TemInfo> {
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
                  Icons.thermostat,
                  color: Color(0xffEF961d),
                  size: 19,
                ),
                Text(
                  " 바깥 온도",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xffEF961d),
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
                  textAlign: TextAlign.left,
                  nowTem,
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
                    " °C",
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
