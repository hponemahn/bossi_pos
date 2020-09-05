import 'package:bossi_pos/charts/buy_sum.dart';
import 'package:bossi_pos/charts/daily_sum.dart';
import 'package:bossi_pos/charts/net_earn.dart';
import 'package:bossi_pos/charts/sale_sum.dart';
import 'package:bossi_pos/charts/stock_sum.dart';
import 'package:bossi_pos/widgets/button_titled_container.dart';
import 'package:flutter/material.dart';

class DashboardBodyScreen extends StatelessWidget {
  const DashboardBodyScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer("နေ့လိုက်ရောင်းအား",
                child: Container(height: 200, child: DailySum())),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer("အရှုံး/အမြတ်",
                child: Container(height: 200, child: NetEarn())),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer("အရောင်း",
                child: Container(height: 200, child: SaleSum())),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer("ကုန်ပစ္စည်း",
                child: Container(height: 200, child: StockSum())),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            // child: _buildTitledContainer("အ၀ယ်",
            //     child: Container(height: 200, child: BuySum())),
            child: ButtonTitledContainer("အ၀ယ်",
                child: Container(height: 200, child: BuySum())),
          ),
        ),
      ],
    );
  }

  Container _buildTitledContainer(String title, {Widget child, double height}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
              GestureDetector(
                child: Text(
                  'ပိုမိုသိရှိရန်',
                  style: TextStyle(
                    fontSize: 12, decoration: TextDecoration.underline,
                    // decorationStyle: TextDecorationStyle.dotted,
                  ),
                ),
                onTap: () {
                  print('show more');
                },
              ),
            ],
          ),
          // Text(
          //   title,
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
          // ),
          // if (child != null) ...[const SizedBox(height: 10.0), child]
          child != null ? SizedBox(height: 10.0) : '',
          child != null ? child : '',
        ],
      ),
    );
  }
}
