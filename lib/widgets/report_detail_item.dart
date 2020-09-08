import 'package:flutter/material.dart';

class ReportDetailItem extends StatelessWidget {
  const ReportDetailItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 14.0,
      ),
      elevation: 20,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: ListTile(
          title: Text("100,000"),
          subtitle: Text("Jan, 2018"),
          isThreeLine: false,
          trailing: Text(
            "1000000000",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
    );
  }
}
