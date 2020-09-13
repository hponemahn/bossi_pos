import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:bossi_pos/charts/chart_model.dart';

class CPL extends StatelessWidget {
  final List<ChartModel> caps;
  final List<ChartModel> profits;
  const CPL(this.caps, this.profits);

  @override
  Widget build(BuildContext context) {
    final List<CPLModel> capitalData = [];
    final List<CPLModel> profitData = [];

    for (var i = 0; i < caps.length; i++) {
      if (i < 5) {
        for (var index = 0; index < profits.length; index++) {

          final String cD = caps[i].day == null ? "" : caps[i].day;
          final String cM = caps[i].month == null ? "" : caps[i].month;
          final String cY = caps[i].year == null ? "" : caps[i].year;

          final String pD =
              profits[index].day == null ? "" : profits[index].day;
          final String pM =
              profits[index].month == null ? "" : profits[index].month;
          final String pY =
              profits[index].year == null ? "" : profits[index].year;

          if (index < 5 &&
              pM == cM &&
              pY == cY &&
              pD == cD) {

            profitData.add(CPLModel(
                pY + " " + pM + " " + pD, double.parse(profits[index].total)));
            capitalData
                .add(CPLModel(cY + " " + cM + " " + cD, double.parse(caps[i].total)));
          }
        }
      }
    }

    List<charts.Series<CPLModel, String>> seriesList = [
      new charts.Series<CPLModel, String>(
        id: 'Desktop',
        domainFn: (CPLModel sales, _) => sales.date,
        measureFn: (CPLModel sales, _) => sales.total,
        data: capitalData,
      ),
      new charts.Series<CPLModel, String>(
        id: 'Tablet',
        domainFn: (CPLModel sales, _) => sales.date,
        measureFn: (CPLModel sales, _) => sales.total,
        data: profitData,
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
class CPLModel {
  final double total;
  final String date;

  CPLModel(this.date, this.total);
}
