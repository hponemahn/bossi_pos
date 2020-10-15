 import 'package:flutter/material.dart';
 import 'package:bossi_pos/auths/utils.dart' as utils;

Widget backButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

Widget nameWidget() {
  return TextFormField(
      initialValue: '',
      decoration: const InputDecoration(
        hintText: 'နာမည်',
        labelText: 'နာမည်',
      ),      
      validator: (val) => val.isEmpty ? 'နာမည်တည့်ရပါမည်' : null,
      onSaved: (val)=>utils.name = val,
    );
}

Widget shopWidget(){
  return TextFormField(
    initialValue: '',
    decoration: const InputDecoration(
      hintText: 'ဆိုင်နာမည်',
      labelText:'ဆိုင်နာမည်'
    ),
    validator: (val) => val.isEmpty ? 'ဆိုင်နာမည်တည့်ရပါမည်' : null,
    onSaved: (val) => utils.shopName = val,
  );
}

Widget phoneWidget(){
  return TextFormField(
    initialValue: '',
    decoration: const InputDecoration(
      hintText: 'ဖုန်းနံပါတ်',
      labelText:'ဖုန်းနံပါတ်'
    ),
    validator: (val) => val.length <= 6 ? 'ဖုန်းနံပါတ်တည့်ရပါမည်' : null,
    onSaved: (val) => utils.phone = val,
  );
}

Widget emailWidget() {
  return TextFormField(
      autofocus: false,
      initialValue: '',
      decoration: const InputDecoration(
        hintText: 'မောလ်',
        labelText: 'မောလ်',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (val) => !val.contains('@') ? 'အီမေလ်ရိုက်တည့်ရပါမည်' : null,
      onSaved: (val) => utils.email = val,
    );
}

Widget loginEmailWidget() {
  return TextFormField(
      autofocus: false,
      initialValue: '',
      decoration: const InputDecoration(
        hintText: 'အီမောလ်(သို့)ဖုန်းနံပါတ်',
        labelText: 'အီမောလ်(သို့)ဖုန်းနံပါတ်',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (val) => val.isEmpty ? 'အီမေလ်(သို့)ဖုန်းနံပါတ်ရိုက်တည့်ရပါမည်' : null,
      onSaved: (val) {
        utils.email = !val.contains('@') ? null : val;
        utils.phone = val.contains('@') ? null : val;
      },
    );
}

Widget passwordWidget(){
  return TextFormField(
    obscureText: true,
    initialValue: '',
    decoration: const InputDecoration(
      hintText: 'လျှို့ဝှက်နံပါတ်',
      labelText: 'လျှို့ဝှက်နံပါတ်',
    ),
    validator: (val) => val.length <= 5 ? 'လျှို့ဝှက်နံပါတ်အနည်းဆုံး၆လုံးတည့်ရပါမည်' : null ,
    onSaved: (val) => utils.password = val,
  );
}

Widget addressWidget(){
  return TextFormField(
    initialValue: '',
    decoration: const InputDecoration(
      hintText: 'နေရပ်လိပ်စာ',
      labelText: 'နေရပ်လိပ်စာ'
    ),
    validator: (val) => val.isEmpty ? 'နေရပ်လိပ်စာတည့်ရပါမည်' : null,
    onSaved: (val) => utils.address = val,
  );
}