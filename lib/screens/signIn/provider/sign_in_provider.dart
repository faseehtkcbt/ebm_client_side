import 'dart:convert';
import 'dart:html' as html;
import 'package:client_side/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../../../utility/snack_bar_helper.dart';
class SignInProvider extends ChangeNotifier{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<String> login() async {
    final url = Uri.parse('$MAIN_URL/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token'];
        _saveData('token', token);
        _saveData('isLoggedIn', 'success');
        _saveData('user', responseData['user']['name']);
        _saveData('email', responseData['user']['email']);
        SnackBarHelper.showSuccessSnackBar('${responseData['message']}');
        return responseData['message'];
      } else {
        // Handle server errors
        final errorData = json.decode(response.body);
        throw errorData['message'];
      }
    } catch (error) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $error');
      rethrow;
    }
  }
  void _saveData(String key,String value) {
    html.window.localStorage[key] = value;// Reload stored data after saving
  }
  clearField(){
    emailController.clear();
    passwordController.clear();
  }
}

