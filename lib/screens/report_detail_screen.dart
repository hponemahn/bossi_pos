import 'package:bossi_pos/charts/cpl.dart';
import 'package:bossi_pos/providers/product.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/widgets/button_titled_container.dart';
import 'package:bossi_pos/widgets/report_detail_bottom.dart';
import 'package:bossi_pos/widgets/report_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportDetailScreen extends StatefulWidget {
  static const routeName = "report_detail";

  ReportDetailScreen({Key key}) : super(key: key);

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  String _title;
  Widget _chart;
  List<Product> _products;
  var _isInit = true;
  // var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      // setState(() {
      //   _isLoading = true;
      // });
      Provider.of<Products>(context).fetchProducts().then((_) {
        // setState(() {
        //   _isLoading = false;
        // });
      });
    }
    _isInit = false;

    final Map _args = ModalRoute.of(context).settings.arguments as Map;
    if (_args['subVal'] == "cpl") {
      _chart = CPL();
      _products = Provider.of<Products>(context).products;
      print("cpl");
    }
    _title = _args['title'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actionsIconTheme: IconThemeData(
              size: 30.0, color: Theme.of(context).accentColor, opacity: 10.0),
          actions: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.filter_list,
                size: 26.0,
              ),
            ),
            PopupMenuButton(
                icon: Icon(Icons.more_vert),
                onSelected: (val) {
                  print(val);
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(
                          "ကြည့်ရှုရန်",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      PopupMenuItem(
                        value: "day",
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text("ရက်အလိုက်"),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: "month",
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text("လအလိုက်"),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: "year",
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text("နှစ်အလိုက်"),
                            ],
                          ),
                        ),
                      ),
                    ]),
          ],
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonTitledContainer(_title,
                  child: Container(height: 200, child: _chart)),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("အရင်း"),
                        Text("အမြတ်"),
                      ]))),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, i) {
              return ReportDetailItem();
            },
            childCount: _products.length,
          )),
        ]),
        bottomNavigationBar: ReportDetailButton());
  }
}
