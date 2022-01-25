import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/providers/cart_provider.dart';
import 'package:shop/const.dart';

class CartItemElement extends StatelessWidget {
  final CartItem cartItem;

  CartItemElement({required this.cartItem});
  double get priceForProduct {
    return cartItem.price * cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<Cart>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(width: 2, color: Colors.red),
      ),
      child: Dismissible(
        key: Key(cartItem.id),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog<bool>(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: const Text('Are you sure u want to delete item'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                        cartData.deleteItem(cartItem.id);
                      },
                      child: Text(
                        'YES',
                        style: kTextSubtitle,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text(
                        'NO',
                        style: kTextSubtitle,
                      ),
                    ),
                  ],
                );
              });
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
                child: Text('\$${cartItem.price.toStringAsFixed(2)}',
                    style: kText),
              ),
            ),
          ),
          title: Text(
            cartItem.title,
            style: kTextSubtitle,
          ),
          subtitle:
              Text(priceForProduct.toString(), style: kText),
          trailing: Text('X ${cartItem.quantity.toString()}'),
        ),
      ),
    );
  }
}
