import 'package:bossi_pos/providers/product.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/widgets/manage_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductsBody extends StatefulWidget {
  ManageProductsBody({Key key}) : super(key: key);

  @override
  _ManageProductsBodyState createState() => _ManageProductsBodyState();
}

class _ManageProductsBodyState extends State<ManageProductsBody> {

  String _searchText = "";

  Widget _productListView(products) {
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

    products = products.reversed.toList();

    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (ctx, i) => ManageProductItem(products[i].id,
              products[i].name, products[i].qty, products[i].price)),
    );
  }
  
  @override
  Widget build(BuildContext context) {

    List<Product> _products = Provider.of<Products>(context).products;
    
    return _products.isEmpty ? Center(child: Text('ကုန်ပစ္စည်းမရှိသေးပါ'),) : 
    
    GestureDetector(
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
            _productListView(_products),
          ],
        ),
      );
  }
}