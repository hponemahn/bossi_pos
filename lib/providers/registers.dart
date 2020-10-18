
import 'package:bossi_pos/graphql/authQueryMutation.dart';
import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bossi_pos/auths/utils.dart' as utils;

class Registers {
  String name;
  int roleID;
  String businessName;
  String businessCatID;
  String phone;
  String email;
  String password;
  int townshipID;
  int stateID;
  String address;

  Registers(
      {this.name,
      this.roleID,
      this.businessName,
      this.businessCatID,
      this.phone,
      this.email,
      this.password,
      this.townshipID,
      this.stateID,
      this.address});
}

class RegisterProvider with ChangeNotifier {
  AuthQueryMutation queryMutation = AuthQueryMutation();
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  Future<void> singUps(
    BuildContext context,
      String name,
      String deviceID,
      int roleID,
      String businessName,
      String businessCatID,
      String phone,
      String email,
      String password,
      int townshipID,
      int stateID,
      String address) async {
    try {
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(queryMutation.singUp(name, deviceID, roleID , businessName, businessCatID, phone,
              email, password, townshipID, stateID, address))));
      if (!result.hasException) {
        utils.accessToken = result.data['signup']['api_token'];
        print(utils.accessToken);
      // success
      return Navigator.pushNamed(context, 'sell');
      }else{
        print("error");
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}

// Role
class Roles {
  String id;
  String name;

  Roles({@required this.id, @required this.name});
}

class RoleProvider with ChangeNotifier {
  AuthQueryMutation queryMutation = AuthQueryMutation();
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  
  List<Roles> _roleprovider = [];

  Future<void> fetchRoles() async {
    try {
      final List<Roles> loadedRoles = [];
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(queryMutation.roles()),
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

// State
class States {
  String id;
  String name;

  States({@required this.id, @required this.name});
}

class StateProvider with ChangeNotifier {
  AuthQueryMutation queryMutation = AuthQueryMutation();
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  List<States> _stateprovider = [];

  Future<void> fetchStates() async {
    try {
      final List<States> loadeStates = [];
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result =
          await _client.query(QueryOptions(documentNode: gql(queryMutation.states())));

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

// Township
class Townships {
  String id;
  String name;

  Townships({@required this.id, @required this.name});
}

class TownshipProvider with ChangeNotifier {
  AuthQueryMutation queryMutation = AuthQueryMutation();
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  List<Townships> _townprovider = [];

  Future<void> fetchTownship(int id) async {
    try {
      final List<Townships> loadTownship = [];
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(queryMutation.township(id)),
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