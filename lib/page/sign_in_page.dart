import 'package:flutter/material.dart';
import '../widget/logo.dart'; // Import logo.dart
import '../widget/form_content.dart'; // Import form_content.dart
import '../widget/form_content_signup.dart'; // Import form_content_signup.dart

class SignInPage2 extends StatefulWidget {
  const SignInPage2({Key? key}) : super(key: key);

  @override
  State<SignInPage2> createState() => _SignInPage2State();
}

class _SignInPage2State extends State<SignInPage2> {
  // Variable para gestionar qué formulario mostrar
  bool _showSignUp = false;

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/medico3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Logo(isSmallScreen: true),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 700),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      child: child,
                      opacity: animation,
                    );
                  },
                  // transitionBuilder:
                  //     (Widget child, Animation<double> animation) {
                  //   return FadeTransition(
                  //     opacity: animation,
                  //     child: ScaleTransition(
                  //       scale: animation,
                  //       child: child,
                  //     ),
                  //   );
                  // },

                  child: _showSignUp
                      ? FormContentSignUp(key: UniqueKey())
                      : FormContent(key: UniqueKey()),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showSignUp = !_showSignUp;
                    });
                  },
                  child: Text(
                    _showSignUp
                        ? '¿Already have an account? log in'
                        : '¿Not have an account? sign up',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
