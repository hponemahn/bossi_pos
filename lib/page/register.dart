import 'dart:convert';
import 'dart:io';

import 'package:bossi_pos/graphql/nonW-graphql.dart';
import 'package:bossi_pos/screens/sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:bossi_pos/widgets/showe-dialog.dart';
import 'package:bossi_pos/graphql/graphql_string.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bossi_pos/graphql/utils.dart' as utils;

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  String msg;
  var _nameController = new TextEditingController();
  var _shopController = new TextEditingController();
  var _emailController = new TextEditingController();
  var _phoneController = new TextEditingController();
  var _addController = new TextEditingController();
  var _password = new TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void initState() {
    super.initState();
  }

  List<String> _isChecked = [];
  List<String> _idChecked = [];
  String strCheckList;
  String idCheckList;
  void showcheck(context) async {
    QueryResult resultCat = await graphQLClient.query(QueryOptions(
      documentNode: gql(category),
    ));

    var jsonString = utils.getPrettyJSONString(resultCat.data);
    final temp = jsonDecode(jsonString);
    List catLists = temp["businesscat"];

    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text(
            'Shop Categories',
          ),
          content: SingleChildScrollView(
              child: Container(
            child: Column(
              children: catLists
                  .map((cat) => CheckboxListTile(
                        title: Text(cat['name'].toString()),
                        value: _isChecked.contains(cat['name']),
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        onChanged: (bool value) {
                          if (!_isChecked.contains(cat['name'])) {
                            setState(() {
                              _isChecked.add(cat['name']);
                              _idChecked.add(cat['id']);
                              strCheckList = _isChecked.reduce(
                                  (value, element) => value + ',' + element);
                              idCheckList = _idChecked.reduce(
                                  (value, element) => value + ',' + element);
                              print(_idChecked);
                              print(_isChecked.reduce(
                                  (value, element) => value + ',' + element));
                            });
                          } else {
                            setState(() {
                              _isChecked.remove(cat['name']);
                              _idChecked.remove(cat['id']);
                              strCheckList = _isChecked.reduce(
                                  (value, element) => value + ',' + element);
                              idCheckList = _idChecked.reduce(
                                  (value, element) => value + ',' + element);
                              print(_idChecked);
                              print(_isChecked.reduce(
                                  (value, element) => value + ',' + element));
                            });
                          }
                        },
                      ))
                  .toList(),
            ),
          )),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
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
            if (stateResult.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0F9671)),
                ),
              );
            } else {
              List temList = stateResult.data['states'];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(
                  top: 18.0,
                ),
                child: DropdownButton(
                  hint: new Text("State"),
                  items: temList.map((item) {
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
            }
          });
    }

    Widget township() {
      return Query(
          options: QueryOptions(
            documentNode: gql(townships),
          ),
          builder: (QueryResult townshipResult,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (townshipResult.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0F9671)),
                ),
              );
            } else {
              List townshipList = townshipResult.data['townships'];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(
                  top: 18.0,
                ),
                child: DropdownButton(
                  hint: new Text("Township"),
                  items: townshipList.map((item) {
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
            }
          });
    }

    final nameFeild = TextFormField(
      controller: _nameController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          hintText: utils.email == "" ? "Enter your name" : utils.name,
          labelText: utils.email == "" ? "Name" : utils.name,
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
    );

    final shopFeild = new TextFormField(
      controller: _shopController,
      decoration: new InputDecoration(
          hintText: "Enter your shop name",
          labelText: "Shop Name",
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
    );

    final phoneFeild = TextFormField(
      controller: _phoneController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          hintText: "Enter your phone",
          labelText: 'Phone No',
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
    );

    final emailFeild = TextFormField(
      controller: _emailController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          hintText: utils.email == "" ? "Enter your email" : utils.email,
          labelText: utils.email == "" ? "Email" : utils.email,
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
    );

    final passFeild = TextFormField(
      obscureText: true,
      enableInteractiveSelection: false,
      controller: _password,
      decoration: InputDecoration(
          hintText: "Enter password",
          labelText: 'Password',
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
    );

    final addFeild = TextFormField(
      controller: _addController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          hintText: "Enter your address",
          labelText: 'Address',
          labelStyle: new TextStyle(color: const Color(0xFF424242))),
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
                          Navigator.of(context).pushReplacementNamed('/sellscreen');
                      }
                    },
                  ),
                  builder: (
                    RunMutation runFbMutation,
                    QueryResult fbResult,
                  ) {
                    return ListView(children: <Widget>[
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
                        margin: EdgeInsets.fromLTRB(6.0, 0.0, 10.0, 0.0),
                        //  padding: new EdgeInsets.only(left: 0.0),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        )),
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              strCheckList == null
                                  ? Text("Shop Category")
                                  : Text(strCheckList),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                          textColor: Colors.black54,
                          onPressed: () {
                            showcheck(context);
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
                                  height: 45,
                                  child: Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90.0)),
                                    color: Colors.blue,
                                    child: MaterialButton(
                                      minWidth:
                                          MediaQuery.of(context).size.width / 2,
                                      padding: EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      onPressed: () {
                                        String password = _password.text.trim();
                                        String phone =
                                            _phoneController.text.trim();
                                        Pattern phonePattern =
                                            r'^(?:[+0]9)?[0-9]';
                                        RegExp regexPhone =
                                            new RegExp(phonePattern);
                                        if (_nameController.text == '' ||
                                            _shopController.text == '' ||
                                            _phoneController.text == '' ||
                                            _addController.text == '') {
                                          msg =
                                              "Please Fill all fields,All fields are required.";
                                          showLongToast(msg);
                                        } else if (password.length < 6) {
                                          msg =
                                              "Invalid Password, Password must be at least 6 characters long.";
                                          showLongToast(msg);
                                        } else if (phone.length < 6) {
                                          msg =
                                              "Invalid Phone, Phone must be at least 6 number long.";
                                          showLongToast(msg);
                                        } else if (!regexPhone
                                            .hasMatch(_phoneController.text)) {
                                          msg = "Wrong phone no format";
                                          showLongToast(msg);
                                        } else if (strCheckList == null) {
                                          msg =
                                              "choose shop category, Please shop category";
                                          showLongToast(msg);
                                        } else if (droptownshipValue == null) {
                                          msg =
                                              "choose township, Please township";
                                          showLongToast(msg);
                                        } else if (dropdownValue == null) {
                                          msg = "choose state, Please state";
                                          showLongToast(msg);
                                        } else {
                                          // showLoading(context);
                                          runMutation(<String, dynamic>{
                                            "name": _nameController.text,
                                            "business_name": _shopController.text,
                                            "business_cat_id": idCheckList,
                                            "phone": _phoneController.text,
                                            "email": _emailController.text,
                                            "password": _password.text,
                                            "township_id": droptownshipValue,
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
                                  height: 45,
                                  child: Material(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90.0)),
                                    color: Colors.blue,
                                    child: MaterialButton(
                                      minWidth:
                                          MediaQuery.of(context).size.width / 2,
                                      padding: EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                      onPressed: () {
                                        String phone =
                                            _phoneController.text.trim();
                                        Pattern phonePattern =
                                            r'^(?:[+0]9)?[0-9]';
                                        RegExp regexPhone =
                                            new RegExp(phonePattern);
                                        if (_shopController.text == '' ||
                                            _phoneController.text == '' ||
                                            _addController.text == '') {
                                          msg =
                                              "Please Fill all fields,All fields are required.";
                                          showLongToast(msg);
                                        } else if (phone.length < 6) {
                                          msg =
                                              "Invalid Phone, Phone must be at least 6 number long.";
                                          showLongToast(msg);
                                        } else if (!regexPhone
                                            .hasMatch(_phoneController.text)) {
                                          msg = "Wrong phone no format";
                                          showLongToast(msg);
                                        } else if (strCheckList == null) {
                                          msg =
                                              "choose shop category, Please shop category";
                                          showLongToast(msg);
                                        } else if (droptownshipValue == null) {
                                          msg =
                                              "choose township, Please township";
                                          showLongToast(msg);
                                        } else if (dropdownValue == null) {
                                          msg = "choose state, Please state";
                                          showLongToast(msg);
                                        } else {
                                          // showLoading(context);
                                          runFbMutation(<String, dynamic>{
                                            "name": utils.name,
                                            "business_name": _shopController.text,
                                            "business_cat_id": idCheckList,
                                            "phone": _phoneController.text,
                                            "email": utils.email,
                                            "township_id": droptownshipValue,
                                            "state_id": dropdownValue,
                                            "address": _addController.text,
                                            "remember_token": utils.accessToken
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
                    ]);
                  });
            }));
  }
}
