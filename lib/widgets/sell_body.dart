import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:provider/provider.dart';

class SellBody extends StatefulWidget {
  SellBody({Key key}) : super(key: key);

  @override
  _SellBodyState createState() => _SellBodyState();
}

class _SellBodyState extends State<SellBody> {
  String _searchText = "";
  int perPage = 30;
  int present = 30;
  int _page = 1;

  void loadMore() {
    setState(() {
      _page += 1;
      present = present + perPage;
    });

    if (_searchText.isNotEmpty) {
      Provider.of<Products>(context, listen: false)
          .fetchProducts(first: 30, page: _page, search: _searchText);
    } else {
      print("load more $_page");
      Provider.of<Products>(context, listen: false)
          .fetchProducts(first: 30, page: _page, search: "");
    }
  }

  Widget _grid(products, _cart) {
    return Flexible(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: (present <= products.length)
            ? products.length + 1
            : products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1),
        itemBuilder: (ctx, index) {
          Widget _widget;

          if (index == products.length) {
            _widget = Container(
              // color: Colors.greenAccent,
              child: FlatButton(
                child: CircularProgressIndicator(),
                onPressed: loadMore,
                // onPressed: () => print("load"),
              ),
            );
          } else {
            _widget = Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GridTile(
                      child: GestureDetector(
                        onTap: () {
                          _cart.add(products[index].id, products[index].name,
                              products[index].price);
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.blueGrey.shade500,
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: FittedBox(
                                    child: Text(
                                  products[index].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )))),
                      ),
                    ),
                  ),
                ),
                if (_cart.cart[products[index].id] != null &&
                    _cart.cart[products[index].id].qty != 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      // color: Theme.of(context).accentColor,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Theme.of(context).accentColor,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                      ),
                      child: Text(
                        _cart.cart[products[index].id].qty.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
              ],
            );
          }
          return _widget;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Products _products = Provider.of<Products>(context);
    Cart _cart = Provider.of<Cart>(context);

    return _products.products.isEmpty
        ? Center(
            child: Text('ရောင်းရန် ပစ္စည်းမရှိသေးပါ'),
          )
        : NotificationListener<ScrollNotification>(
            onNotification: (scrollState) {
              if (scrollState is ScrollEndNotification &&
                  scrollState.metrics.pixels != 160) {
                print("end");
                loadMore();
              }

              return false;
            },
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          _searchText = val;
                          _page = 1;
                          perPage = 30;
                          present = 30;
                        });

                        if (_searchText.isNotEmpty) {
                          print("search");
                          Provider.of<Products>(context, listen: false)
                              .fetchProducts(
                                  first: 30, page: _page, search: _searchText);
                        } else {
                          Provider.of<Products>(context, listen: false)
                              .fetchProducts(
                                  first: 30, page: _page, search: "");
                        }
                      },
                      decoration: new InputDecoration(
                          prefixIcon: new Icon(Icons.search),
                          hintText: 'ရောင်းမည့်ပစ္စည်းရှာရန် ...'),
                    ),
                  ),
                  _grid(_products.products, _cart),
                ],
              ),
            ),
          );
  }
}
