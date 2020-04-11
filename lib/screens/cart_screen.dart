import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "cart";
  int _curDay = DateTime.now().day;
  int _curMon = DateTime.now().month;
  int _curYear = DateTime.now().year;
  int _curHr = DateTime.now().hour;
  int _curMin = DateTime.now().minute;


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
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          Container(
              // height: MediaQuery.of(context).size.height,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Table(
                      // border: TableBorder.all(width: 1.0, color: Colors.black),
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text('အရောင်းပြေစာ: #A002'),
                                new Text("$_curDay/$_curMon/$_curYear"),
                              ],
                            ),
                          )
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text('အရောင်း၀န်ထမ်း: -'),
                                new Text("$_curHr:$_curMin"),
                              ],
                            ),
                          )
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text("ကုန်၀ယ်သူ: -"),
                                // new Text("Add, Edit"),
                              ],
                            ),
                          )
                        ]),
                      ]))),
          SizedBox(
            height: 20,
          ),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            children: _cart.cart.entries
                .map(
                  (cart) => Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(cart.value.name),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () => _cart.add(
                            cart.value.id, cart.value.name, cart.value.price),
                      ),
                      Text(cart.value.qty.toString()),
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () => _cart.remove(
                            cart.value.id, cart.value.name, cart.value.price),
                      ),
                      Spacer(),
                      Text(cart.value.price.toString()),
                      Spacer(),
                      Text("${cart.value.qty * cart.value.price}"),
                    ],
                  ),
                )
                .toList(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text('စုစုပေါင်း  :'),
                                new Text(_cart.totalAmount.toStringAsFixed(2)),
                              ],
                            ),
                          )
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  'ကျသင့်ငွေ  :',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                new Text(
                                  _cart.totalAmount.toStringAsFixed(2),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text("ပေးငွေ  :"),
                                // new Text("10,000"),
                                Container(
                                  width: 80,
                                  height: 20,
                                  // padding: EdgeInsets.all(20),
                                  child: TextField(
                                    onChanged: (val) {
                                      _cart.changeMoney(double.parse(val));
                                    },
                                    textAlign: TextAlign.right,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text("ပြန်အမ်းငွေ  :"),
                                new Text(
                                    _cart.getChangedMoney.toStringAsFixed(2)),
                              ],
                            ),
                          )
                        ]),
                      ]))),
          Container(
            padding: EdgeInsets.fromLTRB(100, 30, 100, 0),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sell_success');
              },
              textColor: Colors.white,
              color: Theme.of(context).accentColor,
              child:
                  Text("အတည်ပြုမည်", style: Theme.of(context).textTheme.button),
            ),
          ),
        ]))),
      ),
    );
  }
}
