import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import '../print/document.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "order";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final GlobalKey<State<StatefulWidget>> shareWidget = GlobalKey();

  PrintingInfo printingInfo;

  Cart _cartForPrint;

  String _orderID;
  String _orderDate;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      dynamic _orderInfo = ModalRoute.of(context).settings.arguments as dynamic;

      var _date = DateFormat("yyyy-MM-dd hh:mm:ss", "en_US").parse(jsonDecode(_orderInfo)['order_date']);

      setState(() {
        _orderID = jsonDecode(_orderInfo)['id'].toString();
        _orderDate = DateFormat('dd/MM/yyyy hh:mm').format(_date);
      });
    }
    print("convert date");
    print(_orderDate);
    
    _isInit = false;
  }

  @override
  void initState() {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    Printing.info().then((PrintingInfo info) {
      setState(() {
        printingInfo = info;
      });
    });
    super.initState();
  }

  void _showPrintedToast(bool printed) {
    final ScaffoldState scaffold = Scaffold.of(shareWidget.currentContext);
    if (printed) {
      scaffold.showSnackBar(const SnackBar(
        content: Text('Document printed successfully'),
      ));
    } else {
      scaffold.showSnackBar(const SnackBar(
        content: Text('Document not printed'),
      ));
    }
  }

  Future<void> _printPdf() async {
    try {
      final bool result = await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async =>
              (await generateDocument(format, _cartForPrint)).save());
      _showPrintedToast(result);
    } catch (e) {
      final ScaffoldState scaffold = Scaffold.of(shareWidget.currentContext);
      scaffold.showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
      ));
    }
  }

  Future<void> _sharePdf() async {
    print('Share ...');
    final pw.Document document =
        await generateDocument(PdfPageFormat.a4, _cartForPrint);

    // Calculate the widget center for iPad sharing popup position
    final RenderBox referenceBox =
        shareWidget.currentContext.findRenderObject();
    final Offset topLeft =
        referenceBox.localToGlobal(referenceBox.paintBounds.topLeft);
    final Offset bottomRight =
        referenceBox.localToGlobal(referenceBox.paintBounds.bottomRight);
    final Rect bounds = Rect.fromPoints(topLeft, bottomRight);

    await Printing.sharePdf(
        bytes: document.save(), filename: 'receipt.pdf', bounds: bounds);
  }

  @override
  Widget build(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);

    setState(() {
      _cartForPrint = _cart;
    });

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
              child: Text("အရောင်းပြေစာ"),
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
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.spaceBetween,
                                // runAlignment: WrapAlignment.center,

                                crossAxisAlignment: WrapCrossAlignment.center,
                                verticalDirection: VerticalDirection.up,

                                children: <Widget>[
                                  new Text('အရောင်းပြေစာအမှတ်:  #$_orderID'),
                                  new Text(_orderDate),
                                ],
                              ),
                            )
                          ]),
                        ]))),
            SizedBox(
              height: 20.0,
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
                            child: Text(cartItem.qty.toString(),
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center),
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
                                  new Text(
                                      "${_cart.totalAmount + _cart.getChangedMoney}"),
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
                                  new Text(
                                      _cart.getChangedMoney.toStringAsFixed(2)),
                                ],
                              ),
                            )
                          ]),
                        ]))),
            Center(
              child: Text("၀ယ်ယူအားပေးမှုကို ကျေးဇူးတင်ပါသည်။"),
            ),
            SizedBox(
              height: 20.0,
            ),
            Wrap(
              // spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: <Widget>[
                FlatButton(
                  key: shareWidget,
                  onPressed: printingInfo?.canShare ?? false ? _sharePdf : null,
                  child: Image.asset(
                    "assets/share.png",
                    width: 60,
                    height: 60,
                  ),
                ),
                FlatButton(
                  onPressed: printingInfo?.canPrint ?? false ? _printPdf : null,
                  // setState(() {
                  //   _cartForPrint = _cart;
                  // });
                  // printingInfo?.canPrint ?? false ? _printPdf : null;
                  // printingInfo.canPrint ? _printPdf : null;
                  // },
                  child: Image.asset(
                    "assets/print.png",
                    width: 60,
                    height: 60,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(140, 50, 140, 40),
              child: RaisedButton(
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  // _cart.confirm().then((value) => _cart.clear());
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
