
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screeans/user_producs_screen.dart';
import '../providers/product.dart';
import '../screeans/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  UserProductItem({required this.product});

  bool _circularIndicator = true;

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context);
    return _circularIndicator
        ? ListTile(
            title: Text(product.title),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(product.imageUrl),
            ),
            trailing: Container(
              width: 100,
              child: Row(
                children: <Widget>[
                  IconButton(

                    icon: Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, EditProductScreen.routeName,
                          arguments: product);
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _circularIndicator = true;
                      products.deleteProduct(product.id).then((response) {
                        if (response.statusCode < 201){
                          _circularIndicator = false;
                        }else{
                          return showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                    'Error occured while deleting the data to data base'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        /*go back to user product*/
                                        Navigator.of(context).pushNamed(
                                            UserProductsScreen.routeName);
                                      },
                                      child: Text('OK!'))
                                ],
                              ));
                        }
                        print('respons :${response.statusCode}');
                      } );
                    },
                    color: Theme.of(context).errorColor,
                  ),
                ],
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
