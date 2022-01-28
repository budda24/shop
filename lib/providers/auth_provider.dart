import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:shop/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token = '';
  DateTime _expiryDate = DateTime.now();
  String _userId = '';

  bool userIsAuthenticated = false;
  String get token {
    return _token;
  }

  String get userId {
    return _userId;
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
    /* checking if the response have error  */
    if (responseData['error'] != null) {
      /* trowing forward Http exeption */
      throw (HttpException(responseData['error']['message']));
    } else {
      /* ubdating the auth atributes */
      _token = responseData['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _userId = responseData['localId'];
      if (_token != '' &&
          _expiryDate != null &&
          _expiryDate.isAfter(DateTime.now())) {
        userIsAuthenticated = true;
        /* print(userIsAuthenticated); */
        notifyListeners();
        final prefrences = await SharedPreferences.getInstance();
        final authData = json.encode({
          'userId': _userId,
          'token': _token,
          'expireDate': _expiryDate.toIso8601String(),
        });
        prefrences.setString('authData', authData);

        _autoLogout();
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

  void logOut() {
    _expiryDate = DateTime.now();
    _token = '';
    _userId = '';
    userIsAuthenticated = false;
    notifyListeners();
  }

  void _autoLogout() {
    /* checking if the auth data don't expired */
    final timeEpirecy = Timer(
        Duration(
          seconds: _expiryDate.difference(DateTime.now()).inSeconds,
        ),
        logOut);
  }

  Future<bool> checkLogIn() async {
    /* init the box with stored auth data */
    final prefrences = await SharedPreferences.getInstance();

    /* checking if box kontains the auth key */
    if (!prefrences.containsKey('authData')) {
      return false;
    }

    /* geting the map stored in box at value 'authData' */
    final prefrencesData = json.decode(prefrences.get('authData').toString());

    /* converting data from toIso8601String() bact to date object */
    final dateTime = DateTime.parse((prefrencesData['expireDate'] as String));

    /* checking if the auth data are not expired */
    if (dateTime.isBefore(DateTime.now())) {
      /* print('dateTime.isBefore(DateTime.now())'); */
      return false;
    }

    /* print(prefrencesData['userId']); */
    _userId = prefrencesData['userId'].toString();
    _token = prefrencesData['token'].toString();
    _expiryDate = dateTime;
    userIsAuthenticated = true;
    notifyListeners();
     _autoLogout();
    return true;
  }
}
