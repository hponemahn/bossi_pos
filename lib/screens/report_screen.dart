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
          ReportExpansion('အရင်း၊ အမြတ် နှင့် အရှုံး', Icons.account_balance,
              ['အရင်း၊ အမြတ် နှင့် အရှုံး', 'အရောင်း၀င်ငွေ စုစုပေါင်း']),
          ReportExpansion('အရောင်း', Icons.shopping_cart, [
            'အရောင်း စုစုပေါင်း',
            'ကုန်ပစ္စည်းအလိုက် အမြတ်စာရင်း',
            'ကုန်ပစ္စည်းအမျိုးအစားအလိုက် အမြတ်စာရင်း',
            'ကုန်ပစ္စည်းအလိုက် အရှုံးစာရင်း',
            'ကုန်ပစ္စည်းအမျိုးအစားအလိုက် အရှုံးစာရင်း',
            'ရောင်းအားအကောင်ဆုံး ကုန်ပစ္စည်း',
            'ရောင်းအားအကောင်ဆုံး အမျိုးအစား',
            'ရောင်းအားအနည်းဆုံး ကုန်ပစ္စည်း',
            'ရောင်းအားအနည်းဆုံး အမျိုးအစား'
          ]),
          ReportExpansion('အ၀ယ်', Icons.attach_money,
              // အရောင်း၀င်ငွေ စုစုပေါင်း
              [
                'အ၀ယ် စုစုပေါင်း',
                ' အ၀ယ်အများဆုံး ကုန်ပစ္စည်း',
                ' အ၀ယ်အများဆုံး အမျိုးအစား',
                ' အ၀ယ်အနည်းဆုံး ကုန်ပစ္စည်း',
                'အ၀ယ်အနည်းဆုံး အမျိုးအစား'
              ]),
          ReportExpansion('ကုန်ပစ္စည်း', Icons.store_mall_directory,
              // အရောင်း၀င်ငွေ စုစုပေါင်း
              [
                'ကုန်ပစ္စည်း စုစုပေါင်း',
                'အရေအတွက်နည်းနေသော ကုန်ပစ္စည်းစာရင်း',
                'အရေအတွက်များနေသော ကုန်ပစ္စည်းစာရင်း',
                'ပျက်စီးစာရင်း',
                'ပျောက်ဆုံးစာရင်း',
                'ဒိတ်လွန်နေသော ကုန်ပစ္စည်းစာရင်း'
              ]),
        ],
      ),
    );
  }
}
