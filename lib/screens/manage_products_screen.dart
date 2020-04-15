import 'package:bossi_pos/providers/product.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/screens/product_edit_screen.dart';
import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:bossi_pos/widgets/manage_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductsScreen extends StatefulWidget {
  static const routeName = "manage_products";

  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  String _searchText = "";

  Widget _productListView (products) {
    if (_searchText.isNotEmpty) {
      List tempList = new List();
      for (int i = 0; i < products.length; i++) {
        if (products[i]
            .name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(products[i]);
        }
      }
      products = tempList;
    }

    return ListView.builder(shrinkWrap: true,itemCount: products.length, itemBuilder: (ctx, i) => ManageProductItem(products[i].id, products[i].name, products[i].qty, products[i].price)
    );
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
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Container(
              padding: EdgeInsets.all(10),
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
            _productListView(_products),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, ProductEditScreen.routeName),
      ),
    );
  }
}
