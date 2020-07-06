import 'package:bossi_pos/graphql/graphQLConf.dart';
import 'package:bossi_pos/providers/products.dart';
import 'package:bossi_pos/screens/product_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bossi_pos/graphql/graphql_string.dart';
import 'package:bossi_pos/graphql/utils.dart' as utils;
 GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
class ManageProductItem extends StatelessWidget {

  final String id;
  final String name;
  final int qty;
  final double price;

  const ManageProductItem(this.id, this.name, this.qty, this.price);

  void _showDialog(BuildContext context, String id) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("ဖျက်မှာ သေချာပါသလား?"),
          content: Text("ဤကုန်ပစ္စည်းကို ဖျက်လိုက်မည်ဆိုပါက ပြန်ရနိုင်တော့မည် မဟုတ်ပါ။​"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("မလုပ်ပါ"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("ဖျက်မည်"),
              onPressed: () async{
                Provider.of<Products>(context, listen: false).delete(id);
                GraphQLClient _client = graphQLConfiguration.clientToQuery();
                QueryResult resultData = await _client.mutate(
                  MutationOptions(
                      documentNode: gql(deleteProduct),
                      variables: {
                        "id": id,
                      }),
                );
                Navigator.of(context).pop();
                // Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text("$qty Qty  -  $price MMK"),
        // subtitle: Text("အရေအတွက်: 25 | စျေးနှုန်း: 2,500"),
        trailing: Container(
          width: 100,
          child: Row(
          children: [
            // IconButton(icon: Icon(Icons.edit),onPressed: () => Navigator.pushNamed(context, ProductEditScreen.routeName, arguments: id),),
            IconButton(icon: Icon(Icons.edit),onPressed: () async{
              print(id);
              GraphQLClient _client = graphQLConfiguration.clientToQuery();
               QueryResult resultData = await _client.query(
                  QueryOptions(
                      documentNode: gql(productID),
                      variables: {
                        "id": int.parse(id),
                      }),
                );
                utils.pro_id = resultData.data['product']['id'];
                utils.pro_name = resultData.data['product']['name'];
                utils.pro_catgory = resultData.data['product']['category']['id'];
                utils.pro_price = resultData.data['product']['sell_price'].toDouble();
                utils.pro_qty = resultData.data['product']['stock'];
                utils.pro_buyprice= resultData.data['product']['buy_price'].toDouble();
                utils.pro_sku = resultData.data['product']['sku'];
                utils.pro_desc = resultData.data['product']['remark'];
                utils.pro_discountPrice= resultData.data['product']['discount_price'].toDouble();
                utils.pro_barcode = resultData.data['product']['barcode'];
                print(resultData.data);
                if(resultData.data != null){
                  Navigator.pushNamed(context, ProductEditScreen.routeName, arguments: id);
                }
            },),
            IconButton(icon: Icon(Icons.delete),onPressed: () => _showDialog(context, id)),
          ],
        ),
        )
      ),
    );
  }
}