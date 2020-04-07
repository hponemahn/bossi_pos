import 'package:bossi_pos/widgets/sell_body.dart';
import 'package:flutter/material.dart';

class SellScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Ready Shop"),
      ),
      body: SellBody(),
      bottomNavigationBar: BottomAppBar(
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.money_off),
                Text("2500 ကျပ်",
                    style: TextStyle(fontSize: 17.0, color: Colors.grey[800])),
              ],
            ),
            FlatButton.icon(
                textColor: Colors.grey[800],
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  print("ဖျက်မည်");
                },
                icon: Icon(Icons.cancel),
                label: Text(
                  "ဖျက်မည်",
                  style: TextStyle(fontSize: 17.0),
                )),
            FlatButton.icon(
                textColor: Colors.grey[800],
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, '/sell_confirm');
                },
                icon: Icon(Icons.add_shopping_cart),
                label: Text(
                  "ရောင်းမည်",
                  style: TextStyle(fontSize: 17.0),
                )),
          ],
        ),
      ),
    );
  }
}