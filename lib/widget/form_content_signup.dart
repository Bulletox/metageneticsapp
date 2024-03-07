import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormContentSignUp extends StatefulWidget {
  const FormContentSignUp({Key? key}) : super(key: key);

  @override
  _FormContentSignUpState createState() => _FormContentSignUpState();
}

class _FormContentSignUpState extends State<FormContentSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  double _nameFieldOpacity = 0; // Agrega esta línea para controlar la opacidad

  @override
  void initState() {
    super.initState();
    // Cambia la opacidad después de un corto retraso para mostrar la animación
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _nameFieldOpacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AnimatedOpacity(
              opacity: _nameFieldOpacity,
              duration: const Duration(seconds: 1),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name and surname',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, introduce your user name';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            AnimatedOpacity(
              opacity: _nameFieldOpacity,
              duration: const Duration(seconds: 1),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Number of SS',
                  prefixIcon: Icon(Icons.local_library_rounded),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, introduce your SS number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please introduce a password ';
                } else if (value.length < 6) {
                  return 'The password has to have 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            AnimatedOpacity(
              opacity: _nameFieldOpacity,
              duration: const Duration(seconds: 1),
              child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_isConfirmPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'The passwords do not match';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                
                IconButton(
                  icon: const Icon(FontAwesomeIcons.facebook),
                  onPressed: () {
                    // Placeholder for Facebook login logic
                    print('Facebook sign-in button pressed');
                  },
                  color: Colors.blue[800],
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.github),
                  onPressed: () {
                    // Placeholder for GitHub login logic
                    print('GitHub sign-in button pressed');
                  },
                  color: Colors.black,
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.google),
                  onPressed: () {
                    // Placeholder for Google sign-in logic
                    print('Google sign-in button pressed');
                  },
                  color: Colors.red,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Insert sign-in logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ],
        ),
        
      ),
    );
  }

  @override
  void dispose() {
    // Limpia los controladores cuando el widget sea desmontado
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
