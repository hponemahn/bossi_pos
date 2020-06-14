import 'package:bossi_pos/providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCategoryItem extends StatelessWidget {
  final String id;
  final String category;
  // final int qty;
  // final double price;

  const ManageCategoryItem(this.id, this.category);

  void _showDialog(BuildContext context, String id) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("ဖျက်မှာ သေချာပါသလား?"),
          content: Text("ဤကုန်ပစ္စည်း အမျိုးအစားကို ဖျက်လိုက်မည်ဆိုပါက ပြန်ရနိုင်တော့မည် မဟုတ်ပါ။​"),
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
                Provider.of<Categories>(context, listen: false).delete(id);
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
        title: Text(category),
        // subtitle: Text("$qty Qty  -  $price MMK"),
        // subtitle: Text("အရေအတွက်: 25 | စျေးနှုန်း: 2,500"),
        trailing: Container(
          width: 100,
          child: Row(
          children: [
            IconButton(icon: Icon(Icons.edit),onPressed: () => 
            // Navigator.pushNamed(context, CategoryEditScreen.routeName, arguments: id),
            print(id),
            ),
            IconButton(icon: Icon(Icons.delete),onPressed: () => _showDialog(context, id)),
          ],
        ),
        )
      ),
    );
  }
}