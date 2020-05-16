import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bossi_pos/widgets/showe-dialog.dart';
import 'package:bossi_pos/graphql/graphql_string.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  File galleryFile;
  var _nameController = new TextEditingController();
  var _emailController = new TextEditingController();
  var _password = new TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void initState() {
    super.initState();
  }

  imageSelectorGallery() async {
    File image;
    image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 480, maxHeight: 480);
    setState(() {
      galleryFile = image;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    Widget displaySelectedFile(File img) {
      return new Container(
        child: Column(
          children: <Widget>[
            ClipOval(
              child: img == null
                  ? new Image.asset('assets/img/camera_icon.png',
                      width: 150, height: 150, fit: BoxFit.cover)
                  : new Image.file(img,
                      width: 150, height: 150, fit: BoxFit.cover),
            ),
          ],
        ),
      );
    }

    final nameFeild = TextFormField(
      controller: _nameController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          fillColor: Color(0xFFC6ECE6),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(12.0),
          ),
          labelText: 'Name'),
    );

    final emailFeild = TextFormField(
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

    final passFeild = TextFormField(
      obscureText: true,
      enableInteractiveSelection: false,
      controller: _password,
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
      body: Mutation(
        options: MutationOptions(
          documentNode:
              gql(simpleSingup), // this is the mutation string you just created
          // you can update the cache based on results
          update: (Cache cache, QueryResult result) {
            return cache;
          },
          // or do something with the result.data on completion
          onCompleted: (dynamic resultData) {
             if (resultData.data['signup'] == null) {
              print("error");
            }else{
              print(resultData.data['signup']['name']);
              var result = resultData.data['signup'];
              // utils.accessToken = result['api_token'];
              Navigator.pushNamed(context, '/home');
            }
          },
        ),
         builder: (
          RunMutation runMutation,
          QueryResult result,
        ) {
          return ListView(children: <Widget>[
            SizedBox(height: 90.0),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
              child: new GestureDetector(
                onTap: imageSelectorGallery,
                child: new Center(
                  child: new Stack(
                    children: <Widget>[
                      new Center(
                        child: displaySelectedFile(galleryFile),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            new ListTile(
              title: nameFeild,
            ),
            new ListTile(
              title: emailFeild,
            ),
            new ListTile(
              title: passFeild,
            ),
            SizedBox(height: 10.0),
            Center(
              child: Container(
                height:45,
                child:Material(
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    color: Colors.blue,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      onPressed: () {
                        print("1");
                        showLoading(context);
                        runMutation(<String, dynamic>{
                                  "avatar":galleryFile,
                                  "name":_nameController.text,
                                  "email": _emailController.text,
                                  "password": _password.text,
                                });
                      },
                      child: Text('Registr',
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white,)),
                    ),
                  )
              ),
            )
          ]);
        }
      )
    );
  }
}
