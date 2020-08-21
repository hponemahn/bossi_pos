import 'package:bossi_pos/providers/cart.dart';
import 'package:bossi_pos/screens/dashboard_body_screen.dart';
import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = "dashboard";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _isInit = true;
  var _isLoading = false;

  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Cart>(context).fetchOrderSevenData();
      Provider.of<Cart>(context).fetchNetData();
      Provider.of<Cart>(context).fetchLostData();
      Provider.of<Cart>(context).fetchSaleData();
      Provider.of<Cart>(context).fetchBuyData();
      Provider.of<Cart>(context).fetchStockData().then((_) {
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
        title: Text('အစီရင်ခံစာ'),
      ),
      drawer: Drawlet(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : DashboardBodyScreen(),
    );
  }
}
