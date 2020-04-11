import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final int qty;
  final double price;

  CartItem({@required this.id, @required this.name, @required this.qty, @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cart = {};
  double _changedMoney = 0.0;

  Map<String, CartItem> get cart {
    return {..._cart};
  }

  int get totalCount {
    int _total = 0;
    _cart.forEach((key, value) {
      _total += value.qty;
    });
    return _total;
  }

  double get totalAmount {
    double _total = 0;
    _cart.forEach((key, value) {
      _total += value.price * value.qty;
    });
    return _total;
  }

  double get getChangedMoney {
    return _changedMoney;
  }

  void add (String id, String name, double price) {
    if (_cart.containsKey(id)) {
      _cart.update(id, (exitVal) => CartItem(id: exitVal.id, name: exitVal.name, qty: exitVal.qty + 1, price: exitVal.price));
    } else {
      _cart.putIfAbsent(id, () => CartItem(id: id, name: name, qty: 1, price: price));
    }
    notifyListeners();
  }

  void remove (String id, String name, double price) {
    if (_cart[id].qty == 1) {
      _cart.remove(id);
    } else {
      _cart.update(id, (exitVal) => CartItem(id: exitVal.id, name: exitVal.name, qty: exitVal.qty - 1, price: exitVal.price));
    } 
    notifyListeners();
  }

  void clear () {
    _cart = {};
    notifyListeners();
  }

  void changeMoney (double val) {
    if (val > totalAmount) {
      _changedMoney = val - totalAmount;  
    } else {
      _changedMoney = 0.0;
    }
    notifyListeners();
  }
}