import 'package:bossi_pos/charts/buy_summary.dart';
import 'package:bossi_pos/charts/daily_sum.dart';
import 'package:bossi_pos/charts/net_earn.dart';
import 'package:bossi_pos/charts/net_earnings.dart';
import 'package:bossi_pos/charts/sales_summary.dart';
import 'package:bossi_pos/charts/stock.dart';
import 'package:bossi_pos/providers/cart.dart';
import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = "dashboard";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void didChangeDependencies() {
    Provider.of<Cart>(context).fetchOrderSevenData();
    Provider.of<Cart>(context).fetchNetData();
    Provider.of<Cart>(context).fetchLostData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('အစီရင်ခံစာ'),
      ),
      drawer: Drawlet(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildTitledContainer("နေ့လိုက်ရောင်းအား",
                  child: Container(
                      height: 200, child: DailySum())),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildTitledContainer("အရှုံး/အမြတ်",
                  child: Container(
                      height: 200, child: NetEarn())),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildTitledContainer("အရှုံး/အမြတ်",
                  child: Container(
                      height: 200, child: NetEarnings.withSampleData())),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildTitledContainer("အရောင်း",
                  child: Container(
                      height: 200, child: SalesSummary.withSampleData())),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildTitledContainer("ကုန်ပစ္စည်း",
                  child: Container(height: 200, child: Stock.withSampleData())),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildTitledContainer("အ၀ယ်",
                  child: Container(
                      height: 200, child: BuySummary.withSampleData())),
            ),
          ),
        ],
      ),
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
                child: Text('ပိုမိုသိရှိရန်', style: TextStyle(fontSize: 12, decoration: TextDecoration.underline,
                // decorationStyle: TextDecorationStyle.dotted,
                ),),
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
