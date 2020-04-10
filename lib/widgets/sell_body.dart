import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:provider/provider.dart';

class SellBody extends StatefulWidget {
  SellBody({Key key}) : super(key: key);

  @override
  _SellBodyState createState() => _SellBodyState();
}

class _SellBodyState extends State<SellBody> {
  String _searchText = "";

  Widget _grid(products, _cart) {
    if (_searchText.isNotEmpty) {
      List tempList = new List();
      for (int i = 0; i < products.length; i++) {
        if (products[i]
            .name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(products[i]);
        }
      }
      products = tempList;
    }

    return Flexible(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1),
        itemBuilder: (BuildContext context, int index) => Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            GridTile(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GridTile(
                  child: GestureDetector(
                    onTap: () {
                      _cart.add(products[index].id, products[index].name, products[index].price);
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.blueGrey.shade500,
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                                child: Text(
                              products[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )))),
                  ),
                ),
              ),
            ),
            if(_cart.cart[products[index].id] != null && _cart.cart[products[index].id].qty != 0)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: EdgeInsets.all(2.0),
                // color: Theme.of(context).accentColor,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Theme.of(context).accentColor,
                ),
                constraints: BoxConstraints(
                  minWidth: 24,
                  minHeight: 24,
                ),
                child: Text(
                  _cart.cart[products[index].id].qty.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Products _products = Provider.of<Products>(context);
    Cart _cart = Provider.of<Cart>(context);

    return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchText = val;
                });
              },
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search),
                  hintText: 'ရောင်းမည့်ပစ္စည်းရှာရန် ...'),
            ),
          ),
          _grid(_products.products, _cart),
        ],
      );
  }
}
