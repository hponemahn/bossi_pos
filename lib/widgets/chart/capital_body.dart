import 'package:bossi_pos/charts/common_chart.dart';
import 'package:bossi_pos/charts/chart_model.dart';
import 'package:bossi_pos/widgets/button_titled_container.dart';
import 'package:bossi_pos/widgets/chart/capital_item.dart';
import 'package:flutter/material.dart';

class CapitalBody extends StatelessWidget {
  final String title;
  final String filterText;
  final String subVal;
  final List<ChartModel> data;
  const CapitalBody(this.title, this.filterText, this.subVal, this.data);

  String _rightTitle () {
    String _rT;
    if (subVal == "total-sell") {
      _rT = "အရောင်း";
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
              child: Container(height: 200, child: CommonChart(data))),
        ),
      ),
      SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("ရက်စွဲ"), 
                  Text(_rightTitle())
                  ]))),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, i) {
          return CapitalItem(
              data[i].total, data[i].day, data[i].month, data[i].year);
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
