import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/screens/product_edit_screen.dart';
import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:bossi_pos/widgets/manage_products_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductsScreen extends StatefulWidget {
  static const routeName = "manage_products";

  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_) {
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
      appBar: AppBar(
        title: const Text("ကုန်ပစ္စည်းစာရင်း"),
      ),
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
            Provider.of<Products>(context).fetchProducts().then((_) {
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
