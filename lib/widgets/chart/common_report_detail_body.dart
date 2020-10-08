import 'package:bossi_pos/charts/common_chart.dart';
import 'package:bossi_pos/charts/chart_model.dart';
import 'package:bossi_pos/widgets/button_titled_container.dart';
import 'package:bossi_pos/widgets/chart/common_report_detail_item.dart';
import 'package:flutter/material.dart';

class CommonReportDetailBody extends StatelessWidget {
  final String title;
  final String filterText;
  final String subVal;
  final List<ChartModel> data;
  const CommonReportDetailBody(this.title, this.filterText, this.subVal, this.data);

  String _rightTitle () {
    String _rT;
    if (subVal == "total-sell") {
      _rT = "အရောင်း";
    } else if (subVal == "buy") {
      _rT = "အ၀ယ်";
    } else if (subVal == "totalItem" || subVal == "mostItem" || subVal == "leastItem" || subVal == "damagedItem" || subVal == "lostItem" || subVal == "expiredItem") {
      _rT = "အရေအတွက်";
    } else {
      _rT = "အရင်း";
    }

    return _rT;
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
                    Text(subVal == "totalItem" || subVal == "mostItem" || subVal == "leastItem" || subVal == "damagedItem" || subVal == "lostItem" || subVal == "expiredItem" ? "အမည်" : "ရက်စွဲ"), 
                  Text(_rightTitle())
                  ]))),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, i) {
          return CommonReportDetailItem(subVal, data[i]);
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
