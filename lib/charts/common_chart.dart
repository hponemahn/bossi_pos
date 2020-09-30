import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:bossi_pos/charts/chart_model.dart';

class CommonChart extends StatelessWidget {
  final List<ChartModel> data;
  const CommonChart(this.data);

  @override
  Widget build(BuildContext context) {
    final List<CommonModel> commonData = [];

    for (var i = 0; i < data.length; i++) {
      if (i < 4) {

        commonData.add(CommonModel(
            data[i].name, double.parse(data[i].total)));

      }
    }

    List<charts.Series<CommonModel, String>> seriesList = [
      new charts.Series<CommonModel, String>(
        id: 'Desktop',
        domainFn: (CommonModel sales, _) => sales.date,
        measureFn: (CommonModel sales, _) => sales.total,
        data: commonData,
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
class CommonModel {
  final String date;
  final double total;

  CommonModel(this.date, this.total);
}
