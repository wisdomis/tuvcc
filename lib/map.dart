import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'mqtt.dart';
import 'package:flutter/services.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);


  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {

  void _showAlert({required String title, required String message}) {
    showCupertinoDialog(context: context, builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("확인"),
              onPressed: () {
            Navigator.pop(context);
          })
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body:  RefreshIndicator(
          backgroundColor: Colors.white,
          color: const Color(0xff4A4A4A),

          onRefresh: () async {
            setState(() {
              if(subLotState_1 == "FULL"){
                lotColor_1 = colorFull;
              }
              else if(subLotState_1 == "empty"){
                lotColor_1 = colorEmpty;
              }

              if(subLotState_2 == "FULL"){
                lotColor_2 = colorFull;
              }
              else if(subLotState_2 == "empty"){
                lotColor_2 = colorEmpty;
              }
              lotState_1 = subLotState_1;
              lotState_2 = subLotState_2;
            });
            return Future<void>.delayed(const Duration(seconds: 1));
          },

          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },

          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                top: 60,
                left: 20,
                right: 20,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Text(
                            '우산 대여',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                              fontSize: 40,
                              fontFamily: "apple",
                            ),
                          ),
                        ),
                        const Text(
                          style : TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Color(0xff000000),
                            fontSize: 15,
                          ),
                          "원하는 우산을 눌러 대여할 수 있습니다.",
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(lotColor_1),
                                      minimumSize: const Size(170, 200),	//width, height
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "apple",
                                        fontSize: 18,
                                      )
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (lotState_1 == "FULL"){
                                        _showAlert(title: "예약 실패", message: "이미 사용 중입니다.\n다른 우산을 이용해 주세요");
                                      }
                                      else if (lotState_1 == "empty"){
                                        _showAlert(title: "대여 성공", message: "우산을 가져가주세요.");
                                        mqttPub("/test", "R1_off");
                                      }
                                      else{
                                        _showAlert(title: "에러", message: "오류 발생");
                                      }
                                    });
                                  },
                                  child:
                                  const Text(
                                    '장우산',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "apple",
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(lotColor_2),
                                      minimumSize: const Size(170, 200),	//width, height
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "apple",
                                        fontSize: 18,
                                      )
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (lotState_1 == "FULL"){
                                        _showAlert(title: "예약 실패", message: "이미 사용 중입니다.\n다른 우산을 이용해 주세요");
                                      }
                                      else if (lotState_1 == "empty"){
                                        _showAlert(title: "대여 성공", message: "우산을 가져가주세요.");
                                        mqttPub("/test", "R2_off");
                                      }
                                      else{
                                        _showAlert(title: "에러", message: "오류 발생");
                                      }
                                    });
                                  },
                                  child:
                                  const Text(
                                    '3단우산',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "apple",
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 500,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


