import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  static const routeName = "report";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("အစီရင်ခံစာ"),
      ),
      drawer: Drawlet(),
      body: ListView(
        padding: const EdgeInsets.only(top: 16),
        // physics: BouncingScrollPhysics(),
        children: [
          Card(
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
                leading: Icon(Icons.power),
                title: Text('အရင်း၊ အမြတ် နှင့် အရှုံး'),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: ListTile(
                      leading:
                          Icon(Icons.arrow_right, color: Colors.deepOrange),
                      contentPadding: EdgeInsets.all(0),
                      dense: false,
                      isThreeLine: false,
                      // trailing: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: <Widget>[
                      //     IconButton(
                      //       icon: Icon(Icons.code),
                      //       onPressed: null,
                      //     ),
                      //   ],
                      // ),
                      title: Text(
                        "next line",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.black87),
                      ),
                      onTap: () => print("tap 1"),
                    ),
                  )
                ]),
          ),
          Card(
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
                leading: Icon(Icons.power),
                title: Text('အရင်း၊ အမြတ် နှင့် အရှုံး'),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: ListTile(
                      leading:
                          Icon(Icons.arrow_right, color: Colors.deepOrange),
                      contentPadding: EdgeInsets.all(0),
                      dense: false,
                      isThreeLine: false,
                      // trailing: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: <Widget>[
                      //     IconButton(
                      //       icon: Icon(Icons.code),
                      //       onPressed: null,
                      //     ),
                      //   ],
                      // ),
                      title: Text(
                        "next line",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.black87),
                      ),
                      onTap: () => print("tap"),
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
