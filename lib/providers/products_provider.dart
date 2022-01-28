import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shop/providers/auth_provider.dart';

import '../screeans/edit_product_screen.dart';
import '../providers/product.dart';

class Products with ChangeNotifier {
  /*getter for the private class _products*/
  List<Product> get products {
    /*print(_products[0]);*/
    return [..._products];
  }

  List<Product> _products = [];

  bool isFavorite = false;

  void toggleFavoritesMenu(bool page) {
    isFavorite = page;
    notifyListeners();
  }

  /*favorite Products*/
  List<Product> favoriteProducts = [];

  createFavoriteProducts() {
    favoriteProducts =
        products.where((element) => element.isFavorite == true).toList();
    notifyListeners();
  }

  String? token;
  String? userId;
  Products({this.token, this.userId});

  Future<void> addProduct(Product product) async {
    try {
      /*creating object URI from string*/
      final uri = Uri.parse(
          'https://shop-8956a-default-rtdb.europe-west1.firebasedatabase.app/products/$userId.json?auth=$token');
      /*bug body may return cosing null*/
      final response = await http.post(
        uri,
        /*headers: {'Content-Type': 'application/json; charset=UTF-8'},*/
        body:
            /*converting map to json*/
            json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price.toString(),
          'isFavorite': product.isFavorite.toString(),
        }),
      );
      /* print(json.decode(response.body)); */
      Product tmp = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _products.add(tmp);

      notifyListeners();
    } catch (error) {
      throw error;
    }
    /*when future done creating new product with id from firestore*/

    /*returnig error needed to handle error in edit product*/
    /*throw onError;*/
  }

  Product findById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  Future deleteProduct(String id) {
    return http
        .delete(Uri.parse(
            'https://shop-8956a-default-rtdb.europe-west1.firebasedatabase.app/products/$userId/$id.json?auth=$token'))
        .then((response) {
      if (response.statusCode < 201) {
        _products.removeWhere((element) => element.id == id);
        notifyListeners();
      }
      return response;
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> ubdateProduct(Product product) async {
    var prodIndex = products.indexWhere((element) => element.id == product.id);
    final ubdateRes = await _ubdateDocument(product);
    _products[prodIndex] = product;
    notifyListeners();
    return ubdateRes;
  }

  _ubdateDocument(Product product) {
    return http
        .patch(
          Uri.parse(
              'https://shop-8956a-default-rtdb.europe-west1.firebasedatabase.app/products/$userId/${product.id}.json?auth=$token'),
          body: json.encode({
            'title': product.title,
            'desFuture<void> cription': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price.toString(),
            'isFavorite': product.isFavorite.toString(),
          }),
        )
        .catchError((onError) => throw onError);
  }

  Future<http.Response> fetchAlbum() {
    print(token);
    return http
        .get(Uri.parse(
            'https://shop-8956a-default-rtdb.europe-west1.firebasedatabase.app/products/$userId.json?auth=$token'))
        .catchError((onError) => throw onError);
  }

  Future<void> featchData() async {
    late http.Response data;
    try {
      data = await fetchAlbum();
    } catch (error) {
      throw error;
    } finally {
      final Map<String, dynamic> decodedData = jsonDecode(data.body);
      /* print('decodedData: $decodedData'); */
      List<Product> tmp = [];
      decodedData.forEach((key, value) {
        bool isFavorite = value['isFavorite'].toLowerCase() == 'true';
        tmp.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: double.parse(value['price']),
            imageUrl: value['imageUrl'],
            isFavorite: isFavorite));
      });

      _products = tmp;
      notifyListeners();
    }
    ;
  }
}
