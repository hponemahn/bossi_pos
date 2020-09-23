import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class States {
  String id;
  String name;

  States({@required this.id, @required this.name});
}

String states() {
  return """
        {
          states{
            id
            name
          }
        }
  """;
}

class Townships {
  String id;
  String name;

  Townships({@required this.id, @required this.name});
}

String township(int stateId) {
  return """ 
       {
        townships(state_id: $stateId){
          id
          name
          
        }
      }
    """;
}

class StateProvider with ChangeNotifier {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  List<States> _stateprovider = [];

  Future<void> fetchStates() async {
    try {
      final List<States> loadeStates = [];
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result =
          await _client.query(QueryOptions(documentNode: gql(states())));

      if (!result.hasException) {
        for (var i = 0; i < result.data['states'].length; i++) {
          loadeStates.add(States(
            id: result.data["states"][i]['id'],
            name: result.data["states"][i]['name'],
          ));
          _stateprovider = loadeStates;
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

  List<States> get stateprovider {
    return [..._stateprovider];
  }
}

class TownshipProvider with ChangeNotifier {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  List<Townships> _townprovider = [];

  Future<void> fetchTownship(int id) async {
    try {
      final List<Townships> loadTownship = [];
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(township(id)),
        ),
      );
      if (!result.hasException) {
        for (var i = 0; i < result.data['townships'].length; i++) {
          loadTownship.add(Townships(
              id: result.data["townships"][i]['id'],
              name: result.data["townships"][i]['name']));
          _townprovider = loadTownship;
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

  List<Townships> get townshipprovider {
    return [..._townprovider];
  }
}
