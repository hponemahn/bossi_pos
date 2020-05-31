import 'package:bossi_pos/graphql/graphql_string.dart';
import 'package:bossi_pos/page/register.dart';
import 'package:bossi_pos/screens/sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bossi_pos/graphql/utils.dart' as utils;
import 'package:splashscreen/splashscreen.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/auth';
  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  dynamic _redirectPage;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
          options: QueryOptions(
            documentNode: gql(checkEmail),
            variables: {"email": utils.email},
            pollInterval: 10,
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.loading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF7C300)),
                ),
              );
            }
            if (result.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF7C300)),
                ),
              );
            } else {
              print(utils.email);
              if (result.data['emailuser'] != null) {
                _redirectPage = new SellScreen();
              } else {
                _redirectPage = new RegisterPage();
              }
            }
            return new SplashScreen(
                seconds: 1,
                navigateAfterSeconds: _redirectPage,
                backgroundColor: Colors.white,
                styleTextUnderTheLoader: new TextStyle(),
                photoSize: 140.0,
                loaderColor: Colors.red);
          }),
    );
  }
}
