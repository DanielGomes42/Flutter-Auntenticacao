import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

class Auth with ChangeNotifier {
  Future<void> _authenticate(
    String email,
    String password,
  ) async {
    final url = 'https://api.projetos.innovareti.com.br/api/v1/login';
    final response = await http.post(Uri.parse(url), body: {
      'email': email,
      'password': password,
    }, headers: {});

    print(response.body);
  }

  Future<void> signup(dynamic email, dynamic password) async {
    _authenticate(
      email,
      password,
    );
  }

  Future<void> login(String email, String password) async {
    _authenticate(
      email,
      password,
    );
  }
}
