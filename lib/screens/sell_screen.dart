import 'package:bossi_pos/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  SellScreen({Key key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    Products _products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Get Ready Shop"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: _filter,
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search),
                  hintText: 'ရောင်းမည့်ပစ္စည်းရှာရန် ...'),
            ),
          ),
          Flexible(
            // child: _gridView(_products),
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _products.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1),
              itemBuilder: (BuildContext context, int index) => Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  GridTile(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GridTile(
                        child: CircleAvatar(
                            backgroundColor: Colors.blueGrey.shade500,
                            child: Padding(
                                padding: EdgeInsets.all(5),
                                child: FittedBox(
                                    child: Text(
                                  _products.products[index].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )))),
                      ),
                    ),
                  ),
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
                        "12",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
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
