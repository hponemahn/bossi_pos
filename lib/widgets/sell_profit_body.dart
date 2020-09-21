import 'package:bossi_pos/charts/chart_model.dart';
import 'package:bossi_pos/charts/sell_profit.dart';
import 'package:bossi_pos/widgets/button_titled_container.dart';
import 'package:bossi_pos/widgets/sell_profit_item.dart';
import 'package:flutter/material.dart';

class SellProfitBody extends StatelessWidget {
  final String title;
  final String filterText;
  // final List<ChartModel> caps;
  final List<ChartModel> sales;
  final List<ChartModel> profits;
  const SellProfitBody(
      this.title, this.filterText, this.sales, this.profits);

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(slivers: <Widget>[
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ButtonTitledContainer(title, filterText,
              child: Container(height: 200, child: SellProfit(sales, profits))),
        ),
      ),
      SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("အရောင်း"),
                    Text("အမြတ်")
                    // Row(
                    //   // spacing: 12,
                    //   children: [
                    //     Text("အရောင်း"),
                    //     SizedBox(width: 18),
                    //     Text("|"),
                    //     SizedBox(width: 18),
                    //     Text("အမြတ်"),
                    //   ],
                    // )
                  ]))),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, i) {
          return SellProfitItem(sales[i].total, sales[i].day, sales[i].month,
              sales[i].year, profits);
        },
        childCount: sales.length,
      )),
      SliverToBoxAdapter(
        child: SizedBox(height: 20,),
      ),
    ]);
  }
}
