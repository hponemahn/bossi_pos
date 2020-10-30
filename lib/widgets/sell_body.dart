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
  TextEditingController _searchController = TextEditingController();

  int perPage = 16;
  int present = 16;
  int _page = 1;

  void loadMore() {
    setState(() {
      _page += 1;
      present = present + perPage;
    });

    Provider.of<Products>(context, listen: false)
        .fetchProducts(first: 16, page: _page, search: _searchText, isSell: 1);
  }

  Widget _grid(products, _cart) {
    return Flexible(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: (present <= products.length)
            ? products.length + 1
            : products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 2),
        itemBuilder: (ctx, index) {
          Widget _widget;

          if (index == products.length) {
            _widget = Container(
              // color: Colors.greenAccent,
              child: FlatButton(
                child: CircularProgressIndicator(),
                onPressed: loadMore,
              ),
            );
          } else {
            _widget = Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _cart.add(products[index].id, products[index].name,
                        products[index].price);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.green,
                    ),
                    child: Wrap(
                      runAlignment: WrapAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            products[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 35),
                        Container(
                          // color: Colors.red,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code_scanner,
                                size: 13,
                                color: Colors.blueGrey.shade100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  products[index].barcode.isEmpty
                                      ? "-"
                                      : products[index].barcode,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey.shade100,
                                    fontSize: 14.0,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                            // color: Colors.red,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.center,
                              runAlignment: WrapAlignment.center,
                              children: [
                                Text(products[index].price.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      // fontWeight: FontWeight.bold
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("MMK",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      // fontWeight: FontWeight.bold
                                    )),
                              ],
                            )),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                if (_cart.cart[products[index].id] != null &&
                    _cart.cart[products[index].id].qty != 0)
                  Positioned(
                    right: 4,
                    top: 4,
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
        : RefreshIndicator(
            child: NotificationListener<ScrollNotification>(
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
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() {
                            _searchText = val;
                            _page = 1;
                            perPage = 16;
                            present = 16;
                          });

                          Provider.of<Products>(context, listen: false)
                              .fetchProducts(
                                  first: 16,
                                  page: _page,
                                  search: _searchText,
                                  isSell: 1);
                        },
                        decoration: new InputDecoration(
                            prefixIcon: new Icon(Icons.search),
                            hintText: 'အမည် (သို့) Barcode ဖြင့်ရှာရန် ...'),
                      ),
                    ),
                    _grid(_products.products, _cart),
                  ],
                ),
              ),
            ),
            onRefresh: () async {
              _searchController.clear();
              setState(() {
                _page = 1;
                perPage = 16;
                present = 16;
                _searchText = "";
              });

              Provider.of<Products>(context, listen: false)
                  .fetchProducts(first: 16, page: _page, search: "", isSell: 1);
            },
          );
  }
}
