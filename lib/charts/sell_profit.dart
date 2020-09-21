import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:bossi_pos/charts/chart_model.dart';

class SellProfit extends StatelessWidget {
  // final List<ChartModel> caps;
  final List<ChartModel> sales;
  final List<ChartModel> profits;
  const SellProfit(this.sales, this.profits);

  @override
  Widget build(BuildContext context) {
    final List<SellProfitModel> capitalData = [];
    final List<SellProfitModel> saleData = [];

    for (var i = 0; i < sales.length; i++) {
      if (i < 5) {
        for (var index = 0; index < profits.length; index++) {

          final String cD = sales[i].day == null ? "" : sales[i].day;
          final String cM = sales[i].month == null ? "" : sales[i].month;
          final String cY = sales[i].year == null ? "" : sales[i].year;

          final String sD =
              profits[index].day == null ? "" : profits[index].day;
          final String sM =
              profits[index].month == null ? "" : profits[index].month;
          final String sY =
              profits[index].year == null ? "" : profits[index].year;

          if (index < 5 &&
              sM == cM &&
              sY == cY &&
              sD == cD) {

            saleData.add(SellProfitModel(
                sY + " " + sM + " " + sD, double.parse(profits[index].total)));
            capitalData
                .add(SellProfitModel(cY + " " + cM + " " + cD, double.parse(sales[i].total)));
          }
        }
      }
    }

    List<charts.Series<SellProfitModel, String>> seriesList = [
      new charts.Series<SellProfitModel, String>(
        id: 'Desktop',
        domainFn: (SellProfitModel sales, _) => sales.date,
        measureFn: (SellProfitModel sales, _) => sales.total,
        data: capitalData,
      ),
      new charts.Series<SellProfitModel, String>(
        id: 'Tablet',
        domainFn: (SellProfitModel sales, _) => sales.date,
        measureFn: (SellProfitModel sales, _) => sales.total,
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
class SellProfitModel {
  final double total;
  final String date;

  SellProfitModel(this.date, this.total);
}
