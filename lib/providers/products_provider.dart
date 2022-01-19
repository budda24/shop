import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screeans/edit_product_screen.dart';
import '../providers/product.dart';

class Products with ChangeNotifier {
  /*getter for the private class _products*/
  List<Product> get products {
    /*print(_products[0]);*/
    return [..._products];
  }

  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

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

  Future<void> addProduct(Product product){


    /*creating object URI from string*/
    final uri = Uri.parse(
        'https://shop-8956a-default-rtdb.europe-west1.firebasedatabase.app/products.json');

       return  http.post(
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

      ).then((value) {
        /*when future done creating new product with id from firestore*/
        Product tmp = Product(id: json.decode(value.body)['name'],
            title: product.title,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl);
        _products.add(tmp);
        notifyListeners();
      }).catchError((onError){
        throw onError;
      });

    }

    Product findById(String id) {
      return _products.firstWhere((element) => element.id == id);
    }

    void deleteProduct(String id) {
      _products.removeWhere((element) => element.id == id);
      notifyListeners();
    }

    void ubdateProduct(Product product) {
      var prodIndex = products.indexWhere((element) =>
      element.id == product.id);
      _products[prodIndex] = product;
      notifyListeners();
    }
  }
