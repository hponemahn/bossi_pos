import 'package:bossi_pos/providers/chart.dart';
import 'package:bossi_pos/widgets/report_detail_body.dart';
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

  var _isInit = true;
  var _isLoading = false;
  String _filterText = "m";

  @override
  void didChangeDependencies() {
    final Map _args = ModalRoute.of(context).settings.arguments as Map;

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      if (_args['subVal'] == "cpl") {
        Provider.of<Chart>(context).fetchCapData();
        Provider.of<Chart>(context).fetchSaleData();
        Provider.of<Chart>(context).fetchProfitData().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }
    }

    _isInit = false;
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
                  setState(() {
                    _filterText = val;
                  });
                  Provider.of<Chart>(context, listen: false).fetchCapData(val);
                  Provider.of<Chart>(context, listen: false).fetchSaleData(val);
                  Provider.of<Chart>(context, listen: false).fetchProfitData(val);
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(
                          "ကြည့်ရှုရန်",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      PopupMenuItem(
                        value: "d",
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
                        value: "m",
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
                        value: "y",
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
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ReportDetailBody(_title, _filterText, Provider.of<Chart>(context).cap, Provider.of<Chart>(context).sale, Provider.of<Chart>(context).profit),
        // bottomNavigationBar: ReportDetailButton(Provider.of<Chart>(context).profit)
        );
  }
}
