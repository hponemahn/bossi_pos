import 'dart:async';

// import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// import 'package:provider/provider.dart';

import 'example_widgets.dart';

// class Document extends StatelessWidget {
//   const Document({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: c,
//     );
//   }
// }



Future<pw.Document> generateDocument(PdfPageFormat format) async {

  final pw.Document doc =
      pw.Document(title: 'receipt', author: 'David PHAM-VAN');

  final font = await rootBundle.load("assets/Pyidaungsu-2.5.3_Regular.ttf");
  final ttf = pw.Font.ttf(font);

  final PdfImage profileImage = kIsWeb
      ? null
      : await pdfImageFromImageProvider(
          pdf: doc.document,
          image: const NetworkImage(
              'https://lh3.googleusercontent.com/proxy/oooL1sf95bIcE3EUm6VrAt2k_y2cKahVj7Jmeme6xpH9gfjcz8_GdzdHgufDPxt3bWMKjQh3t1exG01_oG4eKiPSyV0P8jF4BiOpDYzpwmBmPoxBvcZijJg0kzocan5RjeY'),
          onError: (dynamic exception, StackTrace stackTrace) {
            print('Unable to download image');
          });

  final pw.PageTheme pageTheme = myPageTheme(format);

  doc.addPage(pw.Page(
    pageTheme: pageTheme,
    build: (pw.Context context) => pw.Row(
      children: <pw.Widget>[
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
            //   pw.Container(
            //   padding: pw.EdgeInsets.fromLTRB(20, 20, 20, 10),
            //   child: profileImage,
            // ),
            pw.Center(
              child: 
            pw.ClipOval(
              child: pw.Container(
                  padding: pw.EdgeInsets.fromLTRB(20, 20, 20, 10),
                  width: 100,
                  height: 100,
                  color: lightGreen,
                  child: profileImage == null
                      ? pw.Container()
                      : pw.Image(profileImage)))
            ),
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
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("ပန်းသီး", style: pw.TextStyle(font: ttf)),
                      pw.Text("4"),
                      pw.Text("500"),
                      pw.Text("2000"),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("apple"),
                      pw.Text("4"),
                      pw.Text("500"),
                      pw.Text("2000"),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("apple"),
                      pw.Text("4"),
                      pw.Text("500"),
                      pw.Text("2000"),
                    ],
                  ),
              pw.SizedBox(height: 20),
              pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Total  :"),
                      pw.Text("2000"),
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
                      pw.Text("Grand Total  :", style: pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 14)),
                      pw.Text("2000", style: pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 14)),
                    ],
                  ),
              pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Paid Amount  :"),
                      pw.Text("2000"),
                    ],
                  ),
              pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Change  :"),
                      pw.Text("2000"),
                    ],
                  ),
              pw.SizedBox(height: 40),
              pw.Center(
              child: pw.Text("Thank You Come Again!"),
            ),
            // pw.Center(child: pw.Text(_cart.totalAmount.toString()),),
            ],
          ),
        )
      ],
    ),
  ));
  return doc;
}
