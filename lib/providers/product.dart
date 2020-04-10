import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final String desc;
  final double price;

  Product({@required this.id, @required this.name, this.desc, @required this.price});
}