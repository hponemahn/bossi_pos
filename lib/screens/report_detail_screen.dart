import 'package:bossi_pos/providers/chart.dart';
import 'package:bossi_pos/widgets/chart/capital_body.dart';
import 'package:bossi_pos/widgets/chart/sell_profit_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

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
  Map _arguments;

  void _fetchDataWithCondition() {
    if (_arguments['subVal'] == "sell&profit") {
      Provider.of<Chart>(context).fetchSaleData();
      Provider.of<Chart>(context).fetchProfitData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "capital") {
      Provider.of<Chart>(context).fetchCapData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void _fetchFilterData(String val) {
    if (_arguments['subVal'] == "sell&profit") {
      Provider.of<Chart>(context, listen: false).fetchSaleData(val);
      Provider.of<Chart>(context, listen: false).fetchProfitData(val);
    } else if (_arguments['subVal'] == "capital") {
      Provider.of<Chart>(context, listen: false).fetchCapData(val);
    }
  }

  @override
  void didChangeDependencies() {
    final Map _args = ModalRoute.of(context).settings.arguments as Map;

    if (_isInit) {
      setState(() {
        _isLoading = true;
        _arguments = _args;
      });

      _fetchDataWithCondition();
    }

    _isInit = false;
    _title = _args['title'];
    super.didChangeDependencies();
  }

  Widget _widget() {
    Widget _widgetBody;

    if (_isLoading) {
      _widgetBody = Center(
        child: CircularProgressIndicator(),
      );
    } else if (_arguments['subVal'] == "sell&profit") {
      _widgetBody = SellProfitBody(_title, _filterText,
          Provider.of<Chart>(context).sale, Provider.of<Chart>(context).profit);
    } else if (_arguments['subVal'] == "capital") {
      _widgetBody =
          CapitalBody(_title, _filterText, Provider.of<Chart>(context).cap);
    }

    return _widgetBody;
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
              onTap: () async {
                final List<DateTime> picked =
                    await DateRagePicker.showDatePicker(
                        context: context,
                        initialFirstDate: new DateTime.now(),
                        initialLastDate:
                            (new DateTime.now()).add(new Duration(days: 7)),
                        firstDate: new DateTime(DateTime.now().year - 50),
                        lastDate: new DateTime(DateTime.now().year + 50));
                if (picked != null && picked.length == 2) {
                  print(picked);
                }
              },
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

                  _fetchFilterData(val);
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
        body: _widget()
        // _isLoading
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     :
        //     SellProfitBody(_title, _filterText, Provider.of<Chart>(context).sale, Provider.of<Chart>(context).profit),
        // bottomNavigationBar: ReportDetailButton(Provider.of<Chart>(context).profit)
        );
  }
}
