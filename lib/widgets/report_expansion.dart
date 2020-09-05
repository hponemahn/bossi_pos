import 'package:bossi_pos/screens/report_detail_screen.dart';
import 'package:flutter/material.dart';

class ReportExpansion extends StatelessWidget {
  final String title;
  final List subTitle;
  final IconData titleIcon;
  const ReportExpansion(this.title, this.titleIcon, this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 14.0,
      ),
      // color: Colors.redAccent,
      elevation: 20,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ExpansionTile(
        leading: Icon(
          titleIcon,
          color: Colors.black,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        children: subTitle.map((subT) {
          return Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: ListTile(
              leading:
                  Icon(Icons.arrow_right, color: Theme.of(context).accentColor),
              contentPadding: EdgeInsets.all(0),
              dense: false,
              isThreeLine: false,
              title: Text(
                subT,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.black87),
              ),
              onTap: () => Navigator.pushReplacementNamed(
                  context, ReportDetailScreen.routeName),
            ),
          );
        }).toList(),
      ),
    );
  }
}
