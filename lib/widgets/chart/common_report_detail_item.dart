import 'package:bossi_pos/charts/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonReportDetailItem extends StatelessWidget {
  final String subVal;
  final ChartModel data;
  
  const CommonReportDetailItem(this.subVal, this.data);

  Widget _rightContent () {
    Widget _widget;
    if (subVal == "totalItem" || subVal == "mostItem" || subVal == "leastItem" || subVal == "damagedItem") {
      _widget = Text(data.qty,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          );     
    } else {
      _widget = Text(NumberFormat.currency(symbol: '').format(int.parse(data.total)),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          );
    }

    // if (subVal != "totalItem" && subVal != "mostItem" && subVal != "leastItem" && subVal != "damagedItem") {
    //   _widget = Text(NumberFormat.currency(symbol: '').format(int.parse(data.total)),
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    //       );
    // } else if (subVal == "totalItem" || subVal == "mostItem" || subVal == "leastItem" || subVal == "damagedItem") {
    //   _widget = Text(data.qty,
    //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    //       );      
    // } else {
    //   _widget = Text("");
    // }

    return _widget;
  }

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
          title: Text(subVal != "totalItem" && subVal != "mostItem" && subVal != "leastItem" && subVal != "damagedItem" ? y + " " + m + " " + d : data.name[0].toUpperCase() + data.name.substring(1)),
          // subtitle: Text(y + " " + m + " " + d),
          isThreeLine: false,
          trailing: _rightContent(),
          ),
    );
  }
}
