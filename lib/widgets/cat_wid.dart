import 'package:bossi_pos/graphql/nonW-graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bossi_pos/graphql/graphql_string.dart';

void asyncInputDialog(BuildContext context)  {
  String teamName = '';
   showDialog<String>(
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter category name'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Category Name', hintText: 'eg. Food'),
              onChanged: (value) {
                teamName = value;
              },
            ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Add'),
            onPressed: () async{
              QueryResult resultData = await graphQLClient.mutate(
                MutationOptions(documentNode:gql(categoryInsert),variables:{
                  "name":teamName.toString()
                }),
              );
            if(resultData.data != null){
              Navigator.of(context).pop(teamName);
              }
            },
          ),
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(teamName);
            },
          ),
        ],
      );
    },
  );
}