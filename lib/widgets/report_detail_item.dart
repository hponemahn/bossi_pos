import 'package:flutter/material.dart';

class ReportDetailItem extends StatelessWidget {
  final String total;
  final String day;
  final String month;
  final String year;
  const ReportDetailItem(this.total, this.day, this.month, this.year);

  @override
  Widget build(BuildContext context) {
    print("day $day");
    print("month $month");
    print("year $year");
    print(month == null ? "" : month);

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
          title: Text(total),
          subtitle: Text(y + " " + m + " " + d),
          isThreeLine: false,
          trailing: Text(
            "1000000000",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
    );
  }
}
