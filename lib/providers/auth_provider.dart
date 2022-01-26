import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shop/models/http_exception.dart';

class Auth extends ChangeNotifier {
  String _token = '';
  DateTime _expiryDate = DateTime.now();
  String _userId = '';

  Future<void> _authentication(
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
    if (response.statusCode > 201) {
      throw (HttpException(responseData['error']['message']));
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword');
  }
}
