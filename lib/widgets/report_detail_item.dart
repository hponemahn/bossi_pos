import 'package:bossi_pos/charts/chart_model.dart';
import 'package:flutter/material.dart';

class ReportDetailItem extends StatelessWidget {
  final String total;
  final String day;
  final String month;
  final String year;
  final List<ChartModel> profits;
  const ReportDetailItem(
      this.total, this.day, this.month, this.year, this.profits);

  @override
  Widget build(BuildContext context) {
    final String d = day == null ? "" : day;
    final String m = month == null ? "" : month;
    final String y = year == null ? "" : year;
    String pTotal = "";

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
          title: Text(total),
          subtitle: Text(y + " " + m + " " + d),
          isThreeLine: false,
          trailing: Text(
            pTotal,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
    );
  }
}
