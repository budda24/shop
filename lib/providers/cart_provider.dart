import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    this.quantity = 1,
    required this.price,
  });
}

class Cart extends ChangeNotifier {
  Map<String, CartItem> _items = {};


  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemQantity{
    return _items.length;
  }

  double get totalAmount{
    double tmpAmount = 0;
    _items.forEach((key, value) {
      tmpAmount += value.price *value.quantity;
    });
    return tmpAmount;
  }


  addItem(String productId,
      String title,
      double price,
      ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId, (value) => CartItem(title: value.title, price:value.price, id:value.id ,quantity:value.quantity +1));
    } else {
      _items.putIfAbsent(productId, () =>
          CartItem(id: productId, title: title, price: price));
    }
    notifyListeners();
  }

  deleteItem(String id){
    _items.removeWhere((key, value) => value.id == id);
    notifyListeners();
  }
}
