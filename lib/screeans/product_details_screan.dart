import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop/const.dart';
import 'package:shop/providers/products_provider.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);
  static const id = '/Product_detail_screean';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<Products>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorMain,
        title: Column(children: [
          Text(
            product.title,
            style: kTextTitle,
          ),
        ]),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        decoration: BoxDecoration(
            color: kColorBacground,
            border: Border.all(
              color: kColorMain,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: kColorMain,
                    child: Container(
                      width: 30,
                      height: 30,
                      child: FittedBox(
                        child: Text('\$${product.price.toStringAsFixed(2)}',
                            style: kText),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  product.title,
                  style: kTextSubtitle,
                ),
              ],
            ),
            Text(
              product.description,
              textAlign: TextAlign.center,
              style: kTextSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
