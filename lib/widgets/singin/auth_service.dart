import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Registro con email y contraseña
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error al registrar usuario: $e");
      return null;
    }
  }

  // Inicio de sesión con email y contraseña
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error al iniciar sesión: $e");
      return null;
    }
  }


  // Cierre de sesión
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("Error al cerrar sesión: $e");
    }
  }
}
