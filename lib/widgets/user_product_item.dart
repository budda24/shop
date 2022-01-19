import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products_provider.dart';
import '../providers/product.dart';
import '../screeans/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {

  final Product product;

  UserProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context);
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: Colors.green,),
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName, arguments: product);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                products.deleteProduct(product.id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}