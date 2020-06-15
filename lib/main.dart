import 'package:bossi_pos/page/auth.dart';
import 'package:bossi_pos/page/home.dart';
import 'package:bossi_pos/page/login.dart';
import 'package:bossi_pos/page/register.dart';
import 'package:bossi_pos/providers/cart.dart';
import 'package:bossi_pos/providers/categories.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/screens/cart_screen.dart';
import 'package:bossi_pos/screens/manage_products_screen.dart';
import 'package:bossi_pos/screens/order_screen.dart';
import 'package:bossi_pos/screens/product_edit_screen.dart';
import 'package:bossi_pos/screens/sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql/client_provider.dart';

final String graphQLEndpoint = 'http://172.10.0.195:8000/graphql';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(providers: [
    //   ChangeNotifierProvider.value(value: Products()),
    //   ChangeNotifierProvider.value(value: Cart()),
    //   ChangeNotifierProvider.value(value: Categories()),
    // ],child: MaterialApp(
    //   theme: ThemeData(
    //         primaryColor: Colors.purple[800],
    //         accentColor: Colors.amber,
    //         accentColorBrightness: Brightness.light,
    //         // fontFamily: 'Roboto',
    //         textTheme: TextTheme(
    //             // headline:    TextStyle(fontSize: 36px, ... ),
    //             // title:       TextStyle(fontSize: 24px, ... ),
    //             // body:        TextStyle(fontSize: 12px, ... ),
    //             button: TextStyle(color: Colors.black, fontSize: 17),
    //             ),
    //       ),
    //   home: SellScreen(),
    //   routes: {
    //     CartScreen.routeName: (ctx) => CartScreen(),
    //     OrderScreen.routeName: (ctx) => OrderScreen(),
    //     ManageProductsScreen.routeName: (ctx) => ManageProductsScreen(),
    //     ProductEditScreen.routeName: (ctx) => ProductEditScreen(),
    //   },
    // ),);

    return ClientProvider(
      uri: graphQLEndpoint,
      // subscriptionUri: SUBSCRIPTION_ENDPOINT,
      child: CacheProvider(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: Products()),
            ChangeNotifierProvider.value(value: Cart()),
            ChangeNotifierProvider.value(value: Categories()),
          ],
          child: MaterialApp(
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
            home: LoginPage(),
            routes: {
              CartScreen.routeName: (ctx) => CartScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              ManageProductsScreen.routeName: (ctx) => ManageProductsScreen(),
              ProductEditScreen.routeName: (ctx) => ProductEditScreen(),
              '/login': (context) => LoginPage(),
              '/register': (context) => RegisterPage(),
              '/sellscreen': (context) => SellScreen(),
              '/auth': (context) => AuthPage(),
              '/home': (context) => HomePage(),
            },
          ),
        ),
      ),
    );
  }
}
