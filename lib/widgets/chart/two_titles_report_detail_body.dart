import 'package:bossi_pos/charts/common_chart.dart';
import 'package:bossi_pos/charts/chart_model.dart';
import 'package:bossi_pos/widgets/button_titled_container.dart';
import 'package:bossi_pos/widgets/chart/two_titles_report_detail_item.dart';
import 'package:flutter/material.dart';

class TwoTitlesReportDetailBody extends StatelessWidget {
  final String title;
  final String filterText;
  final String subVal;
  final List<ChartModel> data;
  const TwoTitlesReportDetailBody(
      this.title, this.filterText, this.subVal, this.data);

  String _getTitle() {
    String _title;
    if (subVal == "itemCat-profit" || subVal == "bestSellingItemCat" || subVal == "worstSellingItemCat") {
      _title = "အမျိုးအမည် - ရက်စွဲ";
    } else if (subVal == "mostBuy-itemCat") {
      _title = "အမျိုးအမည်";
    } else if (subVal == "mostBuy-item") {
      _title = "အမည်";
    } else {
      _title = "အမည် - ရက်စွဲ";
    }
    
    return _title;
  }

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(slivers: <Widget>[
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ButtonTitledContainer(title, filterText,
              child: Container(height: 200, child: CommonChart(subVal, data))),
        ),
      ),
      SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_getTitle()),
                    Row(
                      // spacing: 12,
                      children: [
                        Text("အရေအတွက်"),
                        SizedBox(width: 3),
                        Text("|"),
                        SizedBox(width: 3),
                        Text(subVal == "mostBuy-item" || subVal == "mostBuy-itemCat" ? "အ၀ယ်" : "အမြတ်"),
                      ],
                    )
                  ]))),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, i) {
          return TwoTitlesReportDetailItem(
              subVal, data[i]);
        },
        childCount: data.length,
      )),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 20,
        ),
      ),
    ]);
  }
}
