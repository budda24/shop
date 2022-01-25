import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../const.dart';
import '../providers/cart_provider.dart';
import '../providers/product.dart';
import '../screeans/product_details_screan.dart';

class ProductItem extends StatelessWidget {
  ProductItem({Key? key}) : super(key: key);

  void undoSnacbar(Cart cart, String itemId) {
    cart.deleteItem(itemId);
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cartData = Provider.of<Cart>(context);
    final products = Provider.of<Products>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, ProductDetails.id,
              arguments: product.id),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
            backgroundColor: Colors.black26,
            leading: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: product.isFavorite
                  ? Icon(
                      Icons.favorite,
                    )
                  : Icon(
                      Icons.favorite_outlined,
                      color: kColorMain,
                    ),
              onPressed: () {
                /*switching the isFavorite value and attaching listener*/
                product.toggleFavoriteStatus();
                products.ubdateProduct(product);
              },
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: kTextTitle.copyWith(fontSize: 20),
            ),
            trailing: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(
                Icons.shopping_cart,
                color: kColorMain,
              ),
              onPressed: () {
                try {
                  if (cartData.items.containsKey(product.id)) {


                    cartData.ubdateItem(
                        product, cartData.totalAmount);
                  } else {
                    /* print('add item'); */
                    cartData.addItem(product);
                  }
                } finally {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('undo'),
                      action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            undoSnacbar(cartData, product.id);
                          }),
                    ),
                  );
                }
              },
            )),
      ),
    );
  }
}
