import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const.dart';
import '../providers/cart_provider.dart' show Cart, CartItem;
import 'package:shop/providers/order_provider.dart';
import 'package:shop/widgets/cart_item.dart';

class CartScrean extends StatelessWidget {
  static const id = '/cart';
  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorMain,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: kColorBacground,
            border: Border.all(
              color: kColorMain,
            ),
            /*borderRadius: BorderRadius.all(
              Radius.circular(20),
            )*/
          ),
          width: double.infinity - 30,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'TOTAL: ',
                    style: kText,
                  ),
                  Chip(
                    label: Text(
                      cartData.totalAmount.toStringAsFixed(2),
                      style: kText,
                    ),
                    backgroundColor: kColorMain,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cartData.items.values.toList(),
                        cartData.totalAmount,
                      );
                      cartData.clear();
                    },
                    child: Text(
                      'PLACE ORDER',
                      style: kTextSubtitle,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  /*padding: EdgeInsets.all(5),*/
                  itemCount: cartData.itemQantity,
                  itemBuilder: (_, index) {
                    /*print(index);*/
                    return CartItemElement(
                        cartItem: CartItem(
                      id: cartData.items.values.toList()[index].id,
                      price: cartData.items.values.toList()[index].price,
                      quantity: cartData.items.values.toList()[index].quantity,
                      title: cartData.items.values.toList()[index].title,
                    ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
