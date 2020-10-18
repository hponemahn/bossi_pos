import 'package:bossi_pos/auths/widgets/bezierContainer.dart';
import 'package:bossi_pos/auths/widgets/multis_select.dart';
import 'package:bossi_pos/auths/widgets/text_title.dart';
import 'package:bossi_pos/providers/registers.dart';
import 'package:flutter/material.dart';
import 'package:bossi_pos/auths/widgets/register_widget.dart' as widget;
import 'package:bossi_pos/auths/utils.dart' as utils;
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "register";

  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedRole;
  String _selectedState;
  String _selectedTownship;

  @override
  void initState() {
    super.initState();
    Provider.of<RoleProvider>(context, listen: false).fetchRoles();
    Provider.of<StateProvider>(context, listen: false).fetchStates();
  }

  Widget role() {
    RoleProvider _roles = Provider.of<RoleProvider>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 25.0,
      ),
      child: DropdownButton(
        hint: Text('Please choose you role'),
        value: _selectedRole,
        onChanged: (newRole) {
          setState(() {
            _selectedRole = newRole;
            print(newRole);
          });
        },
        isExpanded: true,
        items: _roles.roleprovider.map((roles) {
          return DropdownMenuItem(
            child: new Text(roles.name),
            value: roles.id,
          );
        }).toList(),
      ),
    );
  }

  Widget state() {
    StateProvider _states = Provider.of<StateProvider>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 25.0,
      ),
      child: DropdownButton(
        hint: Text('State'),
        value: _selectedState,
        onChanged: (newRole) {
          setState(() {
            _selectedState = newRole;
            utils.stateID = int.parse(newRole);
            _selectedTownship = null;
            Provider.of<TownshipProvider>(context, listen: false)
                .fetchTownship(utils.stateID);
            print(newRole);
          });
        },
        isExpanded: true,
        items: _states.stateprovider.map((states) {
          return DropdownMenuItem(
            child: new Text(states.name),
            value: states.id,
          );
        }).toList(),
      ),
    );
  }

  Widget township() {
    TownshipProvider _township = Provider.of<TownshipProvider>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 25.0,
      ),
      child: DropdownButton(
        hint: Text('မြို့နယ်'),
        value: _selectedTownship,
        onChanged: (newRole) {
          setState(() {
            _selectedTownship = newRole;
          });
        },
        isExpanded: true,
        items: _township.townshipprovider.map((towns) {
          return DropdownMenuItem(
            child: new Text(towns.name),
            value: towns.id,
          );
        }).toList(),
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      padding: EdgeInsets.symmetric(vertical: 15),
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
        'Register Now',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -MediaQuery.of(context).size.height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer(),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.03,
                    left: 0,
                    child: widget.backButton()),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: height * .11),
                            TitleText(),
                            SizedBox(
                              height: 20,
                            ),
                            widget.nameWidget(),
                            widget.shopWidget(),
                            widget.phoneWidget(),
                            widget.emailWidget(),
                            widget.passwordWidget(),
                            widget.addressWidget(),
                            role(),
                            state(),
                            township(),
                            MultiSelectPage(),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  Provider.of<RegisterProvider>(context, listen: false).singUps(context,
                                  utils.name, int.parse(_selectedRole) , utils.shopName, utils.myActivitiesResult, utils.phone, utils.email,
                                   utils.password,
                                  int.parse(_selectedTownship), int.parse(_selectedState), utils.address);
                                }
                              },
                              child: _submitButton(),
                            )
                          ]),
                    ))
              ],
            ),
          )),
    );
  }
}
