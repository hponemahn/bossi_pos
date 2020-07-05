/// Bar chart with example of a legend with customized position, justification,
/// desired max rows, and padding. These options are shown as an example of how
/// to use the customizations, they do not necessary have to be used together in
/// this way. Choosing [end] as the position does not require the justification
/// to also be [endDrawArea].
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Example that shows how to build a datum legend that shows measure values.
///
/// Also shows the option to provide a custom measure formatter.
class BuySummary extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  BuySummary(this.seriesList, {this.animate});

  factory BuySummary.withSampleData() {
    return new BuySummary(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: true,
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

  /// Create series list with one series
  static List<charts.Series<Task, String>> _createSampleData() {
    final data = [
      new Task('Electronic', 15.8, Color(0xff3366cc)),
      new Task('Glocery', 10.3, Color(0xff990099)),
      new Task('Cloth', 8.8, Color(0xff109618)),
      new Task('Food', 35.8, Color(0xfffdbe19)),
      // new Task('Sleep', 19.2, Color(0xffff9900)),
      // new Task('Other', 10.3, Color(0xffdc3912)),
    ];

    return [
      new charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: data,
         labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    ];
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}