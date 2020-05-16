import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:bossi_pos/graphql/graphql_string.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Query(
      options: QueryOptions(
        documentNode:
            gql(userInfo), // this is the query string you just created
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Text('Loading');
        }
        List repositories = result.data['users'];

        return ListView.builder(
            itemCount: repositories.length,
            itemBuilder: (context, index) {
              final repository = repositories[index];

              return Text(repository['name']);
            });
      },
    ));
  }
}
