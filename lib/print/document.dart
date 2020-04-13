import 'dart:async';

import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// import 'package:provider/provider.dart';

import 'example_widgets.dart';

Future<pw.Document> generateDocument(
    PdfPageFormat format, Cart _cartForPrint) async {
  final pw.Document doc =
      pw.Document(title: 'receipt', author: 'David PHAM-VAN');

  final font = await rootBundle.load("assets/Pyidaungsu-2.5.3_Regular.ttf");
  final ttf = pw.Font.ttf(font);

  const imageProvider = const AssetImage('assets/shop_logo.png');
  final PdfImage _shopLogo =
      await pdfImageFromImageProvider(pdf: doc.document, image: imageProvider);

  final pw.PageTheme pageTheme = myPageTheme(format);

  doc.addPage(pw.Page(
    pageTheme: pageTheme,
    build: (pw.Context context) => pw.Row(
      children: <pw.Widget>[
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Center(
                  child: pw.ClipOval(
                      child: pw.Container(
                          padding: pw.EdgeInsets.fromLTRB(20, 20, 20, 10),
                          width: 100,
                          height: 100,
                          color: lightGreen,
                          child: _shopLogo == null
                              ? pw.Container()
                              : pw.Image(_shopLogo)))),
              pw.Center(
                child: pw.Text("Get Ready Fitness Club",
                    style: pw.TextStyle(
                      fontSize: 17.0,
                      fontWeight: pw.FontWeight.bold,
                    )),
              ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text("Sale Voucher"),
              ),
              pw.Center(
                child: pw.Text("43, David Shwe Nu Street, Mayangone, Yangon"),
              ),
              pw.Center(
                child: pw.Text("09421090653 , 09421090654"),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("No: #A002"),
                  pw.Text("20/1/20, 3:47 PM"),
                ],
              ),
              pw.SizedBox(height: 20),
              
              pw.ListView(
                children: _cartForPrint.cart.entries
                    .map(
                      (cart) => pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          // flex: 4,
                          pw.Text(cart.value.name,
                              style: pw.TextStyle(font: ttf)),

                          // flex: 2,
                          pw.Text(cart.value.qty.toString(),
                              textAlign: pw.TextAlign.center),

                          // flex: 2,
                          pw.Text(
                            cart.value.price.toString(),
                          ),

                          // flex: 2,
                          pw.Text("${cart.value.qty * cart.value.price}",
                              textAlign: pw.TextAlign.right),
                        ],
                      ),
                    )
                    .toList(),
              ),

              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Total  :"),
                  pw.Text(_cartForPrint.totalAmount.toString()),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Discount  :"),
                  pw.Text("-"),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Grand Total  :",
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 14)),
                  pw.Text(_cartForPrint.totalAmount.toString(),
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 14)),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Paid Amount  :"),
                  pw.Text(
                      "${_cartForPrint.totalAmount + _cartForPrint.getChangedMoney}"),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Change  :"),
                  pw.Text(_cartForPrint.getChangedMoney.toString()),
                ],
              ),
              pw.SizedBox(height: 40),
              pw.Center(
                child: pw.Text("Thank You Come Again!"),
              ),
            ],
          ),
        )
      ],
    ),
  ));
  return doc;
}
