import 'package:flutter/material.dart';
import '../widget/form_content_signup.dart'; // Assuming you have a separate file for the form

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const [
              SizedBox(height: 20),
              Text('Create an Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              FormContentSignUp(), // This will be your form widget
            ],
          ),
        ),
      ),
    );
  }
}
