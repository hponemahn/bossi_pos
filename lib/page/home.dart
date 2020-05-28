import 'package:bossi_pos/graphql/nonW-graphql.dart';
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

//  QueryResult resultData = await graphQLClient.query(
//               QueryOptions(documentNode: gql(userInfo)
//               ),
//             );
 
    // var result = await graphQl.query(q);
      // var result =
      //    graphQLClient.query(QueryOptions(
      //           documentNode: gql(userInfo),
      //         ));

  Future<String> asyncFunc1() async {
   QueryResult result =await graphQLClient.query(QueryOptions(
                documentNode: gql(userInfo),
              ));
              return result.toString();

}

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
        body: Center(
          
        child: Text(asyncFunc1().toString())));
  }
}
