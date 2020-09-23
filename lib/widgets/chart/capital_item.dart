import 'package:flutter/material.dart';

class CapitalItem extends StatelessWidget {
  final String total;
  final String day;
  final String month;
  final String year;
  
  const CapitalItem(
      this.total, this.day, this.month, this.year);

  @override
  Widget build(BuildContext context) {

    final String d = day == null ? "" : day;
    final String m = month == null ? "" : month;
    final String y = year == null ? "" : year;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 14.0,
      ),
      elevation: 20,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: ListTile(
          // title: Text(double.parse(total).toStringAsFixed(2)),
          title: Text(y + " " + m + " " + d),
          // subtitle: Text(y + " " + m + " " + d),
          isThreeLine: false,
          trailing: Text(
            total.isEmpty ? "" : double.parse(total).toStringAsFixed(2),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          ),
    );
  }
}
