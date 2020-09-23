import 'package:bossi_pos/charts/capital.dart';
import 'package:bossi_pos/charts/chart_model.dart';
import 'package:bossi_pos/widgets/button_titled_container.dart';
import 'package:bossi_pos/widgets/chart/capital_item.dart';
import 'package:flutter/material.dart';

class CapitalBody extends StatelessWidget {
  final String title;
  final String filterText;
  final List<ChartModel> caps;
  const CapitalBody(
      this.title, this.filterText, this.caps);

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(slivers: <Widget>[
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ButtonTitledContainer(title, filterText,
              child: Container(height: 200, child: Capital(caps))),
        ),
      ),
      SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ရက်စွဲ"),
                    Text("အရင်း")
                  ]))),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, i) {
          return CapitalItem(caps[i].total, caps[i].day, caps[i].month,
              caps[i].year);
        },
        childCount: caps.length,
      )),
      SliverToBoxAdapter(
        child: SizedBox(height: 20,),
      ),
    ]);
  }
}
