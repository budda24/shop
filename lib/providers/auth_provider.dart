import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  String _token = '';
  DateTime _expiryDate = DateTime.now();
  String _userId = '';

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCCRmMD7YgTkO67PYLSFO_UCNst2lOanc0');
    print('post called');
    var response = await http
        .post(
          url,
          body: json.encode(
            {
              'email': email,
              'password': password,
              'returnSecureToken': true,
            },
          ),
        );
  }
}
