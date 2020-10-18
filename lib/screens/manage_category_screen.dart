import 'package:bossi_pos/providers/categories.dart';
import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:bossi_pos/widgets/manage_cats_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCategoryScreen extends StatefulWidget {
  static const routeName = "manage_category";

  @override
  _ManageCategoryScreenState createState() => _ManageCategoryScreenState();
}

class _ManageCategoryScreenState extends State<ManageCategoryScreen> {
  
  var _isInit = true;
  var _isLoading = false;
  Category _newEditCat = Category(
    id: null,
    category: null,
  );
  TextEditingController _textFieldController = TextEditingController();
  bool _isValid = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Categories>(context).fetchCats().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
                if (_textFieldController.text.isNotEmpty) {
                  
                  setState(() => _isValid = false);

                  _newEditCat = Category(
                      id: _newEditCat.id, category: _textFieldController.text);

                  Provider.of<Categories>(context, listen: false)
                      .add(_newEditCat);
                  _textFieldController.text = '';
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

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("အမျိုးအစား စာရင်း"),
      ),
      drawer: const Drawlet(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ManageCatsBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            // Navigator.pushNamed(context, CategoryEditScreen.routeName),
            _showDialog(context),
      ),
    );
  }
}
