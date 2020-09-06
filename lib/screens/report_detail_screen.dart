import 'package:bossi_pos/charts/daily_sum.dart';
import 'package:bossi_pos/providers/product.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/widgets/button_titled_container.dart';
import 'package:bossi_pos/widgets/manage_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportDetailScreen extends StatefulWidget {
  static const routeName = "report_detail";

  ReportDetailScreen({Key key}) : super(key: key);

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> _products = Provider.of<Products>(context).products;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('အစီရင်ခံစာ'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ButtonTitledContainer("နေ့လိုက်ရောင်းအား",
                child: Container(height: 200, child: DailySum())),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, i) {
            return ManageProductItem(_products[i].id, _products[i].name,
                _products[i].qty, _products[i].price);
          },
          childCount: _products.length,
        )),
      ]),
    );
  }
}
