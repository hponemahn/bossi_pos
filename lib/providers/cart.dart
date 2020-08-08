import 'package:bossi_pos/charts/ordinal_sales_model.dart';
import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:bossi_pos/graphql/orderQueryMutation.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CartItem {
  final String id;
  final String name;
  final int qty;
  final double price;

  CartItem(
      {@required this.id,
      @required this.name,
      @required this.qty,
      @required this.price});
}

class Cart with ChangeNotifier {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  Map<String, CartItem> _cart = {};
  double _changedMoney = 0.0;
  double _debit = 0.0;
  List<OrdinalSalesModel> _ordinalSalesData = [];

  List<OrdinalSalesModel> get getOrdinalSaleData => [..._ordinalSalesData];

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

  double get debit {
    return _debit;
  }

  double get getChangedMoney {
    return _changedMoney;
  }

  void add(String id, String name, double price) {
    if (_cart.containsKey(id)) {
      _cart.update(
          id,
          (exitVal) => CartItem(
              id: exitVal.id,
              name: exitVal.name,
              qty: exitVal.qty + 1,
              price: exitVal.price));
    } else {
      _cart.putIfAbsent(
          id, () => CartItem(id: id, name: name, qty: 1, price: price));
    }
    notifyListeners();
  }

  void remove(String id, String name, double price) {
    if (_cart[id].qty == 1) {
      _cart.remove(id);
    } else {
      _cart.update(
          id,
          (exitVal) => CartItem(
              id: exitVal.id,
              name: exitVal.name,
              qty: exitVal.qty - 1,
              price: exitVal.price));
    }

    notifyListeners();
  }

  void clear() {
    _cart = {};
    notifyListeners();
  }

  void changeMoney(double val) {
    _debit = val;

    if (val > totalAmount) {
      _changedMoney = val - totalAmount;
    } else {
      _changedMoney = 0.0;
    }
    notifyListeners();
  }

  void qtyChangeMoney() {
    if (_debit > totalAmount) {
      _changedMoney = _debit - totalAmount;
    } else {
      _changedMoney = 0.0;
    }

    if (_cart.isEmpty) {
      _changedMoney = 0.0;
    }

    notifyListeners();
  }

  Future<void> confirm() async {
    List _orderData = [];

    _cart.forEach((key, value) {
      OrderItem _orI = OrderItem(
          productId: int.parse(value.id), qty: value.qty, price: value.price);
      _orderData.add(_orI);
    });

    OrderQueryMutation addMutation = OrderQueryMutation();
    try {
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          documentNode: gql(addMutation.addOrder(
              totalAmount, DateTime.now().toString(), _orderData)),
        ),
      );

      print(result.exception);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchOrderSevenData() async {
    try {
      final List<OrdinalSalesModel> loadedProducts = [];

      OrderQueryMutation queryMutation = OrderQueryMutation();
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(queryMutation.getOrderForSevenDaysData()),
          // document: queryMutation.getAll(),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data["orderForSevenDays"].length; i++) {
          
          loadedProducts.add(
            OrdinalSalesModel(
                total: result.data["orderForSevenDays"][i]['total'].toString(),
                orderDate: result.data["orderForSevenDays"][i]['order_date']
                    .toString()
                    .substring(0, 3)),
          );
        }

        _ordinalSalesData = loadedProducts;
        // print("ordinal");
        // print(_ordinalSalesData);
        notifyListeners();
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}

class OrderItem {
  final int productId;
  final int qty;
  final double price;

  OrderItem(
      {@required this.productId, @required this.qty, @required this.price});

  @override
  toString() => '{product_id: $productId, qty: $qty, price: $price}';
}
