import 'package:flutter/material.dart';

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