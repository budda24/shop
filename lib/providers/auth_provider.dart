import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shop/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token = '';
  DateTime? _expiryDate;
  String _userId = '';

  bool userIsAuthenticated = false;
  String get token {
    return _token;
  }

  Future<http.Response> _authentication(
      String email, String password, urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCCRmMD7YgTkO67PYLSFO_UCNst2lOanc0');
    final response = await http.post(url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ));
    var responseData = json.decode(response.body);
    /* print(responseData); */
    if (responseData['error'] != null) {
      throw (HttpException(responseData['error']['message']));
    } else {
      _token = responseData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _userId = responseData['localId'];
      if (_token != '' &&
          _expiryDate != null &&
          _expiryDate!.isAfter(DateTime.now())) {
        userIsAuthenticated = true;
        /* print(userIsAuthenticated); */
        notifyListeners();
      }
      return response;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authentication(email, password, 'signUp')
        .then((value) => print(value));
  }

  Future<void> signIn(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword')
        .then((value) => print(value));
  }
}
