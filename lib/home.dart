//import 'package:flutter/material.dart';
import 'package:iot_friday/car.dart';
import 'package:iot_friday/hum.dart';
import 'package:iot_friday/mqtt.dart';
import 'package:iot_friday/tem.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
//import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

var carNumI = "";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: const Color(0xff4A4A4A),

        onRefresh: () async {
          setState(() {
            nowHum = subHum;
            nowTem = subTem;
            nowCarLoc = subCarLoc;
            carNum = carNum;

            if (subCarState == "1"){
              carState = carState_book;
            }
            else if (subCarState == "2"){
              carState = carState_safe;
            }
            else if (subCarState == "3"){
              carState = carState_bye;
              nowCarLoc = " ";
            }
          });
          return Future<void>.delayed(const Duration(seconds: 1));
        },

        notificationPredicate: (ScrollNotification notification) {
          return notification.depth == 1;
        },

        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              top :60.0,
              left: 20.0,
              right: 20.0,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          style : TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                            fontSize: 50,
                          ),
                          "Parasol",
                        ),

                      ],
                    ),
                    const Text(
                      style : TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color(0xff000000),
                        fontSize: 15,
                      ),
                      "반갑습니다. 우산 대여 어플 파라솔 입니다.",
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                      ),
                      child: const Divider(
                          thickness: 1, height: 1, color:Colors.black12
                      ),
                    ),
                    CarInfo(),

                    const SizedBox(
                      height: 20,
                    ),

                    TemInfo(),

                    const SizedBox(
                      height: 20,
                    ),

                    HumInfo(),


                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      "Team Friday.",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        color: Color(0xFFCACACA),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 300,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





class ModalInsideModal extends StatelessWidget {

  final bool reverse;
  ModalInsideModal({Key? key, this.reverse = false}) : super(key: key);
  final TextEditingController carNumC = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Material(
          child: CupertinoPageScaffold(
            child: Scaffold(
              backgroundColor: const Color(0xFFFFFFFF),
              body: Center(
                  child:
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 50,
                        ),
                        child: Text(
                          textAlign: TextAlign.left,
                          "차량 설정",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w900,
                            fontFamily: "apple",
                            fontSize: 35,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text(
                          textAlign: TextAlign.left,
                          "차량 번호를 입력하세요.",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "apple",
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffF2F2F6),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CupertinoTextField.borderless(
                                onChanged: (text){
                                  carNumI = text;
                                },
                                //controller: carNum_c,
                                padding: const EdgeInsets.only(
                                    left: 65,
                                    top: 10,
                                    right: 7,
                                    bottom: 10
                                ),
                                prefix: const Padding(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: Text(
                                    'Car Number',
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "apple",
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                placeholder: 'Required',
                              ),
                            ],
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25.0,
                              right: 25.0,
                            ),
                            child: CupertinoButton(
                              onPressed: () {
                                carNum = carNumI;
                                carStateTopic = stateTopic+carNum;
                                carLocTopic = locTopic+carNum;
                                subCarState = "3";
                                Navigator.pop(context);
                              },
                              //padding: EdgeInsets.all(5),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                              child: const Text(
                                "확인",
                                style: TextStyle(
                                  fontFamily: "apple",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              ),
            ),
          )
      ),
    );
  }
}
