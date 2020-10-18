import 'dart:convert';

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
