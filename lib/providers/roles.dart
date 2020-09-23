import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Roles {
  String id;
  String name;

  Roles({@required this.id, @required this.name});
}

String roles() {
  return """ 
       {
        roles{
          id
          name
          display_name
        }
      }
    """;
}

class RoleProvider with ChangeNotifier {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  // List<Roles> _roleprovider = [
  //   Roles(id: "1", name: "Admin"),
  //   Roles(id: "2", name: "Staff"),
  //   Roles(id: "3", name: "Shop"),
  //   Roles(id: "4", name: "User"),
  //   Roles(id: "5", name: "Owner"),
  // ];
  List<Roles> _roleprovider = [];

  Future<void> fetchRoles() async {
    try {
      final List<Roles> loadedRoles = [];
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(roles()),
        ),
      );

      if (!result.hasException) {
        for (var i = 0; i < result.data['roles'].length; i++) {
          loadedRoles.add(Roles(
              id: result.data["roles"][i]['id'],
              name: result.data["roles"][i]['name']));
          _roleprovider = loadedRoles;
          notifyListeners();
        }
      } else {
        print('exception');
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  List<Roles> get roleprovider {
    return [..._roleprovider];
  }
}
