import 'dart:convert';
import 'package:bossi_pos/auths/widgets/models.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:bossi_pos/auths/utils.dart' as utils;
import 'package:bossi_pos/graphql/graphQLConf.dart';

class MultiSelectPage extends StatefulWidget {
  @override
  _MultiSelectPageState createState() => _MultiSelectPageState();
}

class _MultiSelectPageState extends State<MultiSelectPage> {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  List catLists;
  List<Businesscat> businesscat = [];
  String category = r"""
                      query category{
                        businesscat{
                          id
                          name
                        }
                      }
                  """;

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
    categoryWidget();
  }


  void categoryWidget() async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult resultCat = await _client.query(QueryOptions(
      documentNode: gql(category),
    ));

    var jsonString = utils.getPrettyJSONString(resultCat.data);
    final temp = jsonDecode(jsonString);
    catLists = temp["businesscat"];
    if (!resultCat.hasException) {
      for (var i = 0; i < resultCat.data['businesscat'].length; i++) {
        var ctm = resultCat.data['businesscat'][i];
        Businesscat category = new Businesscat();
        category.setId(ctm['id'].toString());
        category.setName(ctm['name'].toString());
        setState(() {
          businesscat.add(category);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(0),
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
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCEL',
        required: true,
        hintText: 'ဆိုင်အမျိုးစာရွေးရပါမည်',
        initialValue: _myActivities,
        onSaved: (value) {
          if (value == null) return;
          setState(() {
            _myActivities = value;
            utils.myActivitiesResult = _myActivities.toString();
          });
        },
      ),
    );
  }
}
