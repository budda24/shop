import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/circular_indicator.dart';

import '../providers/products_provider.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../providers/cart_provider.dart';
import '../const.dart';
import 'cart_screean.dart';

enum Page { favorite, allProducts }

class ProductsScreean extends StatefulWidget {
  const ProductsScreean({Key? key}) : super(key: key);
  static const id = '/Product_screean';

  @override
  State<ProductsScreean> createState() => _ProductsScreeanState();
}

class _ProductsScreeanState extends State<ProductsScreean> {
  bool circularIndicator = false;
  @override
  void initState() {
    circularIndicator = true;
    Provider.of<Products>(context, listen: false).featchData().then((value) => circularIndicator = false);
    Provider.of<Cart>(context, listen: false).featchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*getting the instance of products from products provider*/
    final productsData = Provider.of<Products>(context);
    final cartData = Provider.of<Cart>(context);

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
            onSelected: (value) {
              if (value == Page.favorite) {
                /*boolien wchith determins the list in product_grid*/
                productsData.toggleFavoritesMenu(true);
                /*creatiing a list of favorities in the producs provider*/
                productsData.createFavoriteProducts();
              }
              if (value == Page.allProducts)
                productsData.toggleFavoritesMenu(false);
            },
          ),
          Badge(
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CartScrean.id);
                  },
                  icon: Icon(Icons.shopping_cart_rounded)),
              value: cartData.itemQantity.toString())
        ],
        title: Text(
          'Products',
          style: kTextTitle,
        ),
        backgroundColor: kColorMain,
      ),
      body:circularIndicator? CircularndIcator(): ProductsGrid(),
      drawer: AppDrawer(),
    );
  }
}
