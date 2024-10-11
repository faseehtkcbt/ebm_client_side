import 'package:flutter/material.dart';
import '../../utility/responsive.dart';
import 'components/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Responsive(
        mobile: SignInForm(),
        tablet: SignInForm(padding: EdgeInsets.symmetric(horizontal: 50)),
        desktop: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    'Welcome to EBM',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SignInForm(
                padding: EdgeInsets.symmetric(horizontal: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}