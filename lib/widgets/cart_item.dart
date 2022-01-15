import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/providers/cart_provider.dart';
import 'package:shop/const.dart';

class CartItem extends StatelessWidget {
  final String totalAmount;
  final double price;
  final int quantity;
  final String title;
  final String id;

  CartItem({
    required this.totalAmount,
    required this.price,
    required this.quantity,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<Cart>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(width: 2, color: Colors.red),
      ),
      child: Dismissible(
        key: Key(id),
        direction: DismissDirection.endToStart,
        onDismissed:(direction){
          cartData.deleteItem(id );
        },
        // delete item from the list,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Icon(Icons.restore_from_trash),
          ),
        ),


        child: ListTile(
          horizontalTitleGap: 20,
          tileColor: kColorMain.withOpacity(0.2),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: kColorMain,
            child: Container(
              width: 30,
              height: 30,
              child: FittedBox(
                child: Text('\$${price.toStringAsFixed(2)}', style: kText),
              ),
            ),
          ),
          title: Text(
            title,
            style: kTextSubtitle,
          ),
          subtitle: Text((quantity * price).toStringAsFixed(2), style: kText),
          trailing: Text('X ${quantity.toString()}'),
        ),
      ),
    );
  }
}
