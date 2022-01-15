import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';

import '../providers/cart_provider.dart';


class OrderItem{
final CartItem products;
final String id;
final int amount;
DateTime dateTime;

OrderItem({required this.products, required this.id, required this.amount, required this.dateTime});
}

class Orders with ChangeNotifier{
  List<OrderItem> _orders = [];

  List<OrderItem> get orders{
    return [..._orders];
  }
  void addOrder(CartItem product){
    _orders.add(OrderItem(products: product, id: product.id, amount: product.quantity, dateTime: DateTime.now()));
  }

  clear(){
    _orders = [];
  }
}