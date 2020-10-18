import 'package:bossi_pos/auths/utils.dart' as utils;
import 'package:bossi_pos/graphql/authQueryMutation.dart';
import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Logins {
  String name;
  String email;
  String apiToken;

  Logins({this.name, this.email, this.apiToken});
}


class LoginProvider with ChangeNotifier {
  AuthQueryMutation queryMutation = AuthQueryMutation();
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  Future<void> logins(
      BuildContext context, String email, String phone, String password) async {
    try {
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
          MutationOptions(documentNode: gql(queryMutation.login(email, phone, password))));
      if (!result.hasException) {
        utils.accessToken = result.data['login']['api_token'];
        
         utils.errorCode = null;
        print(utils.accessToken);
        // success
        return Navigator.pushNamed(context, 'sell');
      } else {
        utils.errorCode= 500;
        print("error");
        print(result.exception);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
