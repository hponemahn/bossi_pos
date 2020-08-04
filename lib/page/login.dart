import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:bossi_pos/widgets/showe-dialog.dart';

import 'package:bossi_pos/graphql/graphql_string.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:bossi_pos/graphql/utils.dart' as utils;
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = new TextEditingController();
  var _passwordController = new TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // login google
  bool _isLoggedIn = false;
  GoogleSignInAccount googleAccount;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // login fb
  String _message;
  Map userProfile;
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  String msg;

  @override
  void initState() {
    super.initState();
  }

  _googlelogin() async {
    print("1");
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();
      GoogleSignInAuthentication authentication = await account.authentication;

      Navigator.of(context).pushReplacementNamed('/auth');

      setState(() {
        _isLoggedIn = true;
        utils.name = _googleSignIn.currentUser.displayName;
        utils.accessToken = authentication.accessToken;
        utils.email = _googleSignIn.currentUser.email;
      });
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

        Navigator.of(context).pushReplacementNamed('/auth');

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
      autofocus: false,
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: 'အီမောလ်(သို့)ဖုန်းနံပါတ်',
        labelText: 'အီမောလ်(သို့)ဖုန်းနံပါတ်',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (val) => val.isEmpty ? 'အီမေလ်(သို့)ဖုန်းနံပါတ်ရိုက်တည့်ရပါမည်' : null,
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: 'လျှို့ဝှက်နံပါတ်',
        labelText: 'လျှို့ဝှက်နံပါတ်',
      ),
      validator: (val) => val.length < 6 ? 'လျှို့ဝှက်နံပါတ်အနည်းဆုံး၆လုံးတည့်ရပါမည်' : null,
    );

    void _showSnackBar(BuildContext context, String text) {
      final snackBar = SnackBar(content: Text(text));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Mutation(
        options: MutationOptions(
          documentNode: gql(systemLogin),
          update: (Cache cache, QueryResult result) {
            return cache;
          },
          onCompleted: (dynamic resultData) {
            if (resultData.data['login'] == null) {
              _showSnackBar(context, "သင်၏အကောင့်မှားယွင်းနေပါသည်");
              print("error");
            } else {
              print(resultData.data['login']['name']);
              var result = resultData.data['login'];
              utils.accessToken = result['api_token'];
              msg = "login Sccess";
              showLongToast(msg);
              Navigator.of(context).pushReplacementNamed('/sellscreen');
              // _showSnackBar(context, "login Sccess");
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
                      FlatButton(
                        onPressed: () async {},
                        child: ClipOval(
                          child: Image.asset('assets/img/logo.png',
                              width: 100, height: 100, fit: BoxFit.cover),
                        ),
                        shape: new CircleBorder(),
                      ),
                      SizedBox(height: 80.0),
                      emailField,
                      SizedBox(height: 15.0),
                      passwordField,
                      SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(0.0),
                          shadowColor: Colors.purple[800],
                          elevation: 5.0,
                          child: MaterialButton(
                            minWidth: 200.0,
                            height: 50.0,
                            onPressed: () {
                              runMutation(<String, dynamic>{
                                // "email": _emailController.text,!val.contains('@') ? 'Not a valid email' : null
                                "email": !_emailController.text.contains('@') ? null : _emailController.text,
                                // "phone":null,
                                "phone": _emailController.text.contains('@') ? null : _emailController.text,
                                "password": _passwordController.text,
                              });
                            },
                            color: Colors.purple[800],
                            child: Text('Log In',
                                style: TextStyle(color: Colors.white)),
                            highlightColor: Colors.deepOrange,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                          // Navigator.pushNamed(context, '/home');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('New User?  '),
                            Text(
                              'Register',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.purple[800],
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
                              // showLoading(context);
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
                              // showLoading(context);
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
