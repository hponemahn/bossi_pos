import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "cart";

  @override
  Widget build(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);

    return Scaffold(
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
                              new Text("20/1/20"),
                            ],
                          ),
                        )
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text('အရောင်း၀န်ထမ်း: Owner'),
                              new Text("3:47 PM"),
                            ],
                          ),
                        )
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("ကုန်၀ယ်သူ: Mg Phyu"),
                              new Text("Add, Edit"),
                            ],
                          ),
                        )
                      ]),
                    ]))),
                    SizedBox(height: 20,),
        ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            children: _cart.cart.entries.map((cart) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(cart.value.name),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () => _cart.add(cart.value.id, cart.value.name, cart.value.price),
                  ),
                  Text(cart.value.qty.toString()),
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () => _cart.remove(cart.value.id, cart.value.name, cart.value.price),
                  ),
                  Spacer(),
                  Text(cart.value.price.toString()),
                  Spacer(),
                  Text("${cart.value.qty * cart.value.price}"),
                ],
              ),).toList(),
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
                              new Text("10,000"),
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
                              new Text("3,799"),
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
    );
  }
}
