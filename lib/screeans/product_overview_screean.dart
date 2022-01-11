import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/providers/products_provider.dart';
import 'package:shop/widgets/products_grid.dart';
import '../const.dart';

enum Page { favorite, allProducts }

class ProductsScreean extends StatelessWidget {
  const ProductsScreean({Key? key}) : super(key: key);
  static const id = '/Product_screean';

  @override
  Widget build(BuildContext context) {
    /*getting the instance of products from products provider*/
    final productsData = Provider.of<Products>(context);

    return Scaffold(
        backgroundColor: kColorBacground,
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: Page.allProducts,
                  child: Text(
                    'All Products',
                    style: kTextSubtitle,
                  ),
                ),
                PopupMenuItem(
                  value: Page.favorite,
                  child: Text(
                    'Favorite Products',
                    style: kTextSubtitle,
                  ),
                ),
              ],
              /*toDo how to resolve that problem better*/
              onSelected: (value){
               if(value == Page.favorite){
                 /*boolien wchith determins the list in product_grid*/
                 productsData.toggleFavorites(true);
                 /*creatiing a list of favorities in the producs provider*/
                 productsData.addFavorite();
               }
               if(value == Page.allProducts) productsData.toggleFavorites(false);

              },
            ),

          ],
          title: Text(
            'Products',
            style: kTextTitle,
          ),
          backgroundColor: kColorMain,
        ),
        body: ProductsGrid());
  }
}
