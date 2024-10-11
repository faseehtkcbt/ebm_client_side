import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utility/responsive.dart';
import 'components/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Responsive(
        mobile: SignUpForm(),
        tablet: SignUpForm(padding: EdgeInsets.symmetric(horizontal: 50)),
        desktop: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.greenAccent,
                child: Center(
                  child: Text(
                    'Join EBM',
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
              child: SignUpForm(
                padding: EdgeInsets.symmetric(horizontal: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}