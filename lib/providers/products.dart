import 'package:bossi_pos/providers/product.dart';
import 'package:flutter/foundation.dart';

class Products with ChangeNotifier {
  List<Product> _products = [
    Product(id: "i1", name: "အာလူး", desc: "", price: 500.00, qty: 50, buyPrice: 400, sku: "1a", catId: 1),
    Product(id: "i2", name: "ကြက်သွန်နီ", desc: "", price: 700.00, qty: 50, buyPrice: 400, sku: "1a", catId: 1),
    Product(id: "i3", name: "ဆန်", desc: "", price: 1500.00, qty: 50, buyPrice: 400, sku: "1a", catId: 1),
    Product(id: "i4", name: "ဆီ", desc: "", price: 3500.00, qty: 50, buyPrice: 400, sku: "1a", catId: 1),
    Product(id: "i5", name: "apple", desc: "", price: 500.00, qty: 50, buyPrice: 400, sku: "1a", catId: 1),
    Product(id: "i6", name: "orange", desc: "", price: 700.00, qty: 50, buyPrice: 400, sku: "1a", catId: 1),
    Product(id: "i7", name: "iphone", desc: "", price: 1500.00, qty: 50, buyPrice: 400, sku: "1a", catId: 1),
    Product(id: "i8", name: "macbook", desc: "", price: 3500.00, qty: 50, buyPrice: 400, sku: "1a", catId: 1),
  ];

  List<Product> get products {
    return [..._products];
  }

  void add (Product _pr) {
    var product = Product(id: DateTime.now().toString(), name: _pr.name, catId: _pr.catId, price: _pr.price, qty: _pr.qty, buyPrice: _pr.buyPrice, sku: _pr.sku, desc: _pr.desc, barcode: _pr.barcode, discountPrice: _pr.discountPrice, isDamage: _pr.isDamage);
    _products.add(product);
    notifyListeners();
  }

  void delete (String id) {
    _products.removeWhere((pr) => pr.id == id);
    notifyListeners();
  }

  Product findById (String id) {
    return _products.firstWhere((pr) => pr.id == id);
  }

  void edit (Product _pr) {
    print("update id ${_pr.id}");
    int index = _products.indexWhere((pr) => pr.id == _pr.id);
    print("update ${_pr.name}");
    if (index >= 0) {
      _products[index] = _pr;
      notifyListeners();   
    } else {
      print("...");
    }
  }
}
