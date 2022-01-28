import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shop/providers/product.dart';

import 'auth_provider.dart';

class CartItem {
  final String id;
  final String title;
  int quantity = 1;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    this.quantity = 1,
    required this.price,
  });
  void addQuantity() {
    quantity++;
  }
}

class Cart extends ChangeNotifier {
  Auth? auth;
  Cart({this.auth});

  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemQantity {
    return _items.length;
  }

  double get totalAmount {
    double tmpAmount = 0;
    _items.forEach((key, value) {
      tmpAmount += value.price * value.quantity;
    });
    return tmpAmount;
  }

  Future<http.Response> fetchAlbum() {
    return http
        .get(Uri.parse(
            'https://shop-8956a-default-rtdb.europe-west1.firebasedatabase.app/cartProducts/${auth!.userId}.json?auth=${auth!.token}'))
        .catchError((onError) => print(onError));
  }

  void featchData() async {
    final response = await fetchAlbum();
    final Map<String, dynamic> decodedData = jsonDecode(response.body);
    /* Map<String, CartItem> tmp = {}; */
    decodedData.forEach((key, value) {
      /* print('value : ${value['price']}  key: $key'); */

      _items[key] = CartItem(
          id: key,
          title: value['title'],
          price: double.parse(value['price']),
          quantity: value['quantity']);
    });
    notifyListeners();
    /*  _items = tmp; */
  }

  Future<void> addItem(Product product) {
/* using the product id as a key of documemt */
    final uri = Uri.parse(
        'https://shop-8956a-default-rtdb.europe-west1.firebasedatabase.app/cartProducts/${auth!.userId}/${product.id}.json?auth=${auth!.token}');
    /* using patch for creating new document with given id */
    return http
        .patch(
      uri,
      body: json.encode({
        'quantity': 1,
        'title': product.title,
        'total': product.price.toString(),
        'price': product.price.toString(),
      }),
    )
        .then((value) {
      var response = value.body;

      /* adding a element to map with given key */
      _items.putIfAbsent(
          product.id,
          () => CartItem(
              quantity: 1,
              id: product.id,
              title: product.title,
              price: product.price));

      notifyListeners();
    });
  }

  Future<void> ubdateItem(
    Product product,
    double total,
  ) {
    //calling a addQuantity on cart item
    _items[product.id]!.addQuantity();

    final uri = Uri.parse(
        'https://shop-8956a-default-rtdb.europe-west1.firebasedatabase.app/cartProducts/${auth!.userId}/${product.id}.json?auth=${auth!.token}');
    return http
        .patch(
      uri,
      body: json.encode({
        'quantity': _items[product.id]!.quantity,
        'title': product.title,
        'total': total,
        'price': product.price.toString(),
      }),
    )
        .then((value) {
      _items.update(
          product.id,
          (value) => CartItem(
              title: value.title,
              price: value.price,
              id: value.id,
              quantity: _items[product.id]!.quantity));
      notifyListeners();
    });
  }

  deleteItem(String id) {
    final uri = Uri.parse(
        'https://shop-8956a-default-rtdb.europe-west1.firebasedatabase.app/cartProducts/${auth!.userId}/${id}.json?auth=${auth!.token}');
    http
        .delete(
      uri,
    )
        .then((value) {
      _items.removeWhere((key, value) => value.id == id);
      notifyListeners();
    });
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
