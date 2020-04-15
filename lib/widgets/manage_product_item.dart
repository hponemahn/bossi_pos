import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/screens/product_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductItem extends StatelessWidget {
  final String id;
  final String name;
  final int qty;
  final double price;

  const ManageProductItem(this.id, this.name, this.qty, this.price);

  void _showDialog(BuildContext context, String id) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("ဖျက်မှာ သေချာပါသလား?"),
          content: Text("ဤကုန်ပစ္စည်းကို ဖျက်လိုက်မည်ဆိုပါက ပြန်ရနိုင်တော့မည် မဟုတ်ပါ။​"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("မလုပ်ပါ"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("ဖျက်မည်"),
              onPressed: () {
                Provider.of<Products>(context, listen: false).delete(id);
                Navigator.of(context).pop();
                // Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text("$qty Qty  -  $price MMK"),
        // subtitle: Text("အရေအတွက်: 25 | စျေးနှုန်း: 2,500"),
        trailing: Container(
          width: 100,
          child: Row(
          children: [
            IconButton(icon: Icon(Icons.edit),onPressed: () => Navigator.pushNamed(context, ProductEditScreen.routeName, arguments: id),),
            IconButton(icon: Icon(Icons.delete),onPressed: () => _showDialog(context, id)),
          ],
        ),
        )
      ),
    );
  }
}