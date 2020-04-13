import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:bossi_pos/widgets/sell_body.dart';
import 'package:bossi_pos/widgets/sell_bottom.dart';
import 'package:flutter/material.dart';

class SellScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Ready Shop"),
      ),
      body: SellBody(),
      drawer: Drawlet(),
      bottomNavigationBar: SellBottom(),
    );
  }
}