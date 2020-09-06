import 'package:bossi_pos/providers/cart.dart';
import 'package:bossi_pos/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "cart";
  final _debitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("အရောင်းစာရင်း"),
            ),
            body: ListView(children: [
              SizedBox(
                height: 20,
              ),
              ..._cart.cart.values.toList().map(
                    (cartItem) => Card(
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      elevation: 20,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2.5.toInt(),
                              child: Text(cartItem.name,
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center),
                            ),
                            Expanded(
                              flex: 2.5.toInt(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 25.0,
                                      width: 25.0,
                                      child: new IconButton(
                                        padding: new EdgeInsets.all(0.0),
                                        icon: new Icon(Icons.add_circle_outline,
                                            size: 25.0),
                                        onPressed: () {
                                          _cart.add(cartItem.id, cartItem.name,
                                              cartItem.price);
                                          _cart.qtyChangeMoney();
                                        },
                                      )),
                                  Text(cartItem.qty.toString(),
                                      style: TextStyle(fontSize: 18)),
                                  SizedBox(
                                      height: 25.0,
                                      width: 25.0,
                                      child: new IconButton(
                                          padding: new EdgeInsets.all(0.0),
                                          icon: new Icon(
                                              Icons.remove_circle_outline,
                                              size: 25.0),
                                          onPressed: () {
                                            _cart.remove(cartItem.id,
                                                cartItem.name, cartItem.price);
                                            _cart.qtyChangeMoney();
                                          })),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2.5.toInt(),
                              child: Text(cartItem.price.toString(),
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center),
                            ),
                            Expanded(
                              flex: 2.5.toInt(),
                              child: Text(
                                  "${(cartItem.qty * cartItem.price).toStringAsFixed(2)}",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              Container(
                  // height: MediaQuery.of(context).size.height,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(35, 10, 50, 20),
                      child: Table(
                          // border: TableBorder.all(width: 1.0, color: Colors.black),
                          children: [
                            TableRow(children: [
                              TableCell(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text('စုစုပေါင်း  :'),
                                    new Text(
                                        _cart.totalAmount.toStringAsFixed(2)),
                                  ],
                                ),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text('Discount  :'),
                                    new Text("-"),
                                  ],
                                ),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      'ကျသင့်ငွေ  :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    new Text(
                                      _cart.totalAmount.toStringAsFixed(2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text("ပေးငွေ  :"),
                                    Container(
                                      width: 80,
                                      height: 20,
                                      // padding: EdgeInsets.all(20),
                                      child: TextField(
                                        controller: _debitController,
                                        onChanged: (val) {
                                          _cart.changeMoney(double.parse(val));
                                        },
                                        textAlign: TextAlign.right,
                                        // keyboardType: TextInputType.number,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                signed: true, decimal: true),
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        textInputAction: TextInputAction.done,
                                        // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text("ပြန်အမ်းငွေ  :"),
                                    new Text(_cart.totalAmount != 0
                                        ? _cart.getChangedMoney
                                            .toStringAsFixed(2)
                                        : ''),
                                  ],
                                ),
                              )
                            ]),
                          ]))),
              Container(
                padding: EdgeInsets.fromLTRB(100, 30, 100, 30),
                child: RaisedButton(
                  elevation: 20,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    if (_cart.totalAmount == 0) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushNamed(context, OrderScreen.routeName);
                    }
                  },
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  child: Text("အတည်ပြုမည်",
                      style: Theme.of(context).textTheme.button),
                ),
              ),
            ])));
  }
}
