import 'package:bossi_pos/providers/product.dart';
import 'package:flutter/foundation.dart';

class Products with ChangeNotifier {
  List<Product> _products = [
    Product(id: "i1", name: "အာလူး", desc: "", price: 500.00),
    Product(id: "i2", name: "ကြက်သွန်နီ", desc: "", price: 700.00),
    Product(id: "i3", name: "ဆန်", desc: "", price: 1500.00),
    Product(id: "i4", name: "ဆီ", desc: "", price: 3500.00),
    Product(id: "i5", name: "apple", desc: "", price: 500.00),
    Product(id: "i6", name: "orange", desc: "", price: 700.00),
    Product(id: "i7", name: "iphone", desc: "", price: 1500.00),
    Product(id: "i8", name: "macbook", desc: "", price: 3500.00),
  ];

  List<Product> get products {
    return [..._products];
  }
}
