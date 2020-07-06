import 'dart:convert';
import 'dart:io';

import 'package:bossi_pos/graphql/graphQLConf.dart';
import 'package:bossi_pos/screens/sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:bossi_pos/widgets/showe-dialog.dart';
import 'package:bossi_pos/graphql/graphql_string.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bossi_pos/graphql/utils.dart' as utils;
import 'package:multiselect_formfield/multiselect_formfield.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  _RegisterState createState() => new _RegisterState();
}

class Category {
  String id;
  String name;

  getid() => this.id;
  getName() => this.name;

  setId(String value) {
    this.id = value;
  }

  setName(String value) {
    this.name = value;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class _RegisterState extends State<RegisterPage> {
   GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  String msg;
  var _nameController = new TextEditingController();
  var _shopController = new TextEditingController();
  var _emailController = new TextEditingController();
  var _phoneController = new TextEditingController();
  var _addController = new TextEditingController();
  var _password = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List _myActivities;
  String _myActivitiesResult;
  List<Category> _category = [];
  List catLists;

  Color selected_color = Colors.green;
  Color default_color = Colors.transparent;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
    categoryList(context);
  }

  void categoryList(context) async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult resultCat = await _client.query(QueryOptions(
      documentNode: gql(category),
    ));

    var jsonString = utils.getPrettyJSONString(resultCat.data);
    final temp = jsonDecode(jsonString);
    catLists = temp["businesscat"];
    // print(resultCat.data['businesscat']);
    if (!resultCat.hasException) {
      for (var i = 0; i < resultCat.data['businesscat'].length; i++) {
        var ctm = resultCat.data['businesscat'][i];
        Category category = new Category();
        category.setId(ctm['id'].toString());
        category.setName(ctm['name'].toString());
        setState(() {
          _category.add(category);
        });
      }
    }
  }

  var dropdownValue;
  var droptownshipValue;

  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return Container(
        alignment: FractionalOffset.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 85.0,
                height: 90.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/img/shop-logo1.png')),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.redAccent,
                )),
            SizedBox(height: 5.0),
            Center(
                child: new Text(
              "Register",
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontFamily: "Roboto",
                fontSize: 30.0,
              ),
            )),
          ],
        ),
      );
    }

    state() {
      return Query(
          options: QueryOptions(
            documentNode: gql(states),
          ),
          builder: (QueryResult stateResult,
              {VoidCallback refetch, FetchMore fetchMore}) {
            List temList =
                stateResult.data == null ? null : stateResult.data['states'];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              margin: EdgeInsets.only(
                top: 18.0,
              ),
              child: DropdownButton(
                hint: stateResult.data == null
                    ? Text("Loading...")
                    : Text("State"),
                items: stateResult.data == null
                    ? null
                    : temList.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['name']),
                          value: item['id'].toString(),
                        );
                      }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                isExpanded: true,
                value: dropdownValue,
              ),
            );
          });
    }

    Widget township() {
      return Query(
          options: QueryOptions(
            documentNode: gql(townships),
          ),
          builder: (QueryResult townshipResult,
              {VoidCallback refetch, FetchMore fetchMore}) {
            List townshipList = townshipResult.data == null
                ? null
                : townshipResult.data['townships'];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              margin: EdgeInsets.only(
                top: 18.0,
              ),
              child: DropdownButton(
                hint: townshipResult.data == null
                    ? Text("Loading...")
                    : Text("မြို့နယ်"),
                items: townshipResult.data == null
                    ? null
                    : townshipList.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['name']),
                          value: item['id'].toString(),
                        );
                      }).toList(),
                onChanged: (townshipValue) {
                  setState(() {
                    droptownshipValue = townshipValue;
                  });
                },
                isExpanded: true,
                value: droptownshipValue,
              ),
            );
          });
    }

    final nameFeild = TextFormField(
      autofocus: false,
      controller: _nameController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          hintText: utils.email == "" ? "နာမည်" : utils.name,
          labelText: utils.email == "" ? "နာမည်" : utils.name,
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
      validator: (val) => val.isEmpty ? "နာမည်တည့်ရပါမည်" : null,
    );

    final shopFeild = new TextFormField(
      controller: _shopController,
      decoration: new InputDecoration(
          hintText: "ဆိုင်နာမည်",
          labelText: "ဆိုင်နာမည်",
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
      validator: (val) => val.isEmpty ? "ဆိုင်နာမည်တည့်ရပါမည်" : null,
    );

    final phoneFeild = TextFormField(
      controller: _phoneController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          hintText: "ဖုန်းနံပါတ်",
          labelText: 'ဖုန်းနံပါတ်',
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
      validator: (val) => val.length < 7 ? 'ဖုန်းနံပါတ်တည့်ရပါမည်' : null,
    );

    final emailFeild = TextFormField(
      autofocus: false,
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: 'မောလ်',
        labelText: 'မောလ်',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (val) => !val.contains('@') ? 'အီမေလ်ရိုက်တည့်ရပါမည်' : null,
    );

    final passFeild = TextFormField(
      obscureText: true,
      enableInteractiveSelection: false,
      controller: _password,
      decoration: InputDecoration(
          hintText: "လျှို့ဝှက်နံပါတ်",
          labelText: 'လျှို့ဝှက်နံပါတ်',
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
      validator: (val) => val.length < 6 ? 'လျှို့ဝှက်နံပါတ်အနည်းဆုံး၆လုံးတည့်ရပါမည်' : null,
    );

    final addFeild = TextFormField(
      controller: _addController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          hintText: "နေရပ်လိပ်စာ",
          labelText: 'နေရပ်လိပ်စာ',
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
      validator: (val) => val.isEmpty ? "နေရပ်လိပ်စာတည့်ရပါမည်" : null,
    );

    return Scaffold(
        body: Mutation(
            options: MutationOptions(
              documentNode: gql(simpleSingup),
              update: (Cache cache, QueryResult result) {
                return cache;
              },
              onCompleted: (dynamic resultData) {
                if (resultData.data['signup'] == null) {
                  print("error");
                } else {
                  print(resultData.data['signup']['name']);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SellScreen()));
                }
              },
            ),
            builder: (
              RunMutation runMutation,
              QueryResult result,
            ) {
              return Mutation(
                  options: MutationOptions(
                    documentNode: gql(gmailSingup),
                    update: (Cache cache, QueryResult googleResult) {
                      return cache;
                    },
                    onCompleted: (dynamic resultfbData) {
                      if (resultfbData.data['gmail_signup'] == null) {
                        print("error");
                      } else {
                        print(resultfbData.data['gmail_signup']['name']);
                        Navigator.of(context)
                            .pushReplacementNamed('/sellscreen');
                      }
                    },
                  ),
                  builder: (
                    RunMutation runFbMutation,
                    QueryResult fbResult,
                  ) {
                    return Form(
                        key: _formKey,
                        autovalidate: true,
                        child: ListView(children: <Widget>[
                          SizedBox(height: 10.0),
                          _header(),
                          SizedBox(height: 10.0),
                          new ListTile(
                            title: nameFeild,
                          ),
                          new ListTile(
                            title: shopFeild,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: MultiSelectFormField(
                              autovalidate: false,
                              titleText: 'ဆိုင်အမျိုးစာ',
                              validator: (value) {
                                if (value == null || value.length == 0) {
                                  return 'ဆိုင်အမျိုးစာရွေးရပါမည်';
                                }
                                return null;
                              },
                              dataSource: catLists,
                              textField: 'name',
                              valueField: 'id',
                              okButtonLabel: 'အတည်ပြုမည်',
                              cancelButtonLabel: 'မလုပ်ပါ',
                              hintText: 'ဆိုင်အမျိုးစာရွေးရပါမည်',
                              initialValue: _myActivities,
                              onSaved: (value) {
                                if (value == null) return;
                                setState(() {
                                  _myActivities = value;
                                });
                              },
                            ),
                          ),
                          new ListTile(
                            title: phoneFeild,
                          ),
                          new ListTile(
                            title: emailFeild,
                          ),
                          if (utils.email == null || utils.email == '') ...[
                            new ListTile(
                              title: passFeild,
                            ),
                          ],
                          township(),
                          state(),
                          new ListTile(
                            title: addFeild,
                          ),
                          SizedBox(height: 10.0),
                          utils.email == ''
                              ? Center(
                                  child: Container(
                                      height: 40,
                                      child: Material(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                        color: Colors.purple[800],
                                        child: MaterialButton(
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          padding: EdgeInsets.fromLTRB(
                                              0.0, 0.0, 0.0, 0.0),
                                          onPressed: () {
                                            if (droptownshipValue == null) {
                                              msg =
                                                  "choose township, Please township";
                                              showLongToast(msg);
                                            } else {
                                              // showLoading(context);
                                              runMutation(<String, dynamic>{
                                                "name": _nameController.text,
                                                "business_name":
                                                    _shopController.text,
                                                "business_cat_id":
                                                    _myActivities.toString(),
                                                "phone": _phoneController.text,
                                                "email": _emailController.text,
                                                "password": _password.text,
                                                "township_id":
                                                    droptownshipValue,
                                                "state_id": dropdownValue,
                                                "address": _addController.text
                                              });
                                            }
                                          },
                                          child: Text('Registr',
                                              textAlign: TextAlign.center,
                                              style: style.copyWith(
                                                color: Colors.white,
                                              )),
                                        ),
                                      )),
                                )
                              : Center(
                                  child: Container(
                                      height: 40,
                                      child: Material(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                        color: Colors.purple[800],
                                        child: MaterialButton(
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          padding: EdgeInsets.fromLTRB(
                                              0.0, 0.0, 0.0, 0.0),
                                          onPressed: () {
                                            if (droptownshipValue == null) {
                                              msg =
                                                  "choose township, Please township";
                                              showLongToast(msg);
                                            } else {
                                              // showLoading(context);
                                              runFbMutation(<String, dynamic>{
                                                "name": utils.name,
                                                "business_name":
                                                    _shopController.text,
                                                "business_cat_id":
                                                    _myActivities.toString(),
                                                "phone": _phoneController.text,
                                                "email": utils.email,
                                                "township_id":
                                                    droptownshipValue,
                                                "state_id": dropdownValue,
                                                "address": _addController.text,
                                                "api_token":
                                                    utils.accessToken
                                              });
                                            }
                                          },
                                          child: Text('Registr',
                                              textAlign: TextAlign.center,
                                              style: style.copyWith(
                                                color: Colors.white,
                                              )),
                                        ),
                                      )),
                                ),
                          SizedBox(height: 10.0),
                        ]));
                  });
            }));
  }
}
