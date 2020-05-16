import 'package:bossi_pos/page/login.dart';
import 'package:bossi_pos/screens/manage_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bossi_pos/graphql/utils.dart' as utils;

class Drawlet extends StatelessWidget {
  const Drawlet({Key key}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
   final FacebookLogin facebookSignIn = new FacebookLogin();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool _isLoggedIn;
    Widget _createHeader() {
      return DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage('assets/drawer.jpg'))),
          child: Stack(children: <Widget>[
            Positioned(
                bottom: 12.0,
                left: 16.0,
                child: Text("BossiPOS",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500))),
          ])
          );
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          _createHeader(),
          SizedBox(height: 30,),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("မူလ"),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.featured_play_list),
          //   title: Text("အရောင်းအ၀ယ်များ"),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/transaction');
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.report),
          //   title: Text("အစီရင်ခံစာ"),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/dashboard');
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text("ကုန်ပစ္စည်းများ"),
            onTap: () {
              Navigator.pushReplacementNamed(context, ManageProductsScreen.routeName);
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.category),
          //   title: Text("အမျိုးအစားများ"),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/category');
          //   },
          // ),

          ListTile(
            leading: Icon(Icons.lock_open),
            title: Text("Logout"),
            onTap: () async{
               _googleSignIn.signOut();
                await facebookSignIn.logOut();
                _isLoggedIn = false;
                utils.name = "";
                utils.accessToken = "";
                utils.email = "";
              // Navigator.pushReplacementNamed(context, ManageProductsScreen.routeName);
              Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage()));
            },
          ),
        
        ],
      ),
    );
  }
}
