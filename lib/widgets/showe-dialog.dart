import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showLoading(context) {
      print("Loading");
      showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Please Wait.'),
            content: Container(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    }

 void showLongToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
            toastLength: Toast.LENGTH_LONG,
          // gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white
    );
  }