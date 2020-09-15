import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:bossi_pos/charts/chart_model.dart';

class CPL extends StatelessWidget {
  final List<ChartModel> caps;
  final List<ChartModel> sales;
  final List<ChartModel> profits;
  const CPL(this.caps, this.sales, this.profits);

  @override
  Widget build(BuildContext context) {
    final List<CPLModel> capitalData = [];
    final List<CPLModel> saleData = [];

    for (var i = 0; i < caps.length; i++) {
      if (i < 5) {
        for (var index = 0; index < sales.length; index++) {

          final String cD = caps[i].day == null ? "" : caps[i].day;
          final String cM = caps[i].month == null ? "" : caps[i].month;
          final String cY = caps[i].year == null ? "" : caps[i].year;

          final String sD =
              sales[index].day == null ? "" : sales[index].day;
          final String sM =
              sales[index].month == null ? "" : sales[index].month;
          final String sY =
              sales[index].year == null ? "" : sales[index].year;

          if (index < 5 &&
              sM == cM &&
              sY == cY &&
              sD == cD) {

            saleData.add(CPLModel(
                sY + " " + sM + " " + sD, double.parse(sales[index].total)));
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
        data: saleData,
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
