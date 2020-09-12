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
          if (index < 5 && profits[index].month == caps[i].month &&
              profits[index].year == caps[i].year &&
              profits[index].day == caps[i].day) {
                profitData.add(CPLModel(profits[index].month, double.parse(profits[index].total)));
                capitalData
            .add(CPLModel(caps[i].month, double.parse(caps[i].total)));
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
