import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "cart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("အရောင်းစာရင်း"),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 25,
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
                                  new Text("20/1/20"),
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
                                  new Text('အရောင်း၀န်ထမ်း: Owner'),
                                  new Text("3:47 PM"),
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
                                  new Text("ကုန်၀ယ်သူ: Mg Phyu"),
                                  new Text("Add, Edit"),
                                ],
                              ),
                            )
                          ]),
                        ]))),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Table(
                border: TableBorder.all(width: 0.1, color: Colors.black),
                children: [
                  TableRow(children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Text("ပန်းသီး"),
                        ],
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.add_circle_outline),
                          Text("5"),
                          Icon(Icons.remove_circle_outline),
                        ],
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Text("1,000"),
                        ],
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Text("5,000"),
                        ],
                      ),
                    )
                  ]),
                  TableRow(children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Text("သရက်သီး"),
                        ],
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.add_circle_outline),
                          Text("2"),
                          Icon(Icons.remove_circle_outline),
                        ],
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Text("500"),
                        ],
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Text("1,000"),
                        ],
                      ),
                    )
                  ]),
                ],
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
                                  new Text("6,000"),
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
                                  new Text("201"),
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
                                  new Text('ကျသင့်ငွေ  :', style: TextStyle(fontWeight: FontWeight.bold),),
                                  new Text("5,799", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                  new Text("10,000"),
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
                          child: Text("အတည်ပြုမည်", style: Theme.of(context).textTheme.button),
                        ),
                        ),
          ],
        ));
  }
}