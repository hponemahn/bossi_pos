import 'package:bossi_pos/charts/task_model.dart';
import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class SaleSum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<TaskModel> _netData =
        Provider.of<Cart>(context, listen: false).getSaleData;

    print("sale summ build");

    List<charts.Series<TaskModel, String>> series = [
      charts.Series(
        domainFn: (TaskModel task, _) => task.task,
        measureFn: (TaskModel task, _) => task.taskvalue,
        colorFn: (TaskModel task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: _netData,
        labelAccessorFn: (TaskModel row, _) => '${row.taskvalue}',
      )
    ];

    return charts.PieChart(series,
        animate: false,
        animationDuration: Duration(seconds: 5),
        behaviors: [
          new charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.endDrawArea,
            horizontalFirst: false,
            desiredMaxRows: 2,
            cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.purple.shadeDefault,
                fontFamily: 'Georgia',
                fontSize: 11),
          )
        ],
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 100,
            arcRendererDecorators: [
              new charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.inside)
            ]));
  }
}
