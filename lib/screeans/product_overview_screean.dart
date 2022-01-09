
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/providers/product.dart';
import 'package:shop/providers/products_provider.dart';
import 'package:shop/widgets/product_item.dart';
import 'package:shop/widgets/products_grid.dart';
import '../const.dart';

class ProductsScreean extends StatelessWidget {
  const ProductsScreean({Key? key}) : super(key: key);
  static const id = '/Product_screean';

  /*static List<Product> productList = */

  @override
  Widget build(BuildContext context) {
    /*getting the instance of products from products provider*/
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      backgroundColor: kColorBacground,
      appBar: AppBar(
        title: Text(
          'Products',
          style: kTextTitle,
        ),
        backgroundColor: kColorMain,
      ),
      body: ProductsGrid()
    );
  }
}
