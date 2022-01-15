import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import '/providers/products_provider.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  ProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final producs = Provider.of<Products>(context);
    /*determin whitch list to take*/
    final displayProducs =
        producs.isFavorite ? producs.favoriteProducts : producs.products;
    return GridView.builder(
        itemCount: displayProducs.length,
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (_, index) {
          /*creating a seprate provider for each product used .value to ommit the disolve method called switching the tabs*/
          return ChangeNotifierProvider.value(
            value: displayProducs[index],
            child: ProductItem(),
          );
        });
  }
}
