
import 'dart:convert';

String name = '';
String email = '';
String accessToken = '';

getToken() {
  return 'Bearer $accessToken';
}

String getPrettyJSONString(Object jsonObject) {
  return const JsonEncoder.withIndent('  ').convert(jsonObject);
}

