import 'package:bossi_pos/screens/manage_products_screen.dart';
import 'package:flutter/material.dart';

class Drawlet extends StatelessWidget {
  const Drawlet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        
        ],
      ),
    );
  }
}
