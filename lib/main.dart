import 'package:bossi_pos/print/print_screen.dart';
import 'package:bossi_pos/providers/cart.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/screens/cart_screen.dart';
import 'package:bossi_pos/screens/order_screen.dart';
import 'package:bossi_pos/screens/sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: Products()),
      ChangeNotifierProvider.value(value: Cart()),
    ],child: MaterialApp(
      theme: ThemeData(
            primaryColor: Colors.purple[800],
            accentColor: Colors.amber,
            accentColorBrightness: Brightness.light,
            // fontFamily: 'Roboto',
            textTheme: TextTheme(
                // headline:    TextStyle(fontSize: 36px, ... ),
                // title:       TextStyle(fontSize: 24px, ... ),
                // body:        TextStyle(fontSize: 12px, ... ),
                button: TextStyle(color: Colors.black, fontSize: 17),
                ),
          ),
      home: SellScreen(),
      routes: {
        CartScreen.routeName: (ctx) => CartScreen(),
        OrderScreen.routeName: (ctx) => OrderScreen(),
        PrintScreen.routeName: (ctx) => PrintScreen(),
      },
    ),);

  }
}

