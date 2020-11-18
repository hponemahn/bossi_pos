import 'dart:io';

import 'package:bossi_pos/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Signup;
  Map<String, String> _authData = {
    'name': '',
    'phone': '',
    'email': '',
    'password': '',
    'bType': '',
    'state': '',
    'township': ''
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).authenticate(
            name: _authData['name'],
            email: _authData['email'],
            password: _authData['password'],
            urlSegment: "login");
      } else {
        print("register");
        print("name: ${_authData['name']}");
        print("email: ${_authData['email']}");
        print("password: ${_authData['password']}");

        // Sign user up
        await Provider.of<Auth>(context, listen: false).authenticate(
            name: _authData['name'],
            email: _authData['email'],
            password: _authData['password'],
            bType: 1,
            state: 1,
            township: 1,
            urlSegment: "register");
      }
    }
    // on HttpException catch (error) {
    //   var errorMessage = 'Authentication failed';
    //   if (error.toString().contains('EMAIL_EXISTS')) {
    //     errorMessage = 'This email address is already in use.';
    //   } else if (error.toString().contains('INVALID_EMAIL')) {
    //     errorMessage = 'This is not a valid email address';
    //   } else if (error.toString().contains('WEAK_PASSWORD')) {
    //     errorMessage = 'This password is too weak.';
    //   } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
    //     errorMessage = 'Could not find a user with that email.';
    //   } else if (error.toString().contains('INVALID_PASSWORD')) {
    //     errorMessage = 'Invalid password.';
    //   }
    //   _showErrorDialog(errorMessage);
    // }
    catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  File _image;
  final picker = ImagePicker();

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20,
                              _authMode == AuthMode.Signup ? 35 : 150, 20, 0),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.transparent,
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.fromLTRB(
                    //       20, _authMode == AuthMode.Signup ? 35 : 150, 20, 0),
                    //   child: Image.asset(
                    //     "assets/logo.png",
                    //     height: 100,
                    //   ),
                    // ),
                    // username
                    if (_authMode == AuthMode.Signup)
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid business name!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['name'] = value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black26,
                              ),
                              // suffixIcon: Icon(
                              //   Icons.check_circle,
                              //   color: Colors.black26,
                              // ),
                              hintText: "Business Name",
                              hintStyle: TextStyle(color: Colors.black26),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),
                    // phone
                    // if (_authMode == AuthMode.Signup)
                    //   Card(
                    //     margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                    //     elevation: 11,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(40))),
                    //     child: TextFormField(
                    //       keyboardType: TextInputType.phone,
                    //       validator: (value) {
                    //         if (value.isEmpty) {
                    //           return 'Invalid phone!';
                    //         }
                    //         return null;
                    //       },
                    //       onSaved: (value) {
                    //         _authData['phone'] = value;
                    //       },
                    //       decoration: InputDecoration(
                    //           prefixIcon: Icon(
                    //             Icons.phone,
                    //             color: Colors.black26,
                    //           ),
                    //           // prefixIcon: Padding(padding: EdgeInsets.all(15), child: Text('09 -')),
                    //           hintText: "Phone",
                    //           hintStyle: TextStyle(
                    //             color: Colors.black26,
                    //           ),
                    //           filled: true,
                    //           fillColor: Colors.white,
                    //           border: OutlineInputBorder(
                    //             borderSide: BorderSide.none,
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(40.0)),
                    //           ),
                    //           contentPadding: EdgeInsets.symmetric(
                    //               horizontal: 20.0, vertical: 16.0)),
                    //     ),
                    //   ),
                    // email (or) phone
                    Card(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                      elevation: 11,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Invalid Phone! (or) Email!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.security,
                              color: Colors.black26,
                            ),
                            hintText: "Phone (or) Email",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                    ),
                    // password
                    Card(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                      elevation: 11,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty || value.length < 5) {
                            return 'Password is too short! (or) invalid';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black26,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                    ),
                    // confirm password
                    if (_authMode == AuthMode.Signup)
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextFormField(
                          enabled: _authMode == AuthMode.Signup,
                          obscureText: true,
                          validator: _authMode == AuthMode.Signup
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }
                                  return null;
                                }
                              : null,
                          // validator: (value) {
                          //   if (_authMode == AuthMode.Signup) {
                          //     if (value != _passwordController.text) {
                          //       return 'Passwords do not match!';
                          //     }
                          //     return null;
                          //   }
                          // },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black26,
                              ),
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),
                    // business type
                    if (_authMode == AuthMode.Signup)
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextFormField(
                          onSaved: (value) {
                            _authData['bType'] = value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black26,
                              ),
                              hintText: "Business Type",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),
                    // state
                    if (_authMode == AuthMode.Signup)
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextFormField(
                          onSaved: (value) {
                            _authData['state'] = value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.place,
                                color: Colors.black26,
                              ),
                              hintText: "State",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),
                    // township
                    if (_authMode == AuthMode.Signup)
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextFormField(
                          onSaved: (value) {
                            _authData['township'] = value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.place,
                                color: Colors.black26,
                              ),
                              hintText: "Township",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),

                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(30.0),
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          color: Theme.of(context).accentColor,
                          onPressed: _submit,
                          elevation: 11,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                          child: Text(
                              _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    Text(
                        _authMode == AuthMode.Login
                            ? 'Forgot your password?'
                            : '',
                        style: TextStyle(color: Colors.indigo)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(_authMode == AuthMode.Login
                            ? 'Don\'t have an account?'
                            : 'Already have an account?'),
                        FlatButton(
                          child: Text(
                              "${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'}"),
                          textColor: Colors.indigo,
                          onPressed: _switchAuthMode,
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 100,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
