import 'dart:async';
import 'dart:io';

import 'package:bossi_pos/screens/document.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:markdown/markdown.dart' as markdown;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../screens/image_viewer.dart';
import '../screens/viewer.dart';

import 'package:bossi_pos/print/print_screen.dart';
import 'package:bossi_pos/providers/cart.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "order";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  final GlobalKey<State<StatefulWidget>> shareWidget = GlobalKey();
  final GlobalKey<State<StatefulWidget>> pickWidget = GlobalKey();
  final GlobalKey<State<StatefulWidget>> previewContainer = GlobalKey();

  Printer selectedPrinter;
  PrintingInfo printingInfo;
  
  final int _curDay = DateTime.now().day;
  final int _curMon = DateTime.now().month;
  final int _curYear = DateTime.now().year;
  final int _curHr = DateTime.now().hour;
  final int _curMin = DateTime.now().minute;

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
    print('Print ...');
    try {
      final bool result = await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async =>
              (await generateDocument(format)).save());
      _showPrintedToast(result);
    } catch (e) {
      final ScaffoldState scaffold = Scaffold.of(shareWidget.currentContext);
      scaffold.showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
      ));
    }
  }

  Future<void> _saveAsFile() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final File file = File(appDocPath + '/' + 'document.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes((await generateDocument(PdfPageFormat.a4)).save());
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => PdfViewer(file: file)),
    );
  }

  Future<void> _rasterToImage() async {
    final List<int> doc = (await generateDocument(PdfPageFormat.a4)).save();

    final List<ImageProvider> images = <ImageProvider>[];

    await for (PdfRaster page in Printing.raster(doc)) {
      images.add(PdfRasterImage(page));
    }

    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => ImageViewer(images: images)),
    );
  }

  Future<void> _pickPrinter() async {
    print('Pick printer ...');

    // Calculate the widget center for iPad sharing popup position
    final RenderBox referenceBox = pickWidget.currentContext.findRenderObject();
    final Offset topLeft =
        referenceBox.localToGlobal(referenceBox.paintBounds.topLeft);
    final Offset bottomRight =
        referenceBox.localToGlobal(referenceBox.paintBounds.bottomRight);
    final Rect bounds = Rect.fromPoints(topLeft, bottomRight);

    try {
      final Printer printer = await Printing.pickPrinter(bounds: bounds);
      print('Selected printer: $selectedPrinter');

      setState(() {
        selectedPrinter = printer;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _directPrintPdf() async {
    print('Direct print ...');
    final bool result = await Printing.directPrintPdf(
        printer: selectedPrinter,
        onLayout: (PdfPageFormat format) async =>
            (await generateDocument(PdfPageFormat.letter)).save());

    _showPrintedToast(result);
  }

  Future<void> _sharePdf() async {
    print('Share ...');
    final pw.Document document = await generateDocument(PdfPageFormat.a4);

    // Calculate the widget center for iPad sharing popup position
    final RenderBox referenceBox =
        shareWidget.currentContext.findRenderObject();
    final Offset topLeft =
        referenceBox.localToGlobal(referenceBox.paintBounds.topLeft);
    final Offset bottomRight =
        referenceBox.localToGlobal(referenceBox.paintBounds.bottomRight);
    final Rect bounds = Rect.fromPoints(topLeft, bottomRight);

    await Printing.sharePdf(
        bytes: document.save(), filename: 'my-résumé.pdf', bounds: bounds);
  }
  
  Future<void> _printScreen() async {
    final bool result =
        await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final pw.Document document = pw.Document();

      final PdfImage image = await wrapWidget(
        document.document,
        key: previewContainer,
        pixelRatio: 2.0,
      );

      print('Print Screen ${image.width}x${image.height}...');

      document.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            ); // Center
          })); // Page

      return document.save();
    });

    _showPrintedToast(result);
  }

  Future<void> _printHtml() async {
    print('Print html ...');
    final bool result =
        await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final String html = await rootBundle.loadString('assets/example.html');
      return await Printing.convertHtml(format: format, html: html);
    });

    _showPrintedToast(result);
  }
  
  Future<void> _printMarkdown() async {
    print('Print Markdown ...');
    final bool result =
        await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final String md = await rootBundle.loadString('assets/example.md');
      final String html = markdown.markdownToHtml(md,
          extensionSet: markdown.ExtensionSet.gitHubWeb);
      return await Printing.convertHtml(format: format, html: html);
    });

    _showPrintedToast(result);
  }

  @override
  Widget build(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context);

    return RepaintBoundary(
        key: previewContainer,
        child: Scaffold(
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
                    print("print");
                    Navigator.pushNamed(context, PrintScreen.routeName);
                  },
                  child: Image.asset(
                    "assets/sms.png",
                    width: 60,
                    height: 60,
                  ),
                ),
                FlatButton(
                  // onPressed: () {
                  //   print("sms");
                  // },
                  onPressed: printingInfo?.canShare ?? false ? _sharePdf : null,
                  child: Image.asset(
                    "assets/viber.png",
                    width: 60,
                    height: 60,
                  ),
                ),
                FlatButton(
                  // onPressed: () {
                  //   print("print");
                  //   Navigator.pushNamed(context, PrintScreen.routeName);
                  // },
                  onPressed: printingInfo?.canPrint ?? false ? _printPdf : null,
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
        )),);
  }
}
