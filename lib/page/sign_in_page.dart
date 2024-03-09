import 'package:flutter/material.dart';
import '../widget/logo.dart'; // Importa logo.dart
import '../widget/form_content.dart'; // Importa form_content.dart
import '../widget/form_content_signup.dart'; // Importa form_content_signup.dart

class SignInPage2 extends StatefulWidget {
  const SignInPage2({Key? key}) : super(key: key);

  @override
  State<SignInPage2> createState() => _SignInPage2State();
}

class _SignInPage2State extends State<SignInPage2> {
  bool _showSignUp = false;

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/pastis2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width:
                  isSmallScreen ? MediaQuery.of(context).size.width * 0.9 : 600,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Logo(isSmallScreen: isSmallScreen),
                  ),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        child: child,
                        opacity: animation,
                      );
                    },
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
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize:
                                16.0, // Puedes ajustar el tamaño a tu necesidad
                            color: Colors
                                .white, // Color predeterminado para todo el texto
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: _showSignUp
                                  ? '¿Already have an account? '
                                  : '¿Not have an account? ',
                            ),
                            TextSpan(
                              text: _showSignUp ? 'Sign in' : 'Sign up',
                              style: const TextStyle(
                                color: Colors
                                    .redAccent, // Color rojo para "SignIn" o "SignUp"
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
