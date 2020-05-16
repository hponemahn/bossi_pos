import 'dart:developer';

import 'package:bossi_pos/screens/sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bossi_pos/page/home.dart';
import 'package:bossi_pos/widgets/showe-dialog.dart';

import 'package:bossi_pos/graphql/graphql_string.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:bossi_pos/graphql/nonW-graphql.dart';
import 'package:bossi_pos/graphql/utils.dart' as utils;
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  static const String routeName = '/';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = new TextEditingController();
  var _passwordController = new TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  // login google
  bool _isLoggedIn = false;
  GoogleSignInAccount googleAccount;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  
  // login fb
  String _message;
  Map userProfile;
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  @override
  void initState() {
    super.initState();
  }


  _googlelogin() async {
    print("1");
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();
      GoogleSignInAuthentication authentication = await account.authentication;

      setState(() {
        _isLoggedIn = true;
        utils.name = _googleSignIn.currentUser.displayName;
        utils.accessToken = authentication.accessToken;
        utils.email = _googleSignIn.currentUser.email;
      });
      QueryResult resultData = await graphQLClient.mutate(
        MutationOptions(documentNode: gql(gmailSingup), variables: {
          "name":_googleSignIn.currentUser.displayName,
          "email": _googleSignIn.currentUser.email,
          "api_token": authentication.accessToken
        }
        ),
      );
      //  Navigator.of(context).pushReplacement(
      //                         MaterialPageRoute(
      //                             builder: (BuildContext context) =>
      //                                 HomePage()));
      Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SellScreen()));

        // Navigator.pushNamed(context, '/home');
      print("2");
    } catch (err) {
      print(err);
      print("6");
    }
  }

   // fb login
  Future<Null> _fblogin() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;

        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${result.accessToken.token}');
        var profile = json.decode(graphResponse.body);
        userProfile = profile;

        utils.name = userProfile["name"];
        utils.email = userProfile["email"];
        utils.accessToken = accessToken.token;

          QueryResult resultData = await graphQLClient.mutate(
              MutationOptions(documentNode: gql(gmailSingup), variables: {
                "name":userProfile["name"].toString(),
                "email": userProfile["email"].toString(),
                "api_token": accessToken.token.toString()
              }
              ),
            );

              // Navigator.pushNamed(context, '/home');
               Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SellScreen()));

      
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _emailController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          fillColor: Color(0xFFC6ECE6),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(12.0),
          ),
          labelText: 'Email or Phone Number'),
    );

    final passwordField = TextFormField(
      obscureText: true,
      enableInteractiveSelection: false,
      controller: _passwordController,
      decoration: InputDecoration(
          fillColor: Color(0xFFC6ECE6),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(12.0),
          ),
          labelText: 'Password'),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Mutation(
        options: MutationOptions(
          documentNode:
              gql(systemLogin), // this is the mutation string you just created
          // you can update the cache based on results
          update: (Cache cache, QueryResult result) {
            return cache;
          },
          // or do something with the result.data on completion
          onCompleted: (dynamic resultData) {
            if (resultData.data['login'] == null) {
              print("error");
            }else{
              print(resultData.data['login']['name']);
              var result = resultData.data['login'];
              utils.accessToken = result['api_token'];
              // Navigator.pushNamed(context, '/home');
              Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomePage()));
            }
          },
        ),
        builder: (
          RunMutation runMutation,
          QueryResult result,
        ) {
          return Center(
            child: Form(
              autovalidate: true,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(
                        height: 150.0,
                        child: Image.asset(
                          "assets/img/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      emailField,
                      SizedBox(height: 10.0),
                      passwordField,
                      SizedBox(height: 15.0),
                      Material(
                        elevation: 5.0,
                        borderRadius: new BorderRadius.circular(12.0),
                        color: Colors.purple[800],
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          onPressed: () {
                            showLoading(context);
                            runMutation(<String, dynamic>{
                                  "email": _emailController.text,
                                  "password": _passwordController.text,
                                });
                                print("9");
                          },
                          child: Text('Login',
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                          print("2");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('New User?  '),
                            Text(
                              'Register',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Or Login With",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          FlatButton(
                            onPressed: () async {
                               showLoading(context);
                               _fblogin();
                             
                               },
                            child: ClipOval(
                              child: Image.asset('assets/img/fb.png',
                                  width: 50, height: 50, fit: BoxFit.cover),
                            ),
                            shape: new CircleBorder(),
                          ),
                          FlatButton(
                            onPressed: () async {
                              showLoading(context);
                              _googlelogin(); 
                                        
                              },
                            child: ClipOval(
                              child: Image.asset('assets/img/g.png',
                                  width: 50, height: 50, fit: BoxFit.cover),
                            ),
                            shape: new CircleBorder(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
