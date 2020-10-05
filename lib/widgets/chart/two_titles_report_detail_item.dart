import 'package:bossi_pos/charts/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TwoTitlesReportDetailItem extends StatelessWidget {
  final String subVal;
  final ChartModel data;

  const TwoTitlesReportDetailItem(this.subVal, this.data);

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
          title: Text(subVal == "bestSellingItemCat" || subVal == "worstSellingItemCat" || subVal == "mostBuy-itemCat" || subVal == "leastBuy-itemCat" ? data.catName[0].toUpperCase() + data.catName.substring(1) : data.name[0].toUpperCase() + data.name.substring(1)),
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
                    : 
                    NumberFormat.currency(symbol: '').format(int.parse(data.total)),
                    // double.parse(data.total).toStringAsFixed(2),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
