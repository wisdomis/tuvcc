import 'package:flutter/material.dart';
import 'package:iot_friday/mqtt.dart';

import 'package:flutter/services.dart';
import 'home.dart';
import 'map.dart';
import 'dart:math';


String rand_num = "0";

void main(){
  rand_num = (Random().nextInt(50) + 1).toString();

  mqttInit();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Apple SD Gothic Neo',
      ),
      home: const ParkingHome(),
    );
  }
}

class ParkingHome extends StatefulWidget {
  const ParkingHome({Key? key}) : super(key: key);

  @override
  State<ParkingHome> createState() => _ParkingHomeState();
}

class _ParkingHomeState extends State<ParkingHome> {
  int _selectedIndex = 0;

  final List _widgetOptions = [
    const Home(),
    const Map(),
  ];


  @override

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      body: Center(
        child: _widgetOptions[_selectedIndex], // 페이지와 연결
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.umbrella),
            label: 'info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff000000),
        onTap: _onItemTapped,
      ),
    );
  }
}
