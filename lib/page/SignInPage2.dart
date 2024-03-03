import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/AuthService.dart'; // Importa el servicio de autenticación
class SignInPage2 extends StatelessWidget {
  const SignInPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/medico3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: isSmallScreen
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _Logo(
                        isSmallScreen:
                            true), // Añade el parámetro isSmallScreen
                    _FormContent(),
                  ],
                )
              : Container(
                  padding: const EdgeInsets.all(32.0),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Row(
                    children: const [
                      Expanded(
                          child: _Logo(
                              isSmallScreen:
                                  false)), // Añade el parámetro isSmallScreen
                      Expanded(
                        child: Center(child: _FormContent()),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final bool isSmallScreen; // Añade esta propiedad
  const _Logo({Key? key, required this.isSmallScreen})
      : super(key: key); // Modifica el constructor para recibir isSmallScreen

  @override
  Widget build(BuildContext context) {
    final String largeLogoPath = "lib/assets/images/logo-white.png";

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0), // Ajusta según sea necesario
      // Usa isSmallScreen para determinar el ancho del logo en pantallas pequeñas
      child: Image.asset(
        largeLogoPath,
        width: isSmallScreen
            ? 300
            : 200, // Aquí se ajusta el ancho para pantallas pequeñas
        height: isSmallScreen
            ? null
            : 200, // Permite que el alto sea flexible en pantallas pequeñas
        fit: BoxFit.contain,
      ),
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => _FormContentState();
}

class _FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService(); // Instancia de AuthService

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8.0),
      ),
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (bool? value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
              title: const Text('Remember me'),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Insert sign-in logic here
                }
              },
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 16),
            // Social Media Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: const Icon(FontAwesomeIcons.facebook),
                  onPressed: () {
                    // Implement Facebook login logic
                  },
                  color: Colors.blue[800],
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.google),
                  onPressed: () async {
                    User? user = await _authService.signInWithGoogle(context);
                    if (user != null) {
                      // User has successfully logged in
                      // Navigate to another screen or handle successful login
                      print("User signed in: ${user.email}");
                    }
                  },
                  color: Colors.red,
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.github),
                  onPressed: () {
                    // Implement GitHub login logic
                  },
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _gap() => const SizedBox(height: 16);
