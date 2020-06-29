import 'package:bossi_pos/graphql/graphql_string.dart';
import 'package:bossi_pos/providers/product.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/screens/product_edit_screen.dart';
import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:bossi_pos/widgets/manage_product_item.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class ManageProductsScreen extends StatefulWidget {
  static const routeName = "manage_products";

  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  String _searchText = "";

  // Widget _productListView(products) {
  //   if (_searchText.isNotEmpty) {
  //     List tempList = new List();
  //     for (int i = 0; i < products.length; i++) {
  //       if (products[i]
  //           .name
  //           .toLowerCase()
  //           .contains(_searchText.toLowerCase())) {
  //         tempList.add(products[i]);
  //       }
  //     }
  //     products = tempList;
  //   }

  //   return Expanded(
  //     child: ListView.builder(
  //         padding: EdgeInsets.all(10),
  //         shrinkWrap: true,
  //         itemCount: products.length,
  //         itemBuilder: (ctx, i) => ManageProductItem(products[i].id,
  //             products[i].name, products[i].qty, products[i].price)),
  //   );
  // }

    Widget _productListView() {
    return Query(
        options: QueryOptions(
          documentNode:
              gql(products), // this is the query string you just created
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.loading) {
            return Text('Loading');
          }
          List repositories = result.data['products'];
          return Expanded(
            child: ListView.builder(
                itemCount: repositories.length,
                itemBuilder: (contex, index) => ManageProductItem(
                    repositories[index]['id'].toString(),
                    repositories[index]['name'],repositories[index]['stock'],repositories[index]['buy_price'].toDouble())),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> _products = Provider.of<Products>(context).products;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ကုန်ပစ္စည်းစာရင်း"),
      ),
      drawer: const Drawlet(),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _searchText = val;
                  });
                },
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search),
                    hintText: 'အမည်ဖြင့် ရှာရန် ...'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _productListView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.pushNamed(context, ProductEditScreen.routeName),
      ),
    );
  }
}
