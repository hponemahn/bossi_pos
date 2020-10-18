import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:bossi_pos/graphql/productQueryMutation.dart';
import 'package:bossi_pos/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Products with ChangeNotifier {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  ProductQueryMutation addMutation = ProductQueryMutation(); 

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
        isDamage: _pr.isDamage,
        isLost: _pr.isLost,
        isExpired: _pr.isExpired,
        );
    _products.add(product);
    notifyListeners();

    _addGraphQL(_pr);
  }

  void delete(String id) {
    _products.removeWhere((pr) => pr.id == id);
    notifyListeners();
    _deleteProduct(id);
  }

  Product findById(String id) {
    Product _pr = _products.firstWhere((pr) => pr.id == id);
    return _pr;
  }

  void edit(Product _pr) {
    int index = _products.indexWhere((pr) => pr.id == _pr.id);
    if (index >= 0) {
      _products[index] = _pr;
      notifyListeners();

      _editGraphQL(_pr);
    } else {
      print("...");
    }
  }

  Future<void> _addGraphQL(Product _pr) async {
    try {
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          documentNode: gql(addMutation.addProduct(
              _pr.name,
              _pr.category,
              _pr.qty,
              _pr.buyPrice,
              _pr.price,
              _pr.discountPrice,
              _pr.sku,
              _pr.barcode,
              _pr.isDamage == true ? 1 : 0,
              _pr.isLost == true ? 1 : 0,
              _pr.isExpired == true ? 1 : 0,
              _pr.desc)),
        ),
      );

      print(result.exception);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> _editGraphQL(Product _pr) async {
    try {
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          documentNode: gql(addMutation.editProduct(
              _pr.id,
              _pr.name,
              _pr.category,
              _pr.qty,
              _pr.buyPrice,
              _pr.price,
              _pr.discountPrice,
              _pr.sku,
              _pr.barcode,
              _pr.isDamage == true ? 1 : 0,
              _pr.isLost == true ? 1 : 0,
              _pr.isExpired == true ? 1 : 0,
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

      ProductQueryMutation queryMutation = ProductQueryMutation();
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(queryMutation.getAll()),
          // document: queryMutation.getAll(),
        ),
      );

      if (!result.hasException) {
        print('no exception');

        for (var i = 0; i < result.data["products"].length; i++) {

          loadedProducts.add(Product(
            id: result.data["products"][i]['id'],
            name: result.data["products"][i]['name'],
            category: result.data["products"][i]['category_id'],
            qty: result.data["products"][i]['stock'],
            buyPrice: result.data["products"][i]['buy_price'] is int
                ? result.data["products"][i]['buy_price'].toDouble()
                : result.data["products"][i]['buy_price'],
            price: result.data["products"][i]['sell_price'] is int
                ? result.data["products"][i]['sell_price'].toDouble()
                : result.data["products"][i]['sell_price'],
            discountPrice: result.data["products"][i]['discount_price'] is int
                ? result.data["products"][i]['discount_price'].toDouble()
                : result.data["products"][i]['discount_price'],
            sku: result.data["products"][i]['sku'],
            barcode: result.data["products"][i]['barcode'],
            isDamage: result.data["products"][i]['is_damaged'] == 0 ? false : true,
            isLost: result.data["products"][i]['is_lost'] == 0 ? false : true,
            isExpired: result.data["products"][i]['is_expired'] == 0 ? false : true,
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

  Future<void> _deleteProduct(String id) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        documentNode: gql(addMutation.deleteProduct(id)),
      ),
    );

    print(result.exception);
  }
}
