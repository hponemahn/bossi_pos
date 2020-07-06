import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:bossi_pos/providers/categories.dart';
import 'package:bossi_pos/screens/manage_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bossi_pos/graphql/graphql_string.dart';

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
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

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
      keyboardType: TextInputType.text,
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
              onPressed: () async {
                if (_textFieldController.text.isNotEmpty) {
                  setState(() => _isValid = false);
                  GraphQLClient _client = graphQLConfiguration.clientToQuery();
                  QueryResult resultData = await _client.mutate(
                  MutationOptions(
                      documentNode: gql(updateCategory),
                      variables: {
                        "id": id,
                        "name":_textFieldController.text.toString()
                      }),
                );

                  // _newEditCat =
                  //     Category(id: id, category: _textFieldController.text);

                  // Provider.of<Categories>(context, listen: false)
                  //     .edit(_newEditCat);
                  Navigator.pushReplacementNamed(context, ManageCategoryScreen.routeName);
                  // Navigator.of(context).pop(context);
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
              onPressed: () async {
                print(id);
                GraphQLClient _client = graphQLConfiguration.clientToQuery();
                QueryResult resultData = await _client.mutate(
                  MutationOptions(
                      documentNode: gql(deleteCategory),
                      variables: {
                        "id": int.parse(id),
                      }),
                );
                // Provider.of<Categories>(context, listen: false).delete(id);
                if (resultData.data != null) {
                  Navigator.pushReplacementNamed(context, ManageCategoryScreen.routeName);
                  // Navigator.of(context).pop();
                }
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
      child: ListTile(
          title: Text(widget.category),
          // subtitle: Text("$qty Qty  -  $price MMK"),
          // subtitle: Text("အရေအတွက်: 25 | စျေးနှုန်း: 2,500"),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navigator.pushNamed(context, CategoryEditScreen.routeName, arguments: id),
                      // print(id),
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
