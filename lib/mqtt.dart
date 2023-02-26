import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

const server = "192.168.219.111";
//const server = "mqtt.d0y00n.space";

String randNum = "0";

final client = MqttServerClient(server,"friday$randNum");

const pubTopic = 'Dart/Mqtt_client/get';
const subTopic = 'friday/#';

const stateTopic = "friday/state/";
const locTopic = "friday/loc/";

String carStateTopic = "friday/state/";
String carLocTopic = "friday/loc/";

const lotTopic_1 = "friday/lot/1";
const lotTopic_2 = "friday/lot/2";

const subTopicTem = "friday/sensor/evt/tem";
const subTopicHum = "friday/sensor/evt/hum";

String stateReturn = "";
var carNum = "";

var subLotState_1 = "";
var subLotState_2 = "";

var lotState_1 = "";
var lotState_2 = "";

var lotColor_1 = 0xff4A4A4A;
var lotColor_2 = 0xff4A4A4A;

const colorFull = 0xffFA5647;
const colorEmpty = 0xff47BD11;
const colorBook = 0xffFFB41C;



final builder = MqttClientPayloadBuilder();

String subHum = "NaN";
String subTem = "NaN";
String subCarLoc = "";
String subCarState = "not Found";

String nowHum = "NaN";
String nowTem = "NaN";
String nowCarLoc = "not Found";



void mqttPub(dynamic topic, String str){
  builder.clear();
  builder.addString(str);
  client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
}


String mqttInit(){

  client.logging(on: false);
  client.setProtocolV311();
  client.keepAlivePeriod = 10;
  client.connectTimeoutPeriod = 2000; // milliseconds
  client.onDisconnected = onDisconnected;
  client.onConnected = onConnected;
  client.onSubscribed = onSubscribed;

  client.connect();

  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    onConnected();
  } else {
    if (kDebugMode) {
      print('EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
    }
    client.disconnect();
    stateReturn = "Error";
  }
  return stateReturn;
}

void onDisconnected() {
  if (kDebugMode) {
    print(':Mosquitto client disconnected, retry');
  }
  stateReturn = "Error";
  client.connect();
}

void onConnected() {
  if (kDebugMode) {
    print(':Mosquitto client connected');
  }

  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    if (kDebugMode) {
      print('EXAMPLE::Mosquitto client connected');
    }
    stateReturn = "Connected";
  }
  client.subscribe(subTopic, MqttQos.atMostOnce);
  client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
    final recMess = c![0].payload as MqttPublishMessage;
    final String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    if (kDebugMode) {
      print("${c[0].topic} $pt ");
    }

    if (c[0].topic == subTopicTem){
      subTem = pt;
    }
    else if (c[0].topic == subTopicHum){
      subHum = pt;
    }
    else if (c[0].topic == carStateTopic){
      subCarState = pt;
    }
    else if (c[0].topic == carLocTopic){
      subCarLoc = pt;
    }
    else if (c[0].topic == lotTopic_1){
      subLotState_1 = pt;
    }
    else if (c[0].topic == lotTopic_2){
      subLotState_2 = pt;
    }
  });
}


void onSubscribed(String topic) {
  mqttPub("friday/app/$randNum", "Connected");
}