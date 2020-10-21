import 'package:barcode_scan/barcode_scan.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:bossi_pos/widgets/sell_body.dart';
import 'package:bossi_pos/widgets/sell_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  SellScreen({Key key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  var _isInit = true;
  var _isLoading = false;
  String barcodeScanRes;

  Future scan() async {
    var result;
    try {
      result = await BarcodeScanner.scan();
    } on PlatformException catch (e) {
      var errorResult = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          errorResult.rawContent =
              'The user did not grant the camera permission!';
        });
      } else {
        errorResult.rawContent = 'Unknown error: $e';
      }
    }

    setState(() {
      barcodeScanRes = result.rawContent;
    });
    print(barcodeScanRes);

    if (barcodeScanRes.isNotEmpty) {
      print("search by barcode");
      Provider.of<Products>(context, listen: false)
          .fetchProducts(first: 30, page: 1, search: barcodeScanRes);
    }
    //  else {
    //   Provider.of<Products>(context, listen: false)
    //       .fetchProducts(first: 30, page: 1, search: "");
    // }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context)
          .fetchProducts(first: 30, page: 1, search: "")
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Ready Shop"), actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: scan,
              child: Icon(
                Icons.qr_code_scanner,
                size: 26.0,
              ),
            )),
      ]),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SellBody(),
      drawer: Drawlet(),
      bottomNavigationBar: SellBottom(),
    );
  }
}
