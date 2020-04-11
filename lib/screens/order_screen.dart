import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "order";

  final int _curDay = DateTime.now().day;
  final int _curMon = DateTime.now().month;
  final int _curYear = DateTime.now().year;
  final int _curHr = DateTime.now().hour;
  final int _curMin = DateTime.now().minute;

  @override
  Widget build(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("အရောင်းပြေစာ"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Image.asset(
                "assets/shop_logo.png",
                height: 100,
              ),
            ),
            Center(
              child: Text("Get Ready Fitness Club",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(height: 20),
            Center(
              child: Text("Sale Voucher"),
            ),
            Center(
              child: Text("43, David Shwe Nu Street, Mayangone, Yangon"),
            ),
            Center(
              child: Text("09421090653 , 09421090654"),
            ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text('အရောင်းပြေစာ: #A002'),
                                  new Text("$_curDay/$_curMon/$_curYear - $_curHr:$_curMin"),
                                ],
                              ),
                            )
                          ]),
                        ]))),
                        SizedBox(height: 20.0,),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Table(
                  border: TableBorder.all(width: 0.1, color: Colors.black),
                  children: _cart.cart.entries
                      .map(
                        (cart) => TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Text(cart.value.name),
                              ],
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(cart.value.qty.toString()),
                              ],
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Text(cart.value.price.toString()),
                              ],
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                new Text("${cart.value.qty * cart.value.price}"),
                              ],
                            ),
                          )
                        ]),
                      )
                      .toList()),
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
                                  new Text(_cart.totalAmount.toStringAsFixed(2)),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  new Text(
                                    _cart.totalAmount.toStringAsFixed(2),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                  new Text("${_cart.totalAmount + _cart.getChangedMoney}"),
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
                                  new Text(_cart.getChangedMoney.toString()),
                                ],
                              ),
                            )
                          ]),
                        ]))),
            Center(
              child: Text("၀ယ်ယူအားပေးမှုကို ကျေးဇူးတင်ပါသည်။"),
            ),
            SizedBox(
              height: 60.0,
            ),
            Wrap(
              // spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    print("sms");
                  },
                  child: Image.asset(
                    "assets/sms.png",
                    width: 60,
                    height: 60,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    print("sms");
                  },
                  child: Image.asset(
                    "assets/viber.png",
                    width: 60,
                    height: 60,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    print("sms");
                  },
                  child: Image.asset(
                    "assets/print.png",
                    width: 60,
                    height: 60,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    print("sms");
                  },
                  child: Image.asset(
                    "assets/mail.png",
                    width: 60,
                    height: 60,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(140, 50, 140, 40),
              child: RaisedButton(
                onPressed: () {
                  _cart.clear();
                  Navigator.pushNamed(context, '/');
                },
                color: Theme.of(context).accentColor,
                child: Text("Done", style: Theme.of(context).textTheme.button),
              ),
            ),
          ],
        ));
  }
}
