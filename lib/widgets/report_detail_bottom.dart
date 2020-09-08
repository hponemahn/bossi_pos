import 'package:flutter/material.dart';

class ReportDetailButton extends StatelessWidget {
  const ReportDetailButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.blueGrey, width: 0.3)),
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.money_off,
              color: Theme.of(context).accentColor,
            ),
            Text("အရောင်း၀င်ငွေ စုစုပေါင်း   -   ",
                style: TextStyle(fontSize: 17.0)),
            Text("10000000000",
                style: TextStyle(fontSize: 17.0, color: Colors.grey[800])),
          ],
        ));
  }
}
