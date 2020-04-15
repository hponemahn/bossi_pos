import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final int catId;
  final String desc;
  final double price;
  final int qty;
  final double buyPrice;
  final double discountPrice;
  final String sku;
  final String barcode;
  final bool isDamage;

  Product({@required this.id, @required this.name, @required this.catId, this.desc, @required this.price, @required this.qty, @required this.buyPrice, this.discountPrice, @required this.sku, this.barcode, this.isDamage});
}