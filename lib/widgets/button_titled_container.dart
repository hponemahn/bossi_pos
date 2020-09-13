import 'package:flutter/material.dart';

class ButtonTitledContainer extends StatelessWidget {
  final String title;
  final String filterText;
  final Widget child;
  final double height;

  ButtonTitledContainer(this.title, this.filterText, {this.child, this.height});

  @override
  Widget build(BuildContext context) {

    String _filterTitle;

    if (filterText == "d") {
      _filterTitle = "ရက်အလိုက် ";
    } else if (filterText == "y") {
      _filterTitle = "နှစ်အလိုက် ";
    } else {
      _filterTitle = "လအလိုက် ";
    }

    // final double height = 200;
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$_filterTitle $title",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          // Text(
          //   title,
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          // ),
          // GestureDetector(
          //   child: Text(
          //     'ပိုမိုသိရှိရန်',
          //     style: TextStyle(
          //       fontSize: 12, decoration: TextDecoration.underline,
          //       // decorationStyle: TextDecorationStyle.dotted,
          //     ),
          //   ),
          //   onTap: () {
          //     print('show more');
          //   },
          // ),
          //   ],
          // ),
          // Text(
          //   title,
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
          // ),
          // if (child != null) ...[const SizedBox(height: 10.0), child]
          child != null ? SizedBox(height: 10.0) : '',
          child != null ? child : '',
        ],
      ),
    );
  }
}
