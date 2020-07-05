
import 'dart:convert';

String name = '';
String email = '';
String accessToken = '';

String pro_id = '';
String pro_name = '';
String pro_catgory = '';
double pro_price;
int pro_qty;
double pro_buyprice;
String pro_sku ='';
String pro_desc = '';
double pro_discountPrice;
String pro_barcode = '';
bool pro_isDamage;

getToken() {
  return 'Bearer $accessToken';
}

String getPrettyJSONString(Object jsonObject) {
  return const JsonEncoder.withIndent('  ').convert(jsonObject);
}

