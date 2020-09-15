import 'package:bossi_pos/charts/chart_model.dart';
import 'package:flutter/material.dart';

class ReportDetailItem extends StatelessWidget {
  final String total;
  final String day;
  final String month;
  final String year;
  final List<ChartModel> sales;
  final List<ChartModel> profits;
  const ReportDetailItem(
      this.total, this.day, this.month, this.year, this.sales, this.profits);

  @override
  Widget build(BuildContext context) {

    final String d = day == null ? "" : day;
    final String m = month == null ? "" : month;
    final String y = year == null ? "" : year;
    String sTotal = "";
    String pTotal = "";

    sales.forEach((v) {
      final String sD = v.day == null ? "" : v.day;
      final String sM = v.month == null ? "" : v.month;
      final String sY = v.year == null ? "" : v.year;

      if (sM == m && sY == y && sD == d) {
        sTotal = v.total;
      }
    });

    profits.forEach((v) {
      final String pD = v.day == null ? "" : v.day;
      final String pM = v.month == null ? "" : v.month;
      final String pY = v.year == null ? "" : v.year;

      if (pM == m && pY == y && pD == d) {
        pTotal = v.total;
      }
    });

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 14.0,
      ),
      elevation: 20,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: ListTile(
          title: Text(double.parse(total).toStringAsFixed(2)),
          subtitle: Text(y + " " + m + " " + d),
          isThreeLine: false,
          trailing: 
          Wrap(
            spacing: 12,
            children: [
            Text(
            // double.parse(sTotal).toStringAsFixed(2),
            sTotal.isEmpty ? "" : double.parse(sTotal).toStringAsFixed(2),
            // style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          // Icon(Icons.perm_device_information),
          Text(pTotal.isEmpty ? "" : "|"),
            Text(
            // double.parse(sTotal).toStringAsFixed(2),
            pTotal.isEmpty ? "" : double.parse(pTotal).toStringAsFixed(2),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          ],)
          ),
    );
  }
}
