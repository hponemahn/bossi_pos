import 'package:flutter/material.dart';

class ReportExpansion extends StatelessWidget {
  final String title;
  final List subTitle;
  const ReportExpansion(this.title, this.subTitle);

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
        leading: Icon(Icons.attach_money),
        title: Text(title),
        children: subTitle.map((subT) {
          return Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: ListTile(
              leading: Icon(Icons.arrow_right, color: Colors.deepOrange),
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
              onTap: () => print("tap 1"),
            ),
          );
        }).toList(),

        // [

        //   Padding(
        //     padding: const EdgeInsets.only(left: 32.0),
        //     child: ListTile(
        //       leading: Icon(Icons.arrow_right, color: Colors.deepOrange),
        //       contentPadding: EdgeInsets.all(0),
        //       dense: false,
        //       isThreeLine: false,
        //       title: Text(
        //         "အရင်း၊ အမြတ် နှင့် အရှုံး",
        //         style: Theme.of(context)
        //             .textTheme
        //             .subtitle1
        //             .copyWith(color: Colors.black87),
        //       ),
        //       onTap: () => print("tap 1"),
        //     ),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.only(left: 32.0),
        //     child: ListTile(
        //       leading: Icon(Icons.arrow_right, color: Colors.deepOrange),
        //       contentPadding: EdgeInsets.all(0),
        //       dense: false,
        //       isThreeLine: false,
        //       title: Text(
        //         "အရောင်း၀င်ငွေ စုစုပေါင်း",
        //         style: Theme.of(context)
        //             .textTheme
        //             .subtitle1
        //             .copyWith(color: Colors.black87),
        //       ),
        //       onTap: () => print("tap 1"),
        //     ),
        //   )
        // ]
      ),
    );
  }
}
