import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Auth extends StatelessWidget {
  Future<String> _signupUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');

    var url = Uri.parse('http://10.0.2.2:3000/api/auth/signup');

    var response = await http.post(url, body: {
      'username': "",
      'password': data.password,
      'email': data.name,
      'isSeller': "",
      'adress': ""
    });

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('token', jsonDecode(response.body)["token"]);
    }

    return "";
  }

  Future<String> _loginUser(LoginData data) async {
    var url = Uri.parse('http://10.0.2.2:3000/api/auth/login');

    var response = await http.post(url, body: {
      'username': "",
      'password': data.password,
      'email': data.name,
      'isSeller': "",
      'adress': ""
    });

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('token', jsonDecode(response.body)["token"]);
    }

    return jsonDecode(response.body)["message"];
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: "PATTY APP",
      onSignup: _signupUser,
      onLogin: _loginUser,
      hideForgotPasswordButton: true,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      },
    );
  }
}
