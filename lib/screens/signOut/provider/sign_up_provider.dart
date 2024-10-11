import 'dart:convert';
import 'dart:io';
import 'package:client_side/utility/constants.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';

import '../../../utility/snack_bar_helper.dart';

class SignUpProvider extends ChangeNotifier{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final cnfPasswordController = TextEditingController();
  final adminController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  Future<String> signup() async {
    final url = Uri.parse('$MAIN_URL/auth/signup');
    try {
      if(adminController.text.toLowerCase().trim() == 'ebm123'){
        final response = await http.put(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': emailController.text,
            'name': nameController.text,
            'password': passwordController.text,
          }),
        );

        if (response.statusCode == 201) {
          final responseData = json.decode(response.body);
          clearField();
          SnackBarHelper.showSuccessSnackBar('${responseData['message']}');
          return responseData['message'];
        } else {
          // Handle server errors
          final errorData = json.decode(response.body);
          throw errorData['message'];
        }
      }
      else{
        final error = 'Please check the admin code';
        throw error;
      }

    } catch (error) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $error');
      rethrow;
    }
  }
  clearField(){
    emailController.clear();
    passwordController.clear();
    cnfPasswordController.clear();
    nameController.clear();
    adminController.clear();
  }
}