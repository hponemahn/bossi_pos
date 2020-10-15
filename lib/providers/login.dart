import 'package:bossi_pos/auths/utils.dart' as utils;
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

String login(String email, String phone, String password) {
  return """ 
  mutation {
            login (email :"$email"
                  phone :"$phone"
                  password :"$password")
              {
              id
              name
              remember_token
              api_token

            }
          }
  """;
}

class LoginProvider with ChangeNotifier {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  Future<void> logins(
      BuildContext context, String email, String phone, String password) async {
    try {
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.mutate(
          MutationOptions(documentNode: gql(login(email, phone, password))));
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
