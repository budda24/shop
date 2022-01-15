import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/const.dart';
import 'package:shop/providers/cart_provider.dart' show Cart;
import 'package:shop/widgets/cart_item.dart';

class CartScrean extends StatelessWidget {
  const CartScrean({Key? key}) : super(key: key);
  static const id = '/cart';

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<Cart>(context, listen: false);
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
                    onPressed: () {},
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
                    return CartItem(
                      id:  cartData.items.values.toList()[index].id,
                      totalAmount: cartData.totalAmount.toStringAsFixed(2),
                      price: cartData.items.values.toList()[index].price,
                      quantity: cartData.items.values.toList()[index].quantity,
                      title: cartData.items.values.toList()[index].title,
                    );
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
