import 'package:barcode_scan/barcode_scan.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/screens/product_edit_screen.dart';
import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:bossi_pos/widgets/manage_products_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ManageProductsScreen extends StatefulWidget {
  static const routeName = "manage_products";

  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  var _isInit = true;
  var _isLoading = false;
  String barcodeScanRes;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts(first: 15, page: 1, search: "", isSell: 0).then((_) { 
        setState(() {
          _isLoading = false; 
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
          .fetchProducts(first: 15, page: 1, search: barcodeScanRes, isSell: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ကုန်ပစ္စည်းစာရင်း"), actions: <Widget>[
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
      drawer: const Drawlet(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ManageProductsBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.pushNamed(context, ProductEditScreen.routeName)
                .then((value) {
          if (_isInit) {
            setState(() {
              _isLoading = true;
            });
            Provider.of<Products>(context).fetchProducts(first: 15, page: 1, search: "", isSell: 0).then((_) {
              setState(() {
                _isLoading = false;
              });
            });
          }
          _isInit = false;
        }),
      ),
    );
  }
}
