import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/const.dart';
import 'package:shop/widgets/user_product_item.dart';

import '../providers/products_provider.dart';
import '../widgets/product_item.dart';
import '../widgets/app_drawer.dart';
import '../screeans/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      /*backgroundColor: kColorBacground,*/
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.products.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                product: productsData.products[i],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}


