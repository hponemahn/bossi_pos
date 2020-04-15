import 'package:bossi_pos/providers/product.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      catId: null,
      price: null,
      qty: null,
      buyPrice: null,
      sku: null,
      desc: null,
      discountPrice: null,
      barcode: null,
      isDamage: null);
  List<String> _categories = <String>['', 'red', 'yellow', 'white', 'blue'];
  String _category = "";
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
    "catId": 0,
    "price": 0,
    "qty": 0,
    "buyPrice": 0,
    "sku": null,
    "desc": null,
    "discountPrice": 0,
    "barcode": null,
    "isDamage": null
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      String id = ModalRoute.of(context).settings.arguments as String;

      if (id != null) {
        Product _product =
          Provider.of<Products>(context, listen: false).findById(id);
          _newProduct = _product;
        _initVal = {
          "id": _product.id,
          "name": _product.name,
          "catId": _product.catId,
          "price": _product.price,
          "qty": _product.qty,
          "buyPrice": _product.buyPrice,
          "sku": _product.sku,
          "desc": _product.desc,
          "discountPrice": _product.discountPrice,
          "barcode": _product.barcode,
          "isDamage": _product.isDamage
        };
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

    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("တချို့အချက်အလက်များကို ထည့်သွင်းရန် လိုအပ်ပါသည်။​"),
      ));
    } else {
      _formKey.currentState.save();

      print(_newProduct.id);
      print(_newProduct.name);
      print(_newProduct.catId);
      print(_newProduct.price);
      print(_newProduct.qty);
      print(_newProduct.buyPrice);
      print(_newProduct.sku);
      print(_newProduct.desc);
      print(_newProduct.discountPrice);
      print(_newProduct.barcode);
      print(_newProduct.isDamage);

      if (_initVal['id'] == null) {
        Provider.of<Products>(context, listen: false).add(_newProduct);  
      } else {
        Provider.of<Products>(context, listen: false).edit(_newProduct);
      }

      Navigator.pop(context);
    }
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
                        catId: _newProduct.catId),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.category),
                          labelText: 'အမျိုးအစားများ',
                        ),
                        isEmpty: _category == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _category,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
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
                                    catId: 1);
                                _category = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _categories.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  FlatButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 180, 0),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/category_ce'),
                    child: Text(
                      "အမျိုးအစား အသစ် ?",
                      style: TextStyle(color: Colors.blue, fontSize: 13),
                    ),
                  ),

                  TextFormField(
                    initialValue: _initVal['qty'].toString(),
                    decoration: InputDecoration(
                      icon: Icon(Icons.confirmation_number),
                      labelText: "အရေအတွက်",
                      hintText: "အရေအတွက် ထည့်သွင်းပါ",
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
                        catId: _newProduct.catId),
                  ),
                  TextFormField(
                    initialValue: _initVal['buyPrice'].toString(),
                    decoration: InputDecoration(
                        icon: Icon(Icons.attach_money),
                        labelText: "၀ယ်ရင်းစျေး",
                        hintText: "၀ယ်ရင်းစျေး ထည့်သွင်းပါ"),
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
                        catId: _newProduct.catId),
                  ),
                  TextFormField(
                    initialValue: _initVal['price'].toString(),
                    decoration: InputDecoration(
                        icon: Icon(Icons.attach_money),
                        labelText: "ရောင်းစျေး",
                        hintText: "ရောင်းစျေး ထည့်သွင်းပါ"),
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
                        catId: _newProduct.catId),
                  ),
                  TextFormField(
                    initialValue: _initVal['discountPrice'].toString(),
                    decoration: InputDecoration(
                      icon: Icon(Icons.attach_money),
                      labelText: "လျှော့စျေး",
                      hintText: "လျှော့စျေး ရှိပါက ထည့်သွင်းပေးပါ",
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
                        discountPrice: val == '' ? 0 : double.parse(val),
                        barcode: _newProduct.barcode,
                        isDamage: _newProduct.isDamage,
                        catId: _newProduct.catId),
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
                        catId: _newProduct.catId),
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
                        catId: _newProduct.catId),
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
                                catId: _newProduct.catId);
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
                        catId: _newProduct.catId),
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
