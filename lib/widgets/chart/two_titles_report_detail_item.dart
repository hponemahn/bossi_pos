import 'package:bossi_pos/charts/chart_model.dart';
import 'package:flutter/material.dart';

class TwoTitlesReportDetailItem extends StatelessWidget {
  final ChartModel data;

  const TwoTitlesReportDetailItem(this.data);

  @override
  Widget build(BuildContext context) {
    final String d = data.day == null ? "" : data.day;
    final String m = data.month == null ? "" : data.month;
    final String y = data.year == null ? "" : data.year;

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
          title: Text(data.name),
          subtitle: Text(y + " " + m + " " + d),
          isThreeLine: false,
          trailing: Wrap(
            children: [
              Text(
                data.qty.isEmpty ? "" : data.qty.toString(),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 18),
              Text(
                data.total.isEmpty
                    ? ""
                    : double.parse(data.total).toStringAsFixed(2),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
