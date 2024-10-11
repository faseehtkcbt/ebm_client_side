import 'package:client_side/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_pages.dart';

class SignUpForm extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  const SignUpForm({Key? key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: padding ?? EdgeInsets.all(20),
      child: Form(
        key: context.signUpProvider.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: context.signUpProvider.nameController,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter The UserName';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "UserName",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            TextFormField(
              controller: context.signUpProvider.adminController,
              decoration: InputDecoration(
                labelText: "Admin Code",
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter The Admin Code';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: context.signUpProvider.emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter The Email';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: context.signUpProvider.passwordController,
              obscureText: true,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter The Password';
                }
                if(value.length < 8){
                  return 'Password should be atleast 8 character';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            TextFormField(
              controller: context.signUpProvider.cnfPasswordController,
              obscureText: true,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter The Confirm Password';
                }
                if(value != context.signUpProvider.passwordController.text ){
                  return 'Password and Confirm Password must be same!!';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(context.signUpProvider.formKey.currentState!.validate()){
                  context.signUpProvider.signup().then((value){
                    if(value =='User created!'){
                    Get.offNamed(AppPages.SIGN_IN);}
                  });
                }
                // Handle Sign Up logic
              },
              child: Text("Sign Up"),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.offNamed(AppPages.SIGN_IN);
              },
              child: Text("Already have an account? Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}