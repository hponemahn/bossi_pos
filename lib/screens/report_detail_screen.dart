import 'package:bossi_pos/providers/chart.dart';
import 'package:bossi_pos/widgets/chart/common_report_detail_body.dart';
import 'package:bossi_pos/widgets/chart/sell_profit_body.dart';
import 'package:bossi_pos/widgets/chart/two_titles_report_detail_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

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
  String _startDate = "0";
  String _endDate = "0";
  Map _arguments;
  int perPage = 2;
  int present = 2;
  int _page = 1;

  void loadMore() {
    setState(() {
      _page += 1;
      present = present + perPage;
    });

    print("body page $_page");

    if (_arguments['subVal'] == "capital") {
      Provider.of<Chart>(context, listen: false).fetchCapData(
          filter: _filterText,
          startDate: _startDate,
          endDate: _endDate,
          first: 2,
          page: _page);
    } else if (_arguments['subVal'] == "sell&profit") {
      Provider.of<Chart>(context, listen: false).fetchSaleData(
          filter: _filterText,
          startDate: _startDate,
          endDate: _endDate,
          first: 2,
          page: _page);
      Provider.of<Chart>(context, listen: false).fetchProfitData(
          filter: _filterText,
          startDate: _startDate,
          endDate: _endDate,
          first: 2,
          page: _page);
    } else if (_arguments['subVal'] == "total-sell") {
      Provider.of<Chart>(context, listen: false).fetchSaleData(
          filter: _filterText,
          startDate: _startDate,
          endDate: _endDate,
          first: 2,
          page: _page);
    } else if (_arguments['subVal'] == "item-profit") {
      Provider.of<Chart>(context, listen: false).fetchItemProfitData(
          filter: _filterText,
          startDate: _startDate,
          endDate: _endDate,
          first: 2,
          page: _page);
    }
  }

  void _fetchDataOnCondition() {
    if (_arguments['subVal'] == "sell&profit") {
      Provider.of<Chart>(context).fetchSaleData(
          filter: _filterText,
          startDate: _startDate,
          endDate: _endDate,
          first: 2,
          page: 1);
      Provider.of<Chart>(context)
          .fetchProfitData(
              filter: _filterText,
              startDate: _startDate,
              endDate: _endDate,
              first: 2,
              page: 1)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "capital") {
      Provider.of<Chart>(context)
          .fetchCapData(
              filter: _filterText,
              startDate: _startDate,
              endDate: _endDate,
              first: 2,
              page: 1)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "total-sell") {
      Provider.of<Chart>(context)
          .fetchSaleData(
              filter: _filterText,
              startDate: _startDate,
              endDate: _endDate,
              first: 2,
              page: 1)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "item-profit") {
      Provider.of<Chart>(context)
          .fetchItemProfitData(
              filter: _filterText,
              startDate: _startDate,
              endDate: _endDate,
              first: 2,
              page: 1)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "itemCat-profit") {
      Provider.of<Chart>(context)
          .fetchItemCatProfitData(_filterText, _startDate, _endDate)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "bestSellingItem" ||
        _arguments['subVal'] == "bestSellingItemCat") {
      Provider.of<Chart>(context)
          .fetchBestSellingItemData(_filterText, _startDate, _endDate)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "worstSellingItem" ||
        _arguments['subVal'] == "worstSellingItemCat") {
      Provider.of<Chart>(context)
          .fetchWorstSellingItemData(_filterText, _startDate, _endDate)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "buy") {
      Provider.of<Chart>(context)
          .fetchBuyData(_filterText, _startDate, _endDate)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "mostBuy-item") {
      setState(() {
        _filterText = "none";
      });
      Provider.of<Chart>(context).fetchMostBuyingItemData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "mostBuy-itemCat") {
      setState(() {
        _filterText = "none";
      });
      Provider.of<Chart>(context).fetchMostBuyingItemCatData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "leastBuy-item") {
      setState(() {
        _filterText = "none";
      });
      Provider.of<Chart>(context).fetchLeastBuyingItemData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "leastBuy-itemCat") {
      setState(() {
        _filterText = "none";
      });
      Provider.of<Chart>(context).fetchLeastBuyingItemCatData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "totalItem") {
      setState(() {
        _filterText = "none";
      });
      Provider.of<Chart>(context).fetchTotalItemData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "mostItem") {
      setState(() {
        _filterText = "none";
      });
      Provider.of<Chart>(context).fetchMostItemData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "leastItem") {
      setState(() {
        _filterText = "none";
      });
      Provider.of<Chart>(context).fetchLeastItemData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "damagedItem") {
      setState(() {
        _filterText = "none";
      });
      Provider.of<Chart>(context).fetchDamagedItemData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "lostItem") {
      setState(() {
        _filterText = "none";
      });
      Provider.of<Chart>(context).fetchLostItemData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else if (_arguments['subVal'] == "expiredItem") {
      setState(() {
        _filterText = "none";
      });
      Provider.of<Chart>(context).fetchExpiredItemData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void _fetchFilterData() {
    setState(() {
      _page = 1;
      perPage = 2;
      present = 2;
    });
    if (_arguments['subVal'] == "sell&profit") {
      Provider.of<Chart>(context, listen: false).fetchSaleData(
          filter: _filterText,
          startDate: _startDate,
          endDate: _endDate,
          first: 2,
          page: 1);
      Provider.of<Chart>(context, listen: false).fetchProfitData(
          filter: _filterText,
          startDate: _startDate,
          endDate: _endDate,
          first: 2,
          page: 1);
    } else if (_arguments['subVal'] == "capital") {
      Provider.of<Chart>(context, listen: false).fetchCapData(
          filter: _filterText,
          startDate: _startDate,
          endDate: _endDate,
          first: 2,
          page: 1);
    } else if (_arguments['subVal'] == "total-sell") {
      Provider.of<Chart>(context, listen: false).fetchSaleData(
          filter: _filterText,
          startDate: _startDate,
          endDate: _endDate,
          first: 2,
          page: 1);
    } else if (_arguments['subVal'] == "item-profit") {
      Provider.of<Chart>(context, listen: false).fetchItemProfitData(
          filter: _filterText,
          startDate: _startDate,
          endDate: _endDate,
          first: 2,
          page: 1);
    } else if (_arguments['subVal'] == "itemCat-profit") {
      Provider.of<Chart>(context, listen: false)
          .fetchItemCatProfitData(_filterText, _startDate, _endDate);
    } else if (_arguments['subVal'] == "bestSellingItem" ||
        _arguments['subVal'] == "bestSellingItemCat") {
      Provider.of<Chart>(context, listen: false)
          .fetchBestSellingItemData(_filterText, _startDate, _endDate);
    } else if (_arguments['subVal'] == "worstSellingItem" ||
        _arguments['subVal'] == "worstSellingItemCat") {
      Provider.of<Chart>(context, listen: false)
          .fetchWorstSellingItemData(_filterText, _startDate, _endDate);
    } else if (_arguments['subVal'] == "buy") {
      Provider.of<Chart>(context, listen: false)
          .fetchBuyData(_filterText, _startDate, _endDate);
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

      _fetchDataOnCondition();
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
      _widgetBody = CommonReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).cap);
    } else if (_arguments['subVal'] == "total-sell") {
      _widgetBody = CommonReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).sale);
    } else if (_arguments['subVal'] == "item-profit") {
      _widgetBody = TwoTitlesReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).itemProfit);
    } else if (_arguments['subVal'] == "itemCat-profit") {
      _widgetBody = TwoTitlesReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).itemCatProfit);
    } else if (_arguments['subVal'] == "bestSellingItem" ||
        _arguments['subVal'] == "bestSellingItemCat") {
      _widgetBody = TwoTitlesReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).bestSellingItem);
    } else if (_arguments['subVal'] == "worstSellingItem" ||
        _arguments['subVal'] == "worstSellingItemCat") {
      _widgetBody = TwoTitlesReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).worstSellingItem);
    } else if (_arguments['subVal'] == "buy") {
      _widgetBody = CommonReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).buy);
    } else if (_arguments['subVal'] == "mostBuy-item") {
      _widgetBody = TwoTitlesReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).mostBuyingItem);
    } else if (_arguments['subVal'] == "mostBuy-itemCat") {
      _widgetBody = TwoTitlesReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).mostBuyingItemCat);
    } else if (_arguments['subVal'] == "leastBuy-item") {
      _widgetBody = TwoTitlesReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).leastBuyingItem);
    } else if (_arguments['subVal'] == "leastBuy-itemCat") {
      _widgetBody = TwoTitlesReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).leastBuyingItemCat);
    } else if (_arguments['subVal'] == "totalItem") {
      _widgetBody = CommonReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).totalItem);
    } else if (_arguments['subVal'] == "mostItem") {
      _widgetBody = CommonReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).mostItem);
    } else if (_arguments['subVal'] == "leastItem") {
      _widgetBody = CommonReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).leastItem);
    } else if (_arguments['subVal'] == "damagedItem") {
      _widgetBody = CommonReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).damagedItem);
    } else if (_arguments['subVal'] == "lostItem") {
      _widgetBody = CommonReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).lostItem);
    } else if (_arguments['subVal'] == "expiredItem") {
      _widgetBody = CommonReportDetailBody(_title, _filterText,
          _arguments['subVal'], Provider.of<Chart>(context).expiredItem);
    }

    return _widgetBody;
  }

  String _convertDateTime(val) {
    var newFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    return newFormat.format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(val));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actionsIconTheme: IconThemeData(
              size: 30.0, color: Theme.of(context).accentColor, opacity: 10.0),
          actions: <Widget>[
            _arguments['subVal'] != "mostBuy-item" &&
                    _arguments['subVal'] != "mostBuy-itemCat" &&
                    _arguments['subVal'] != "leastBuy-item" &&
                    _arguments['subVal'] != "leastBuy-itemCat" &&
                    _arguments['subVal'] != "totalItem" &&
                    _arguments['subVal'] != "mostItem" &&
                    _arguments['subVal'] != "leastItem" &&
                    _arguments['subVal'] != "damagedItem" &&
                    _arguments['subVal'] != "lostItem" &&
                    _arguments['subVal'] != "expiredItem"
                ? GestureDetector(
                    onTap: () async {
                      final List picked = await DateRagePicker.showDatePicker(
                          context: context,
                          initialFirstDate: new DateTime.now(),
                          initialLastDate:
                              (new DateTime.now()).add(new Duration(days: 7)),
                          firstDate: new DateTime(DateTime.now().year - 50),
                          lastDate: new DateTime(DateTime.now().year + 50));
                      if (picked != null && picked.length == 2) {
                        setState(() {
                          _startDate = _convertDateTime(picked[0].toString());
                          _endDate = _convertDateTime(picked[1].toString());
                        });
                        _fetchFilterData();
                      }
                    },
                    child: Icon(
                      Icons.filter_list,
                      size: 26.0,
                    ),
                  )
                : Text(""),
            _arguments['subVal'] != "mostBuy-item" &&
                    _arguments['subVal'] != "mostBuy-itemCat" &&
                    _arguments['subVal'] != "leastBuy-item" &&
                    _arguments['subVal'] != "leastBuy-itemCat" &&
                    _arguments['subVal'] != "totalItem" &&
                    _arguments['subVal'] != "mostItem" &&
                    _arguments['subVal'] != "leastItem" &&
                    _arguments['subVal'] != "damagedItem" &&
                    _arguments['subVal'] != "lostItem" &&
                    _arguments['subVal'] != "expiredItem"
                ? PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    onSelected: (val) {
                      setState(() {
                        _filterText = val;
                      });

                      _fetchFilterData();
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
                        ])
                : Text(""),
          ],
        ),
        body: RefreshIndicator(
          child: NotificationListener<ScrollNotification>(
              onNotification: (scrollState) {
                if (scrollState is ScrollEndNotification &&
                    scrollState.metrics.pixels != 160) {
                  print("end");
                  loadMore();
                }

                return false;
              },
              child: _widget()),
          onRefresh: () async {
            setState(() {
              _page = 1;
              perPage = 30;
              present = 30;
            });

            if (_arguments['subVal'] == "capital") {
              Provider.of<Chart>(context, listen: false).fetchCapData(
                  filter: "m",
                  startDate: "0",
                  endDate: "0",
                  first: 2,
                  page: _page);
            } else if (_arguments['subVal'] == "sell&profit") {
              Provider.of<Chart>(context, listen: false).fetchSaleData(
                  filter: "m",
                  startDate: "0",
                  endDate: "0",
                  first: 2,
                  page: _page);

              Provider.of<Chart>(context, listen: false).fetchProfitData(
                  filter: "m",
                  startDate: "0",
                  endDate: "0",
                  first: 2,
                  page: _page);
            } else if (_arguments['subVal'] == "total-sell") {
              Provider.of<Chart>(context, listen: false).fetchSaleData(
                  filter: "m",
                  startDate: "0",
                  endDate: "0",
                  first: 2,
                  page: _page);
            } else if (_arguments['subVal'] == "item-profit") {
              Provider.of<Chart>(context, listen: false).fetchItemProfitData(
                  filter: "m",
                  startDate: "0",
                  endDate: "0",
                  first: 2,
                  page: _page);
            }
          },
        )

        // bottomNavigationBar: ReportDetailButton(Provider.of<Chart>(context).profit)
        );
  }
}
