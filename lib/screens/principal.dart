import 'package:bossi_pos/graphql/graphQLConf.dart';
import 'package:bossi_pos/graphql/queryMutation.dart';
import 'package:bossi_pos/providers/person.dart';
import 'package:bossi_pos/widgets/alertDialogs.dart';
import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class Principal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Principal();
}

class _Principal extends State<Principal> {
  List<Person> listPerson = List<Person>();
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  void fillList() async {
    QueryMutation queryMutation = QueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(queryMutation.getAll()),
        // document: queryMutation.getAll(),
      ),
    );

    if (result.loading) {
      CircularProgressIndicator();
    }

    if (!result.hasException) {
      for (var i = 0; i < result.data["persons"].length; i++) {
        setState(() {
          listPerson.add(
            Person(
              result.data["persons"][i]["id"],
              result.data["persons"][i]["name"],
              result.data["persons"][i]["lastName"],
              result.data["persons"][i]["age"],
            ),
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fillList();
  }

  void _addPerson(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AlertDialogWindow alertDialogWindow =
            new AlertDialogWindow(isAdd: true);
        return alertDialogWindow;
      },
    ).whenComplete(() {
      listPerson.clear();
      fillList();
    });
  }

  void _editDeletePerson(context, Person person) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AlertDialogWindow alertDialogWindow =
            new AlertDialogWindow(isAdd: false, person: person);
        return alertDialogWindow;
      },
    ).whenComplete(() {
      listPerson.clear();
      fillList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () => _addPerson(context),
            tooltip: "Insert new person",
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Person",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50.0),
            child: ListView.builder(
              itemCount: listPerson.length,
              itemBuilder: (context, index) {
                return ListTile(
                  selected: listPerson == null ? false : true,
                  title: Text(
                    "${listPerson[index].getName()}",
                  ),
                  onTap: () {
                    _editDeletePerson(context, listPerson[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
