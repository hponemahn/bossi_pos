import 'package:bossi_pos/charts/ordinal_sales_model.dart';
import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class DailySum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<OrdinalSalesModel> _ordinalSalesData =
        Provider.of<Cart>(context, listen: false).getOrdinalSaleData;

    List<charts.Series<OrdinalSalesModel, String>> series = [
      new charts.Series<OrdinalSalesModel, String>(
          id: 'Sales',
          domainFn: (OrdinalSalesModel sales, _) => sales.orderDate,
          measureFn: (OrdinalSalesModel sales, _) => double.parse(sales.total),
          data: _ordinalSalesData,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (OrdinalSalesModel sales, _) =>
              '${sales.total.toString()}')
    ];

    return charts.BarChart(
      series,
      animate: false,
      animationDuration: Duration(seconds: 5),
      // Set a bar label decorator.
      // Example configuring different styles for inside/outside:
      //       barRendererDecorator: new charts.BarLabelDecorator(
      //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
      //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis: new charts.OrdinalAxisSpec(),
    );
  }
}
