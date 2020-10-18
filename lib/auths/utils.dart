import 'dart:convert';
import 'package:device_info/device_info.dart';

String name;
String shopName;
String phone;
String email;
String password;
String address;

int stateID;
int errorCode;


String myActivitiesResult = '';

String accessToken = '';
getToken() {
  return 'Bearer $accessToken';
}

String getPrettyJSONString(Object jsonObject) {
  return const JsonEncoder.withIndent('  ').convert(jsonObject);
}

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Future<String> getDeviceId() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
    // print('Running on ${androidInfo.id}');
    // print('Running on ${androidInfo.model}');
  }
