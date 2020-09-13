import 'package:bossi_pos/charts/chart_model.dart';
import 'package:bossi_pos/charts/cpl.dart';
import 'package:bossi_pos/widgets/button_titled_container.dart';
import 'package:bossi_pos/widgets/report_detail_item.dart';
import 'package:flutter/material.dart';

class ReportDetailBody extends StatelessWidget {
  final String title;
  final String filterText;
  final List<ChartModel> caps;
  final List<ChartModel> profits;
  const ReportDetailBody(this.title, this.filterText, this.caps, this.profits);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ButtonTitledContainer(title, filterText, 
              child: Container(height: 200, child: CPL(caps, profits))),
        ),
      ),
      SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("အရင်း"),
                    Text("အမြတ်"),
                  ]))),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, i) {

          return ReportDetailItem(
              caps[i].total, caps[i].day, caps[i].month, caps[i].year, profits);
        },
        childCount: caps.length,
      )),
    ]);
  }
}
