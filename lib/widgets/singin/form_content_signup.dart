import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metageneticsapp/page/HomePage.dart';

class FormContentSignUp extends StatefulWidget {
  const FormContentSignUp({Key? key}) : super(key: key);

  @override
  _FormContentSignUpState createState() => _FormContentSignUpState();
}

class _FormContentSignUpState extends State<FormContentSignUp>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );

    // Retraso para iniciar la animación para dar efecto de aparición
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        // Verifica si el estado todavía está montado
        _animationController.forward();
      }
    });
  }

  Future<void> _register() async {
  if (_formKey.currentState?.validate() ?? false) {
    print("Form is valid, attempting to register...");
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print("Registration successful, user: ${userCredential.user}");

      if (!mounted) return; // Check if the widget is still mounted

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
      // Optionally navigate to a new screen here if the widget is still mounted
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException caught: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${e.message}')),
      );
    } catch (e) {
      print("General exception caught: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
    }
  } else {
    print("Form is not valid");
  }
}

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: buildFormChildren(), // Mueve los hijos a un método
          ),
        ),
      ),
    );
  }

  List<Widget> buildFormChildren() {
    return [
      TextFormField(
        controller: _emailController, // Asegúrate de agregar esta línea
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
      FadeTransition(
        opacity: _animation,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name and surname',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please, introduce your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
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
          ],
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
            icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility),
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
            return 'Please introduce a password';
          } else if (value.length < 6) {
            return 'The password has to have at least 6 characters';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      FadeTransition(
        opacity: _animation,
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
            icon: const Icon(FontAwesomeIcons.twitter),
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
                _register(); // Assuming _register is a method that handles your registration logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );

                // Corrected navigation logic
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomePage()), // Assuming HomePage is a valid route
                );
              }
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
