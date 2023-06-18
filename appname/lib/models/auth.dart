import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/constants.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    print('teste');
    print(isValid);
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

  Future<void> _authenticate(
    String email,
    String password,
  ) async {
    final url = 'https://api.projetos.innovareti.com.br/api/v1/login';
    final response = await http.post(
      Uri.parse(url),
      body: ({
        'email': email,
        'password': password,
      }),
    );
    print(response.body);

    final body = jsonDecode(response.body);
    if (body['access_token'] != null) {
      _token = body['access_token'];

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: (body['expires_in']),
        ),
      );
      print(_expiryDate);
      print('Mensagem teste');

      print(_token);
    } else {
      _token = body['access_token'];

      // print(_token);

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expires_in']),
        ),
      );
      print('Mensagem de consolo');
      print(_expiryDate);
    }
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(
      email,
      password,
    );
  }

  Future<void> login(String email, String password) async {
    return _authenticate(
      email,
      password,
    );
  }
}
