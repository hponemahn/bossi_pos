import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:bossi_pos/widgets/report_expansion.dart';
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
          ReportExpansion('အရင်း၊ အမြတ်', Icons.account_balance, [
            {"subTile": 'အရင်း ငွေစုစုပေါင်း', "subVal": "capital"},
            {"subTile": 'အရောင်း၊ အမြတ် ငွေစုစုပေါင်း', "subVal": "sell&profit"},
          ]),
          ReportExpansion('အရောင်း', Icons.shopping_cart, [
            {"subTile": 'အရောင်း စုစုပေါင်း', "subVal": "total-sell"},
            {"subTile": 'ကုန်ပစ္စည်းအလိုက် အမြတ်', "subVal": "item-profit"},
            {"subTile": 'ကုန်ပစ္စည်းအမျိုးအစားအလိုက် အမြတ်', "subVal": "itemCat-profit"},
            {"subTile": 'ရောင်းအားအကောင်ဆုံး ကုန်ပစ္စည်း', "subVal": "bestSellingItem"},
            {"subTile": 'ရောင်းအားအကောင်ဆုံး အမျိုးအစား', "subVal": "bestSellingItemCat"},
            {"subTile": 'ရောင်းအားအနည်းဆုံး ကုန်ပစ္စည်း', "subVal": "worstSellingItem"},
            {"subTile": 'ရောင်းအားအနည်းဆုံး အမျိုးအစား', "subVal": "worstSellingItemCat"}
          ]),
          ReportExpansion('အ၀ယ်', Icons.attach_money,
              // အရောင်း၀င်ငွေ စုစုပေါင်း
              [
                {"subTile": 'အ၀ယ် စုစုပေါင်း', "subVal": "buy"},
                {"subTile": 'အ၀ယ်တန်ဖိုး အများဆုံး ကုန်ပစ္စည်း', "subVal": "mostBuy-item"},
                {"subTile": 'အ၀ယ်တန်ဖိုး အများဆုံး အမျိုးအစား', "subVal": "mostBuy-itemCat"},
                {"subTile": 'အ၀ယ်တန်ဖိုး အနည်းဆုံး ကုန်ပစ္စည်း'},
                {"subTile": 'အ၀ယ်တန်ဖိုး အနည်းဆုံး အမျိုးအစား'}
              ]),
          ReportExpansion('ကုန်ပစ္စည်း', Icons.store_mall_directory,
              // အရောင်း၀င်ငွေ စုစုပေါင်း
              [
                {"subTile": 'ကုန်ပစ္စည်း စုစုပေါင်း'},
                {"subTile": 'အရေအတွက်နည်းနေသော ကုန်ပစ္စည်း'},
                {"subTile": 'အရေအတွက်များနေသော ကုန်ပစ္စည်း'},
                {"subTile": 'ပျက်စီး'},
                {"subTile": 'ပျောက်ဆုံး'},
                {"subTile": 'ဒိတ်လွန်နေသော ကုန်ပစ္စည်း'}
              ]),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
