import 'package:bossi_pos/providers/categories.dart';
import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:bossi_pos/widgets/manage_category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCategoryScreen extends StatefulWidget {
  static const routeName = "manage_category";

  @override
  _ManageCategoryScreenState createState() => _ManageCategoryScreenState();
}

class _ManageCategoryScreenState extends State<ManageCategoryScreen> {
  String _searchText = "";
  Category _newEditCat = Category(
    id: null,
    category: null,
  );
  TextEditingController _textFieldController = TextEditingController();

  Widget _productListView(cats) {
    if (_searchText.isNotEmpty) {
      List tempList = new List();
      for (int i = 0; i < cats.length; i++) {
        if (cats[i]
            .category
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(cats[i]);
        }
      }
      cats = tempList;
    }

    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          itemCount: cats.length,
          itemBuilder: (ctx, i) =>
              // Text(cats[i].category),
              ManageCategoryItem(cats[i].id, cats[i].category)),
    );
  }

  TextField textField() {
    return TextField(
      controller: _textFieldController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: "အမျိုးအစားအမည် ထည့်သွင်းပါ",
        labelText: "အမျိုးအစားအမည်",
      ),
    );
  }

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("အမျိုးအစားအသစ် ထည့်ရန်"),
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
              child: Text("ထည့်မည်"),
              onPressed: () {
                
                _newEditCat = Category(id: _newEditCat.id, category: _textFieldController.text);

                Provider.of<Categories>(context, listen: false)
                    .add(_newEditCat);
                _textFieldController.text = '';
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
    List<Category> _cats = Provider.of<Categories>(context).categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text("အမျိုးအစား စာရင်း"),
      ),
      drawer: const Drawlet(),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _searchText = val;
                  });
                },
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search),
                    hintText: 'အမည်ဖြင့် ရှာရန် ...'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _productListView(_cats),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            // Navigator.pushNamed(context, CategoryEditScreen.routeName),
            _showDialog(context),
      ),
    );
  }
}
