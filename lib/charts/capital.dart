import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:bossi_pos/charts/chart_model.dart';

class Capital extends StatelessWidget {
  final List<ChartModel> caps;
  const Capital(this.caps);

  @override
  Widget build(BuildContext context) {
    final List<SellProfitModel> capitalData = [];

    for (var i = 0; i < caps.length; i++) {
      if (i < 4) {
        final String cD = caps[i].day == null ? "" : caps[i].day;
        final String cM = caps[i].month == null ? "" : caps[i].month;
        final String cY = caps[i].year == null ? "" : caps[i].year;

        capitalData.add(SellProfitModel(
            cY + " " + cM + " " + cD, double.parse(caps[i].total)));
      }
    }

    List<charts.Series<SellProfitModel, String>> seriesList = [
      new charts.Series<SellProfitModel, String>(
        id: 'Desktop',
        domainFn: (SellProfitModel sales, _) => sales.date,
        measureFn: (SellProfitModel sales, _) => sales.total,
        data: capitalData,
      ),
    ];

    return new charts.BarChart(
      seriesList,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }
}

/// Sample ordinal data type.
class SellProfitModel {
  final double total;
  final String date;

  SellProfitModel(this.date, this.total);
}
