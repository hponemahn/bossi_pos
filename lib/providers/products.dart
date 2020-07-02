import 'package:bossi_pos/graphql/graphQLConf.dart';
import 'package:bossi_pos/graphql/queryMutation.dart';
import 'package:bossi_pos/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Products with ChangeNotifier {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  List<Product> _products = [
    /*
    Product(id: "i1", name: "အာလူး", desc: "", discountPrice: 0, price: 500.00, qty: 50, buyPrice: 400, sku: "1a", category: "1"),
    Product(id: "i2", name: "ကြက်သွန်နီ", desc: "", discountPrice: 0, price: 700.00, qty: 50, buyPrice: 400, sku: "1a", category: "2"),
    Product(id: "i3", name: "ဆန်", desc: "", discountPrice: 0, price: 1500.00, qty: 50, buyPrice: 400, sku: "1a", category: "3"),
    Product(id: "i4", name: "ဆီ", desc: "", discountPrice: 0, price: 3500.00, qty: 50, buyPrice: 400, sku: "1a", category: "4"),
    Product(id: "i5", name: "apple", desc: "", discountPrice: 0, price: 500.00, qty: 50, buyPrice: 400, sku: "1a", category: "5"),
    Product(id: "i6", name: "orange", desc: "", discountPrice: 0, price: 700.00, qty: 50, buyPrice: 400, sku: "1a", category: "1"),
    Product(id: "i7", name: "iphone", desc: "", discountPrice: 0, price: 1500.00, qty: 50, buyPrice: 400, sku: "1a", category: "2"),
    Product(id: "i8", name: "macbook", desc: "", discountPrice: 0, price: 3500.00, qty: 50, buyPrice: 400, sku: "1a", category: "3"),
    */
  ];

  List<Product> get products {
    return [..._products];
  }

  void add(Product _pr) {
    var product = Product(
        id: DateTime.now().toString(),
        name: _pr.name,
        category: _pr.category,
        price: _pr.price,
        qty: _pr.qty,
        buyPrice: _pr.buyPrice,
        sku: _pr.sku,
        desc: _pr.desc,
        barcode: _pr.barcode,
        discountPrice: _pr.discountPrice,
        isDamage: _pr.isDamage);
    _products.add(product);
    notifyListeners();

    addGraphQL(_pr);
  }

  void delete(String id) {
    _products.removeWhere((pr) => pr.id == id);
    notifyListeners();
  }

  Product findById(String id) {
    return _products.firstWhere((pr) => pr.id == id);
  }

  void edit(Product _pr) {
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

  Future<void> addGraphQL(Product _pr) async {
    
    try {
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          documentNode: gql(addMutation.addProduct(
              _pr.name,
              int.parse(_pr.category),
              _pr.qty,
              _pr.buyPrice,
              _pr.price,
              _pr.discountPrice,
              _pr.sku,
              _pr.barcode,
              _pr.isDamage == true ? 1 : 0,
              _pr.desc)),
        ),
      );

      print(result.exception);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> fetchProducts() async {
    try {
      final List<Product> loadedProducts = [];

      QueryMutation queryMutation = QueryMutation();
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(queryMutation.getAll()),
          // document: queryMutation.getAll(),
        ),
      );

      print('fetch');

      if (!result.hasException) {
        print('no exception');

        for (var i = 0; i < result.data["products"].length; i++) {

          loadedProducts.add(Product(
            id: result.data["products"][i]['id'],
            name: result.data["products"][i]['name'],
            category: result.data["products"][i]['category_id'],
            qty: result.data["products"][i]['stock'],
            buyPrice: result.data["products"][i]['buy_price'] is int ? result.data["products"][i]['buy_price'].toDouble() : result.data["products"][i]['buy_price'],
            price: result.data["products"][i]['sell_price'] is int ? result.data["products"][i]['sell_price'].toDouble() : result.data["products"][i]['sell_price'],
            discountPrice: result.data["products"][i]['discount_price'] is int ? result.data["products"][i]['discount_price'].toDouble() : result.data["products"][i]['discount_price'],
            sku: result.data["products"][i]['sku'],
            barcode: result.data["products"][i]['barcode'],
            isDamage: result.data["products"][i]['barcode'] == 0 ? false : true,
            // isDamage: result.data["products"][i]['is_damaged'],
            desc: result.data["products"][i]['remark'],
          ));

          _products = loadedProducts;
          notifyListeners();
        }
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
