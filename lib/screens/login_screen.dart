import 'package:bossi_pos/auths/widgets/bezierContainer.dart';
import 'package:bossi_pos/auths/widgets/text_title.dart';
import 'package:bossi_pos/providers/login.dart';
import 'package:flutter/material.dart';
import 'package:bossi_pos/auths/widgets/register_widget.dart' as widget;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bossi_pos/auths/utils.dart' as utils;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(1, 3),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.purple[800], Colors.purpleAccent])),
      child: Text(
        'LOGIN',
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
    );
  }

  Widget singupBotton() {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, 'register');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Dont have an account?  '),
          Text(
            'SIGN UP',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.purple[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget googleButtom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlineButton.icon(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 30.0,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          borderSide: BorderSide(color: Colors.red),
          color: Colors.red,
          highlightedBorderColor: Colors.red,
          textColor: Colors.red,
          icon: Icon(
            FontAwesomeIcons.googlePlusG,
            size: 18.0,
          ),
          label: Text("Google"),
          onPressed: () {},
        ),
        const SizedBox(width: 10.0),
        OutlineButton.icon(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 30.0,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          highlightedBorderColor: Colors.indigo,
          borderSide: BorderSide(color: Colors.indigo),
          color: Colors.indigo,
          textColor: Colors.indigo,
          icon: Icon(
            FontAwesomeIcons.facebookF,
            size: 18.0,
          ),
          label: Text("Facebook"),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    void _showSnackBar(BuildContext context, String text) {
      final snackBar = SnackBar(content: Text(text));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Stack(children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    SizedBox(height: height * .20),
                    TitleText(),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    widget.loginEmailWidget(),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    widget.passwordWidget(),
                    SizedBox(
                      height: height * 0.09,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // print(utils.email);
                          // print(utils.phone);
                          Provider.of<LoginProvider>(context, listen: false)
                              .logins(context, utils.email, utils.phone,
                                  utils.password);
                          if ( utils.errorCode == 500) {
                            _showSnackBar(
                                context, "သင်၏အကောင့်မှားယွင်းနေပါသည်");
                          }

                        }
                      },
                      child: _submitButton(),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    singupBotton(),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    googleButtom()
                  ])),
            )
          ]),
        ),
      ),
    );
  }
}
