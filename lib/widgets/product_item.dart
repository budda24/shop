import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/const.dart';
import 'package:shop/providers/product.dart';
import '../screeans/product_details_screan.dart';

class ProductItem extends StatelessWidget {
  /*final Product product;*/

  const ProductItem({Key? key /*, required this.product*/
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
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
                  : Icon(Icons.favorite_outlined, color: kColorMain,),
              onPressed: () {
                product.toggleFavorite();
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
              onPressed: () {},
            )),
      ),
    );
  }
}