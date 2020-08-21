import 'package:bossi_pos/charts/stock_model.dart';
import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class StockSum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<StockModel> _stockModelData =
        Provider.of<Cart>(context, listen: false).getStockData;

    List<charts.Series<StockModel, String>> series = [
      charts.Series<StockModel, String>(
          id: 'Sales',
          domainFn: (StockModel sales, _) => sales.name,
          measureFn: (StockModel sales, _) => double.parse(sales.total),
          data: _stockModelData,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (StockModel sales, _) =>
              '${sales.name}:   ${sales.total.toString()}')
    ];

    return charts.BarChart(
      series,
      animate: false,
      animationDuration: Duration(seconds: 5),
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }
}
