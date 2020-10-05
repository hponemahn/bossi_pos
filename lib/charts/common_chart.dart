import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:bossi_pos/charts/chart_model.dart';

class CommonChart extends StatelessWidget {
  final String subVal;
  final List<ChartModel> data;
  const CommonChart(this.subVal, this.data);

  @override
  Widget build(BuildContext context) {
    final List<CommonModel> commonData = [];

    if (subVal == "capital" || subVal == "total-sell" || subVal == "buy") {
      for (var i = 0; i < data.length; i++) {
        if (i < 4) {
          final String cD = data[i].day == null ? "" : data[i].day;
          final String cM = data[i].month == null ? "" : data[i].month;
          final String cY = data[i].year == null ? "" : data[i].year;

          commonData.add(CommonModel(
              cY + " " + cM + " " + cD, double.parse(data[i].total)));
        }
      }
    } else if (subVal == "item-profit" || subVal == "itemCat-profit" || subVal == "mostBuy-item" || subVal == "leastBuy-item") {
      for (var i = 0; i < data.length; i++) {
        if (i < 4) {
          commonData
              .add(CommonModel(data[i].name, double.parse(data[i].total)));
        }
      }
    } else if (subVal == "bestSellingItem" || subVal == "worstSellingItem" || subVal == "totalItem") {
      for (var i = 0; i < data.length; i++) {
        if (i < 4) {
          commonData
              .add(CommonModel(data[i].name, double.parse(data[i].qty)));
        }
      }
    } else if (subVal == "bestSellingItemCat" || subVal == "worstSellingItemCat") {
      for (var i = 0; i < data.length; i++) {
        if (i < 4) {
          commonData
              .add(CommonModel(data[i].catName, double.parse(data[i].qty)));
        }
      }
    } else if (subVal == "mostBuy-itemCat" || subVal == "leastBuy-itemCat") {
      for (var i = 0; i < data.length; i++) {
        if (i < 4) {
          commonData
              .add(CommonModel(data[i].catName, double.parse(data[i].total)));
        }
      }
    }

    List<charts.Series<CommonModel, String>> seriesList = [
      new charts.Series<CommonModel, String>(
        id: 'Desktop',
        domainFn: (CommonModel sales, _) => sales.data,
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
  final String data;
  final double total;

  CommonModel(this.data, this.total);
}
