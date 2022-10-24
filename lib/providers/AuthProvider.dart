import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:login_practical/models/User.dart';

import 'dart:convert' as convert;

import '../utils/urls.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  get loggedInStatus => this._loggedInStatus;

  set loggedInStatus(value) => this._loggedInStatus = value;

  get registeredInStatus => this._registeredInStatus;

  set registeredInStatus(value) => this._registeredInStatus = value;

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    try {
      Response response = await post(
        Uri.parse(AppUrl.Login),
        body: convert.jsonEncode(loginData),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> responseData =
              convert.jsonDecode(response.body);

          User user = User.fromJson(responseData);
          print(user);

          _loggedInStatus = Status.LoggedIn;
          notifyListeners();

          result = {'status': true, 'message': 'Successful', 'user': user};
          break;
        default:
          _loggedInStatus = Status.NotLoggedIn;
          notifyListeners();
          final Map<String, dynamic> responseData =
              convert.jsonDecode(response.body);
          result = {
            'status': false,
            'message': responseData['message'],
            'token': null
          };
          break;
      }
    } on SocketException catch (e) {
      result = {'status': false, 'message': "$e", 'token': null};
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
    }

    return result;
  }

// registration

  Future<Map<String, dynamic>> register(
      String email, name, phone, String password, String role) async {
    var result;

    final Map<String, dynamic> signUpdata = {
      'email': email,
      'name': name,
      'phoneNumber': phone,
      'password': password,
      'role': role,
    };

    _registeredInStatus = Status.Registering;
    notifyListeners();

    try {
      Response response = await post(
        Uri.parse(AppUrl.register),
        body: convert.jsonEncode(signUpdata),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return Response('Error', 408); // Request Timeout response status code
        },
      );
      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> responseData =
              convert.jsonDecode(response.body);
          User user = User.fromJson(responseData);
          result = {'status': true, 'message': 'Successfull', 'user': user};
          _registeredInStatus = Status.Registered;
          notifyListeners();
          break;
        case 408:
          final Map<String, dynamic> responseData =
              convert.jsonDecode(response.body);
          result = {
            'status': false,
            'message': 'no internet, try again',
          };
          _registeredInStatus = Status.NotRegistered;
          notifyListeners();
          break;

        default:
          _registeredInStatus = Status.NotRegistered;
          notifyListeners();
          final Map<String, dynamic> responseData =
              convert.jsonDecode(response.body);
          result = {
            'status': false,
            'message': responseData['message'],
          };
          print(responseData);
          break;
      }
    } on SocketException catch (e) {
      result = {'status': false, 'message': "no internet connection"};
      _registeredInStatus = Status.NotRegistered;
      notifyListeners();
    }
    // if (response.statusCode == 200) {
    // } else {
    //   _loggedInStatus = Status.NotLoggedIn;
    //   notifyListeners();
    //   result = {
    //     'status': false,
    //     'message': convert.jsonDecode(response.body)['error']
    //   };
    // }

    return result;
  }
}
