import 'dart:convert';

String name;
String shopName;
String phone;
String email;
String password;
String address;

int stateID ;

String myActivitiesResult = '';



String getPrettyJSONString(Object jsonObject) {
  return const JsonEncoder.withIndent('  ').convert(jsonObject);
}
