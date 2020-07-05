import 'package:bossi_pos/graphql/graphql_string.dart';
import 'package:bossi_pos/graphql/nonW-graphql.dart';
import 'package:bossi_pos/graphql/utils.dart';
import 'package:bossi_pos/providers/categories.dart';
import 'package:bossi_pos/providers/product.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/screens/manage_products_screen.dart';
import 'package:bossi_pos/widgets/cat_wid.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:bossi_pos/graphql/utils.dart' as utils;

class ProductEditScreen extends StatefulWidget {
  static const routeName = "product_edit";

  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Product _newProduct = Product(
      id: null,
      name: null,
      category: null,
      price: null,
      qty: null,
      buyPrice: null,
      sku: null,
      desc: null,
      discountPrice: null,
      barcode: null,
      isDamage: null);

  bool isSwitched = false;

  final _buyPriceFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _discountFocusNode = FocusNode();
  final _skuFocusNode = FocusNode();
  final _barFocusNode = FocusNode();
  final _descFocusNode = FocusNode();

  bool _isInit = true;
  Map<String, dynamic> _initVal = {
    "id": null,
    "name": null,
    "category": 0,
    "price": 0,
    "qty": 0,
    "buyPrice": 0,
    "sku": null,
    "desc": null,
    "discountPrice": 0,
    "barcode": null,
    "isDamage": null
  };

  String dropdownValue;

  Category _newCat = Category(
    id: null,
    category: null,
  );
  TextEditingController _textFieldController = TextEditingController();
  bool _isValid = false;
  String name;

  TextField textField() {
    return TextField(
      controller: _textFieldController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "အမျိုးအစားအမည် ထည့်သွင်းပါ",
        labelText: "အမျိုးအစားအမည်",
        errorText: _isValid ? "အမျိုးအစားအမည် ထည့်သွင်းရန် လိုအပ်ပါသည်" : null,
      ),
    );
  }

  // void _showDialog(BuildContext context) {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         title: Text("အမျိုးအစားအသစ် ထည့်ရန်"),
  //         content: textField(),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //           FlatButton(
  //             child: Text("မလုပ်ပါ"),
  //             onPressed: () {
  //               _textFieldController.text = '';
  //               Navigator.of(context).pop();
  //             },
  //           ),

  //           FlatButton(
  //             child: Text("ထည့်မည်"),
  //             onPressed: () {
  //               if (_textFieldController.text.isNotEmpty) {
  //                 setState(() {
  //                   _isValid = false;
  //                   _newCat = Category(
  //                       id: _newCat.id, category: _textFieldController.text);

  //                   String _newCatId =
  //                       Provider.of<Categories>(context, listen: false)
  //                           .addAndGetID(_newCat);

  //                   dropdownValue = _newCatId;

  //                   _newProduct = Product(
  //                       id: _newProduct.id,
  //                       name: _newProduct.name,
  //                       price: _newProduct.price,
  //                       qty: _newProduct.qty,
  //                       buyPrice: _newProduct.buyPrice,
  //                       sku: _newProduct.sku,
  //                       desc: _newProduct.desc,
  //                       discountPrice: _newProduct.discountPrice,
  //                       barcode: _newProduct.barcode,
  //                       isDamage: _newProduct.isDamage,
  //                       category: _newCatId);
  //                 });

  //                 _textFieldController.text = '';
  //                 Navigator.of(context).pop();
  //               } else {
  //                 setState(() => _isValid = true);
  //               }
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("အမျိုးအစားအသစ် ထည့်ရန်"),
          content: textField(),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("မလုပ်ပါ"),
              onPressed: () {
                _textFieldController.text = '';
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("ထည့်မည်"),
              onPressed: () async {
                if (_textFieldController.text.isNotEmpty) {
                  QueryResult resultData = await graphQLClient.mutate(
                    MutationOptions(
                        documentNode: gql(categoryInsert),
                        variables: {
                          "name": _textFieldController.text,
                        }),
                  );

                  String _newCatId =
                      Provider.of<Categories>(context, listen: false)
                          .addAndGetID(_newCat);

                  _newProduct = Product(
                      id: _newProduct.id,
                      name: _newProduct.name,
                      price: _newProduct.price,
                      qty: _newProduct.qty,
                      buyPrice: _newProduct.buyPrice,
                      sku: _newProduct.sku,
                      desc: _newProduct.desc,
                      discountPrice: _newProduct.discountPrice,
                      barcode: _newProduct.barcode,
                      isDamage: _newProduct.isDamage,
                      category: _newCatId);

                  _textFieldController.text = '';

                  if (resultData.data != null) {
                    setState(() => _isValid = false);
                    Navigator.of(context).pop();
                  } else {
                    setState(() => _isValid = true);
                  }
                } else {
                  setState(() => _isValid = true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      String id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        // Product _product =
        //     Provider.of<Products>(context, listen: false).findById(id);
        Product _product = Product(
            id: utils.pro_id,
            name: utils.pro_name,
            category: utils.pro_catgory,
            price: utils.pro_price,
            qty: utils.pro_qty,
            buyPrice: utils.pro_buyprice,
            sku: utils.pro_sku,
            desc: utils.pro_desc,
            discountPrice: utils.pro_discountPrice,
            barcode: utils.pro_barcode,
            isDamage: true);
        _newProduct = _product;
        _initVal = {
          "id": _product.id,
          "name": _product.name,
          "category": _product.category,
          "price": _product.price,
          "qty": _product.qty,
          "buyPrice": _product.buyPrice,
          "sku": _product.sku,
          "desc": _product.desc,
          "discountPrice": _product.discountPrice,
          "barcode": _product.barcode,
          "isDamage": _product.isDamage
        };
        print(_initVal['name']);
        setState(() {
          dropdownValue = _product.category;
          // dropdownValue = resultData.data['product']['category']['id'];
          // print(_product.category);
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _buyPriceFocusNode.dispose();
    _priceFocusNode.dispose();
    _discountFocusNode.dispose();
    _skuFocusNode.dispose();
    _barFocusNode.dispose();
    _descFocusNode.dispose();

    _textFieldController.dispose();

    super.dispose();
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("တချို့အချက်အလက်များကို ထည့်သွင်းရန် လိုအပ်ပါသည်။​"),
      ));
    } else {
      _formKey.currentState.save();

      print(_newProduct.id);
      print(_newProduct.name);
      print(_newProduct.category);
      print(_newProduct.price);
      print(_newProduct.qty);
      print(_newProduct.buyPrice);
      print(_newProduct.sku);
      print(_newProduct.desc);
      print(_newProduct.discountPrice);
      print(_newProduct.barcode);
      print(_newProduct.isDamage);

      if (_initVal['id'] == null) {
        QueryResult resultData = await graphQLClient.mutate(
          MutationOptions(documentNode: gql(createProduct), variables: {
            "name": _newProduct.name,
            "category_id": _newProduct.category,
            "stock": _newProduct.qty,
            "buy_price": _newProduct.buyPrice,
            "sell_price": _newProduct.price,
            "discount_price": _newProduct.discountPrice,
            "sku": _newProduct.sku,
            "barcode": _newProduct.barcode,
            "is_damaged": _newProduct.isDamage,
            "remark": _newProduct.desc
          }),
        );

        Provider.of<Products>(context, listen: false).add(_newProduct);
      } else {
        print(_newProduct.id);
        QueryResult resultData = await graphQLClient.mutate(
          MutationOptions(documentNode: gql(updateProduct), variables: {
            "id": _newProduct.id,
            "name": _newProduct.name,
            "category_id": _newProduct.category,
            "stock": _newProduct.qty,
            "buy_price": _newProduct.buyPrice,
            "sell_price": _newProduct.price,
            "discount_price": _newProduct.discountPrice,
            "sku": _newProduct.sku,
            "barcode": _newProduct.barcode,
            "is_damaged": _newProduct.isDamage,
            "remark": _newProduct.desc
          }),
        );
        Provider.of<Products>(context, listen: false).edit(_newProduct);
      }

      // Navigator.pop(context);
      Navigator.pushReplacementNamed(context, ManageProductsScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    Categories _cats = Provider.of<Categories>(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text("ကုန်ပစ္စည်းအသစ် ထည့်ရန်")),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _initVal['name'],
                    decoration: InputDecoration(
                      icon: Icon(Icons.store),
                      hintText: "ကုန်ပစ္စည်းအမည် ထည့်သွင်းပါ",
                      labelText: "ကုန်ပစ္စည်းအမည်",
                    ),
                    validator: (val) => val.isEmpty
                        ? "ကုန်ပစ္စည်းအမည် ထည့်သွင်းရန် လိုအပ်ပါသည်"
                        : null,
                    onSaved: (val) => _newProduct = Product(
                        id: _newProduct.id,
                        name: val,
                        price: _newProduct.price,
                        qty: _newProduct.qty,
                        buyPrice: _newProduct.buyPrice,
                        sku: _newProduct.sku,
                        desc: _newProduct.desc,
                        discountPrice: _newProduct.discountPrice,
                        barcode: _newProduct.barcode,
                        isDamage: _newProduct.isDamage,
                        category: _newProduct.category),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FormField(
                    builder: (FormFieldState state) {
                      return Query(
                          options: QueryOptions(
                            documentNode: gql(categories),
                          ),
                          builder: (QueryResult stateResult,
                              {VoidCallback refetch, FetchMore fetchMore}) {
                            List temList = stateResult.data == null
                                ? null
                                : stateResult.data['categories'];
                            return InputDecorator(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.category),
                                labelText: 'အမျိုးအစားများ',
                              ),
                              // isEmpty: _selectedCat == '',
                              child: new DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: stateResult.data == null
                                      ? Text('Loading...')
                                      : Text('အမျိုးအစား ရွေးချယ်ပါ'),
                                  value: dropdownValue,
                                  isDense: true,
                                  items: stateResult.data == null
                                      ? null
                                      : temList.map((item) {
                                          return new DropdownMenuItem<String>(
                                              value: item['id'].toString(),
                                              child: new Text(
                                                  item['name'].toString()));
                                        }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _newProduct = Product(
                                          id: _newProduct.id,
                                          name: _newProduct.name,
                                          price: _newProduct.price,
                                          qty: _newProduct.qty,
                                          buyPrice: _newProduct.buyPrice,
                                          sku: _newProduct.sku,
                                          desc: _newProduct.desc,
                                          discountPrice:
                                              _newProduct.discountPrice,
                                          barcode: _newProduct.barcode,
                                          isDamage: _newProduct.isDamage,
                                          category: val.toString());

                                      dropdownValue = val.toString();
                                      state.didChange(val);
                                    });
                                    print("id: $val");
                                    print(dropdownValue);
                                  },
                                ),
                              ),
                            );
                          });
                    },
                  ),
                  // FormField(
                  //   builder: (FormFieldState state) {
                  //     return InputDecorator(
                  //       decoration: InputDecoration(
                  //         icon: const Icon(Icons.category),
                  //         labelText: 'အမျိုးအစားများ',
                  //       ),
                  //       // isEmpty: _selectedCat == '',
                  //       child: new DropdownButtonHideUnderline(
                  //         child: DropdownButton<String>(
                  //           hint: Text('အမျိုးအစား ရွေးချယ်ပါ'),
                  //           value: dropdownValue,
                  //           isDense: true,
                  //           items: _cats.categories.map((Category cat) {
                  //             return new DropdownMenuItem<String>(
                  //                 value: cat.id, child: new Text(cat.category));
                  //           }).toList(),
                  //           onChanged: (val) {
                  //             setState(() {
                  //               _newProduct = Product(
                  //                   id: _newProduct.id,
                  //                   name: _newProduct.name,
                  //                   price: _newProduct.price,
                  //                   qty: _newProduct.qty,
                  //                   buyPrice: _newProduct.buyPrice,
                  //                   sku: _newProduct.sku,
                  //                   desc: _newProduct.desc,
                  //                   discountPrice: _newProduct.discountPrice,
                  //                   barcode: _newProduct.barcode,
                  //                   isDamage: _newProduct.isDamage,
                  //                   category: val.toString());

                  //               dropdownValue = val.toString();
                  //               state.didChange(val);
                  //             });
                  //             print("id: $val");
                  //             print(dropdownValue);
                  //           },
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  FlatButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 180, 0),
                    onPressed: () =>
                        // Navigator.pushNamed(context, '/category_ce'),
                        _showDialog(context),
                    child: Text(
                      "အမျိုးအစား အသစ် ?",
                      style: TextStyle(color: Colors.blue, fontSize: 13),
                    ),
                  ),

                  TextFormField(
                    initialValue: _initVal['qty'] == 0 ? '' : _initVal['qty'].toString(),
                    decoration: InputDecoration(
                      icon: Icon(Icons.confirmation_number),
                      labelText: "အရေအတွက်",
                      hintText: "ဥပမာ။  ။ 50 (English Number ဖြစ်ရပါမည်)",
                      
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_buyPriceFocusNode),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "အရေအတွက် ထည့်သွင်းရန် လိုအပ်ပါသည်";
                      }
                      if (double.tryParse(val) == null) {
                        return "အရေအတွက်ကို ဂဏန်းဖြင့် ထည့်သွင်းရန် လိုအပ်ပါသည်";
                      }
                      if (double.tryParse(val) <= 0) {
                        return "အရေအတွက်သည် ၀ ထက်ကြီးရပါမည်";
                      }

                      return null;
                    },
                    keyboardType: TextInputType.number,
                    onSaved: (val) => _newProduct = Product(
                        id: _newProduct.id,
                        name: _newProduct.name,
                        price: _newProduct.price,
                        qty: int.parse(val),
                        buyPrice: _newProduct.buyPrice,
                        sku: _newProduct.sku,
                        desc: _newProduct.desc,
                        discountPrice: _newProduct.discountPrice,
                        barcode: _newProduct.barcode,
                        isDamage: _newProduct.isDamage,
                        category: _newProduct.category),
                  ),
                  TextFormField(
                    initialValue: _initVal['buyPrice'] == 0 ? '' : _initVal['buyPrice'].toString(),
                    decoration: InputDecoration(
                        icon: Icon(Icons.attach_money),
                        labelText: "၀ယ်ရင်းစျေး",
                        hintText: "ဥပမာ။  ။ 5000 (English Number ဖြစ်ရပါမည်)"
                        ),
                    keyboardType: TextInputType.number,
                    focusNode: _buyPriceFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_priceFocusNode),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "၀ယ်ရင်းစျေး ထည့်သွင်းရန် လိုအပ်ပါသည်";
                      }
                      if (double.tryParse(val) == null) {
                        return "၀ယ်ရင်းစျေးကို ဂဏန်းဖြင့် ထည့်သွင်းရန် လိုအပ်ပါသည်";
                      }
                      if (double.tryParse(val) <= 0) {
                        return "၀ယ်ရင်းစျေးသည် ၀ ထက်ကြီးရပါမည်";
                      }

                      return null;
                    },
                    onSaved: (val) => _newProduct = Product(
                        id: _newProduct.id,
                        name: _newProduct.name,
                        price: _newProduct.price,
                        qty: _newProduct.qty,
                        buyPrice: double.parse(val),
                        sku: _newProduct.sku,
                        desc: _newProduct.desc,
                        discountPrice: _newProduct.discountPrice,
                        barcode: _newProduct.barcode,
                        isDamage: _newProduct.isDamage,
                        category: _newProduct.category),
                  ),
                  TextFormField(
                    initialValue: _initVal['price'] == 0 ? '' : _initVal['price'].toString(),
                    decoration: InputDecoration(
                        icon: Icon(Icons.attach_money),
                        labelText: "ရောင်းစျေး",
                        hintText: "ဥပမာ။  ။ 7000 (English Number ဖြစ်ရပါမည်)"
                        ),
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_discountFocusNode),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "ရောင်းစျေး ထည့်သွင်းရန် လိုအပ်ပါသည်";
                      }
                      if (double.tryParse(val) == null) {
                        return "ရောင်းစျေးကို ဂဏန်းဖြင့် ထည့်သွင်းရန် လိုအပ်ပါသည်";
                      }
                      if (double.tryParse(val) <= 0) {
                        return "ရောင်းစျေးသည် ၀ ထက်ကြီးရပါမည်";
                      }

                      return null;
                    },
                    onSaved: (val) => _newProduct = Product(
                        id: _newProduct.id,
                        name: _newProduct.name,
                        price: double.parse(val),
                        qty: _newProduct.qty,
                        buyPrice: _newProduct.buyPrice,
                        sku: _newProduct.sku,
                        desc: _newProduct.desc,
                        discountPrice: _newProduct.discountPrice,
                        barcode: _newProduct.barcode,
                        isDamage: _newProduct.isDamage,
                        category: _newProduct.category),
                  ),
                  TextFormField(
                    initialValue: _initVal['discountPrice'] == 0 ? '' : _initVal['discountPrice'].toString(),
                    decoration: InputDecoration(
                      icon: Icon(Icons.attach_money),
                      labelText: "လျှော့စျေး (လျှော့စျေး ရှိပါက ထည့်သွင်းပေးပါ)",
                      hintText: "ဥပမာ။  ။ 6500 (English Number ဖြစ်ရပါမည်)",
                    ),
                    keyboardType: TextInputType.number,
                    focusNode: _discountFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_skuFocusNode),
                    onSaved: (val) => _newProduct = Product(
                        id: _newProduct.id,
                        name: _newProduct.name,
                        price: _newProduct.price,
                        qty: _newProduct.qty,
                        buyPrice: _newProduct.buyPrice,
                        sku: _newProduct.sku,
                        desc: _newProduct.desc,
                        discountPrice: double.parse(val),
                        barcode: _newProduct.barcode,
                        isDamage: _newProduct.isDamage,
                        category: _newProduct.category),
                  ),
                  TextFormField(
                    initialValue: _initVal['sku'],
                    decoration: InputDecoration(
                        icon: Icon(Icons.confirmation_number),
                        labelText: "SKU",
                        hintText: "SKU ထည့်သွင်းပါ"),
                    focusNode: _skuFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_barFocusNode),
                    onSaved: (val) => _newProduct = Product(
                        id: _newProduct.id,
                        name: _newProduct.name,
                        price: _newProduct.price,
                        qty: _newProduct.qty,
                        buyPrice: _newProduct.buyPrice,
                        sku: val,
                        desc: _newProduct.desc,
                        discountPrice: _newProduct.discountPrice,
                        barcode: _newProduct.barcode,
                        isDamage: _newProduct.isDamage,
                        category: _newProduct.category),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  TextFormField(
                    initialValue: _initVal['barcode'],
                    decoration: InputDecoration(
                        icon: Icon(Icons.donut_large),
                        labelText: "ဘားကုဒ်",
                        hintText: "ဘားကုဒ် ထည့်သွင်းပါ"),
                    focusNode: _barFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_descFocusNode),
                    onSaved: (val) => _newProduct = Product(
                        id: _newProduct.id,
                        name: _newProduct.name,
                        price: _newProduct.price,
                        qty: _newProduct.qty,
                        buyPrice: _newProduct.buyPrice,
                        sku: _newProduct.sku,
                        desc: _newProduct.desc,
                        discountPrice: _newProduct.discountPrice,
                        barcode: val,
                        isDamage: _newProduct.isDamage,
                        category: _newProduct.category),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            _newProduct = Product(
                                id: _newProduct.id,
                                name: _newProduct.name,
                                price: _newProduct.price,
                                qty: _newProduct.qty,
                                buyPrice: _newProduct.buyPrice,
                                sku: _newProduct.sku,
                                desc: _newProduct.desc,
                                discountPrice: _newProduct.discountPrice,
                                barcode: _newProduct.barcode,
                                isDamage: isSwitched,
                                category: _newProduct.category);
                          });
                        },
                      ),
                      Text("ပျက်စီး၊ ပျောက်ဆုံး နေပါသလား ?"),
                    ],
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  TextFormField(
                    initialValue: _initVal['desc'],
                    decoration: InputDecoration(
                        icon: Icon(Icons.description),
                        labelText: "မှတ်ချက်",
                        hintText: "မှတ်ချက် ထည့်သွင်းပါ"),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descFocusNode,
                    textInputAction: TextInputAction.done,
                    onSaved: (val) => _newProduct = Product(
                        id: _newProduct.id,
                        name: _newProduct.name,
                        price: _newProduct.price,
                        qty: _newProduct.qty,
                        buyPrice: _newProduct.buyPrice,
                        sku: _newProduct.sku,
                        desc: val,
                        discountPrice: _newProduct.discountPrice,
                        barcode: _newProduct.barcode,
                        isDamage: _newProduct.isDamage,
                        category: _newProduct.category),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: _submitForm,
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "သိမ်းဆည်းမည်",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
