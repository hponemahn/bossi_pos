import 'package:flutter/material.dart';

class ManageProductItem extends StatelessWidget {
  final String id;
  final String name;
  final double price;

  const ManageProductItem(this.id, this.name, this.price);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text("1 Qty  -  $price MMK"),
        // subtitle: Text("အရေအတွက်: 25 | စျေးနှုန်း: 2,500"),
        trailing: Container(
          width: 100,
          child: Row(
          children: [
            IconButton(icon: Icon(Icons.edit),onPressed: null,),
            IconButton(icon: Icon(Icons.delete),onPressed: null,),
          ],
        ),
        )
      ),
    );
  }
}