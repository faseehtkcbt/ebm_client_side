import 'package:client_side/core/routes/app_pages.dart';
import 'package:client_side/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInForm extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  const SignInForm({Key? key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: padding ?? EdgeInsets.all(20),
      child: Form(
        key: context.signInProvider.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign In",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: context.signInProvider.emailController,
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
              controller: context.signInProvider.passwordController,
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
            ElevatedButton(
              onPressed: () {
                if(context.signInProvider.formKey.currentState!.validate()){
                  context.signInProvider.login().then((value){
                    if(value == 'User Logined!'){
                      Get.offNamed(AppPages.HOME);
                    }
                  });
                }
                // Handle Sign In logic
              },
              child: Text("Sign In"),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.offNamed(AppPages.SIGN_UP);
              },
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}