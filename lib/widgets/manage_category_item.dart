import 'package:bossi_pos/providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCategoryItem extends StatefulWidget {
  final String id;
  final String category;
  // final int qty;
  // final double price;

  const ManageCategoryItem(this.id, this.category);

  @override
  _ManageCategoryItemState createState() => _ManageCategoryItemState();
}

class _ManageCategoryItemState extends State<ManageCategoryItem> {
  Category _newEditCat = Category(
    id: null,
    category: null,
  );
  TextEditingController _textFieldController = TextEditingController();
  bool _isValid = false;

  TextField textField() {
    return TextField(
      controller: _textFieldController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "အမျိုးအစားအမည် ထည့်သွင်းပါ",
        labelText: "အမျိုးအစားအမည်",
        errorText: _isValid ? "အမျိုးအစားအမည် ထည့်သွင်းရန် လိုအပ်ပါသည်" : null,
      ),
    );
  }

  void _showEditDialog(BuildContext context, String id) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("အမျိုးအစား ပြင်ဆင်ရန်"),
          content: textField(),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("မလုပ်ပါ"),
              onPressed: () {
                _textFieldController.text = '';
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("ပြင်မည်"),
              onPressed: () {
                if (_textFieldController.text.isNotEmpty) {
                  setState(() => _isValid = false);
                  _newEditCat =
                      Category(id: id, category: _textFieldController.text);

                  Provider.of<Categories>(context, listen: false)
                      .edit(_newEditCat);
                  Navigator.of(context).pop();
                } else {
                  setState(() => _isValid = true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog(BuildContext context, String id) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("ဖျက်မှာ သေချာပါသလား?"),
          content: Text(
              "ဤကုန်ပစ္စည်း အမျိုးအစားကို ဖျက်လိုက်မည်ဆိုပါက ပြန်ရနိုင်တော့မည် မဟုတ်ပါ။​"),
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
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      elevation: 20,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: ListTile(
          title: Text(widget.category),
          // subtitle: Text(widget.id),
          // subtitle: Text("$qty Qty  -  $price MMK"),
          // subtitle: Text("အရေအတွက်: 25 | စျေးနှုန်း: 2,500"),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _textFieldController.text = widget.category;
                      _showEditDialog(context, widget.id);
                    }),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _showDialog(context, widget.id)),
              ],
            ),
          )),
    );
  }
}
