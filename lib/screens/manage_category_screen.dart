import 'package:bossi_pos/graphql/graphQLConf.dart';
import 'package:bossi_pos/graphql/graphql_string.dart';
import 'package:bossi_pos/providers/categories.dart';
import 'package:bossi_pos/widgets/drawlet.dart';
import 'package:bossi_pos/widgets/manage_category_item.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class ManageCategoryScreen extends StatefulWidget {
  static const routeName = "manage_category";

  @override
  _ManageCategoryScreenState createState() => _ManageCategoryScreenState();
}

class _ManageCategoryScreenState extends State<ManageCategoryScreen> {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  String _searchText = "";
  Category _newEditCat = Category(
    id: null,
    category: null,
  );
  TextEditingController _textFieldController = TextEditingController();
  bool _isValid = false;
  QueryResult resultData;

  Future<QueryResult> getdata() async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    return resultData = await _client.query(QueryOptions(
      documentNode: gql(categories),
    ));
    // return resultData.data['categories']['name'].toString();
  }

  // Widget _productListView(cats) {
  //   if (_searchText.isNotEmpty) {
  //     List tempList = new List();
  //     for (int i = 0; i < cats.length; i++) {
  //       if (cats[i]
  //           .category
  //           .toLowerCase()
  //           .contains(_searchText.toLowerCase())) {
  //         tempList.add(cats[i]);
  //       }
  //     }
  //     cats = tempList;
  //   }

  //   return Expanded(
  //     child: ListView.builder(
  //         padding: EdgeInsets.all(10),
  //         shrinkWrap: true,
  //         itemCount: cats.length,
  //         itemBuilder: (ctx, i) =>
  //             // Text(cats[i].category),
  //             ManageCategoryItem(cats[i].id, cats[i].category)),
  //   );
  // }

  Widget _productListView() {
    return Query(
        options: QueryOptions(
          documentNode:
              gql(categories), // this is the query string you just created
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.loading) {
            return Text('Loading....');
          }
          List repositories = result.data['categories'];
          return Expanded(
            child: ListView.builder(
                itemCount: repositories.length,
                itemBuilder: (contex, index) => ManageCategoryItem(
                    result.data['categories'][index]['id'],
                    result.data['categories'][index]['name'])),
          );
        });
  }

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
              onPressed: () async {
                if (_textFieldController.text.isNotEmpty) {
                  GraphQLClient _client = graphQLConfiguration.clientToQuery();
                  QueryResult resultData = await _client.mutate(
                    MutationOptions(
                        documentNode: gql(categoryInsert),
                        variables: {
                          "name": _textFieldController.text,
                        }),
                  );

                  // setState(() => _isValid = false);

                  _newEditCat = Category(
                      id: _newEditCat.id, category: _textFieldController.text);

                  Provider.of<Categories>(context, listen: false)
                      .add(_newEditCat);
                  _textFieldController.text = '';

                  if (resultData.data != null) {
                    setState(() => _isValid = false);
                    Navigator.of(context).pop();
                  } else {
                    setState(() => _isValid = true);
                  }
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

    print("cat screen");

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
            _productListView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // Navigator.pushNamed(context, CategoryEditScreen.routeName),
            _showDialog(context);
          }),
    );
  }
}
