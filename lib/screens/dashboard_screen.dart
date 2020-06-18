import 'package:bossi_pos/charts/daily_summary.dart';
import 'package:bossi_pos/charts/net_earnings.dart';
import 'package:bossi_pos/charts/sales_summary.dart';
import 'package:bossi_pos/charts/stock.dart';
import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = "dashboard";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: Drawlet(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer("Daily Summary",
                child: Container(
                    height: 200, child: DailySummary.withSampleData())),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer("Net Earnings",
                child: Container(
                    height: 200, child: NetEarnings.withSampleData())),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer("Sales Summary",
                child: Container(
                    height: 200, child: SalesSummary.withSampleData())),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer("Stock",
                child: Container(
                    height: 200, child: Stock.withSampleData())),
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
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
          ),
          // if (child != null) ...[const SizedBox(height: 10.0), child]
          child != null ? SizedBox(height: 10.0) : '',
          child != null ? child : '',
        ],
      ),
    );
  }
}