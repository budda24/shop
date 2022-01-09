import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProdyctItem extends StatelessWidget {
  final Product product;

  const ProdyctItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(product.imageUrl),
      header: Text(product.title),


    );
  }
}
