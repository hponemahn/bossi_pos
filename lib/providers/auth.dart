import 'dart:convert';
import 'dart:async';

import 'package:bossi_pos/graphql/authQueryMutation.dart';
import 'package:bossi_pos/graphql/graphqlConf.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  AuthQueryMutation _authQueryMutation = AuthQueryMutation();

  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    // if (_expiryDate != null &&
    //     _expiryDate.isAfter(DateTime.now()) &&
    //     _token != null) {
    return _token;
    // }
    // return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> authenticate(
      {String name,
      String email,
      String password,
      int bType,
      int state,
      int township,
      String urlSegment}) async {
    print("authenticate received data");
    print("name: $name");
    print("email: $email");
    print("password: $password");
    print(bType);
    print("bType");
    try {
      GraphQLClient _client = _graphQLConfiguration.clientToQuery();
      QueryResult result;
      String _authToken = "";

      if (urlSegment == 'register') {
        print("register");
        result = await _client.mutate(
          MutationOptions(
            documentNode: gql(_authQueryMutation.register(
                name: name,
                email: email,
                password: password,
                bType: bType,
                state: state,
                township: township)),
          ),
        );

        print("register result token: ${result.data['register']}");

        _authToken = result.data['register'];
      } else {
        print("login");

        result = await _client.mutate(
          MutationOptions(
            documentNode: gql(_authQueryMutation.login(
              phoneEmail: email,
              password: password,
            )),
          ),
        );

        print("login result token: ${result.data['login']}");
        _authToken = result.data['login'];
      }

      print(result.exception);
      print("data: ${result.data}");

      print("register token: $_authToken");
      _graphQLConfiguration.setToken(_authToken);
      // GraphQLConfiguration().setToken();

      _token = _authToken;
      print("token: $_token");
      // _userId = responseData['localId'];
      _userId = "deviceID-1";

      // _expiryDate = DateTime.now().add(
      //   Duration(
      //     seconds: int.parse(
      //       responseData['expiresIn'],
      //     ),
      //   ),
      // );

      // _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          // 'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    // final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    // if (expiryDate.isBefore(DateTime.now())) {
    //   return false;
    // }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    // _expiryDate = expiryDate;
    print("try auto login token: $token");
    _graphQLConfiguration.setToken(_token);

    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    _graphQLConfiguration.removeToken();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);

    _graphQLConfiguration.removeToken();
  }
}
