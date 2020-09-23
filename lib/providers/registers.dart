import 'dart:ffi';

import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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

String singUp(
    String name,
    int roleID,
    String businessName,
    String businessCatID,
    String phone,
    String email,
    String password,
    int townshipID,
    int stateID,
    String address) {
  return """
          mutation {
                signup(
                  name:"$name"
                  role_id:$roleID
                  business_name:"$businessName"
                  business_cat_id: "$businessCatID"
                  phone:"$phone"
                  email:"$email"
                  password : "$password "
                  township_id: $townshipID
                  state_id: $stateID
                  address: "$address"
                  
                ){
                  id
                  name
                  email
                  api_token
                }
            } 
  """;
}

class RegisterProvider with ChangeNotifier {
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  Future<void> singUps(
      String name,
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
          documentNode: gql(singUp(name, roleID , businessName, businessCatID, phone,
              email, password, townshipID, stateID, address))));
      print(result.exception);
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
