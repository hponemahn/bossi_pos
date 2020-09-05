import 'package:flutter/material.dart';

class ButtonTitledContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final double height;

  ButtonTitledContainer(this.title, {this.child, this.height});

  @override
  Widget build(BuildContext context) {
    // final double height = 200;
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
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
            ],
          ),
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
