import 'dart:convert';

import 'package:bossi_pos/graphql/nonW-graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bossi_pos/graphql/graphql_string.dart';
import 'package:bossi_pos/graphql/utils.dart' as utils;

import 'package:multiselect_formfield/multiselect_formfield.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  List<Category> _category = [];
  List catLists;

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
    fillList(context);
// setState(() {
//   print(cat_name);
// });
  }

  void fillList(context) async {
   QueryResult resultCat = await graphQLClient.query(QueryOptions(
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

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: false,
                  titleText: 'My workouts',
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                    return null;
                  },
                  dataSource:  catLists,
                  textField: 'name',
                  valueField: 'id',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  // required: true,
                  hintText: 'Please choose one or more',
                  initialValue: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                      print(_myActivities);
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: (){
                     print(catLists);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(_myActivitiesResult),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Category {
  String id;
  String name;

  getid() => this.id;
  getName() => this.name;

  setId(String value){ this.id = value; }
  setName(String value){ this.name = value; }

   Map<String,dynamic> toJson()=>{
  'id' : id, 
  'name' : name,
  };

}
