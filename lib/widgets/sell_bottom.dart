import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:bossi_pos/screens/cart_screen.dart';
import 'package:bossi_pos/widgets/badge.dart';
import 'package:provider/provider.dart';

class SellBottom extends StatelessWidget {
  const SellBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);

    return BottomAppBar(
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.money_off),
              Text("${_cart.totalAmount.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 17.0, color: Colors.grey[800])),
            ],
          ),
          FlatButton.icon(
              textColor: Colors.grey[800],
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () => {
                    if (_cart.cart.isEmpty)
                      {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('အသိပေးခြင်း'),
                                content: Text(
                                  'အပေါ်တွင်ပြထားသော ရောင်းမည့်ပစ္စည်းများကို ဦးစာရွေးချယ်ပြီးမှ နှိပ်ပါ။​',
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Okay'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            })
                      }
                    else
                      {Navigator.pushNamed(context, CartScreen.routeName)}
                  },
              icon: Badge(
                  child: Icon(Icons.shopping_cart),
                  value: _cart.totalCount.toString()),
              label: Text(
                "ရောင်းမည်",
                style: TextStyle(fontSize: 17.0),
              )),
          FlatButton.icon(
              textColor: Colors.grey[800],
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () => _cart.clear(),
              icon: Icon(Icons.cancel),
              label: Text(
                "ဖျက်မည်",
                style: TextStyle(fontSize: 17.0),
              )),
        ],
      ),
    );
  }
}
