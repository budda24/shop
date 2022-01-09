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
        child: Center(
            child: Text(
          product.description,
          textAlign: TextAlign.center,
          style: kTextSubtitle,
        )),
      ),
    );
  }
}
