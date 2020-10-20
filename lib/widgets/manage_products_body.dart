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
  int perPage = 15;
  int present = 15;
  int _page = 1;

  void loadMore() {
    setState(() {
      _page += 1;
      present = present + perPage;
    });

    if (_searchText.isNotEmpty) {
      Provider.of<Products>(context, listen: false)
          .fetchProducts(page: _page, search: _searchText);
    } else {
      print("load more $_page");
      Provider.of<Products>(context, listen: false)
          .fetchProducts(page: _page, search: "");
    }
  }

  Widget _productListView(products) {

    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          itemCount: (present <= products.length) ? products.length + 1 : products.length,
          itemBuilder: (ctx, i) {
            return (i == products.length)
                ? Container(
                    // color: Colors.greenAccent,
                    child: FlatButton(
                      child: CircularProgressIndicator(),
                      onPressed: loadMore,
                      // onPressed: () => print("load"),
                    ),
                  )
                : ManageProductItem(products[i].id,
              products[i].name, products[i].qty, products[i].price);
          }
          ),
    );
  }
  
  @override
  Widget build(BuildContext context) {

    List<Product> _products = Provider.of<Products>(context).products;

    return 
    
    _products.isEmpty ? Center(child: Text('ကုန်ပစ္စည်းမရှိသေးပါ'),) : 

    NotificationListener<ScrollNotification>(
      onNotification: (scrollState) {

        if (scrollState is ScrollEndNotification &&
            scrollState.metrics.pixels != 160) {
          print("end");
          loadMore();
        }

        return false;
      },
      child: 
    
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
                    _page = 1;
                    perPage = 15;
                    present = 15;
                  });

                  if (_searchText.isNotEmpty) {
                    print("search");
                    Provider.of<Products>(context, listen: false)
                        .fetchProducts(page: _page, search: _searchText);
                  } else {
                    Provider.of<Products>(context, listen: false)
                        .fetchProducts(page: _page, search: "");
                  }
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
    );
  }
}