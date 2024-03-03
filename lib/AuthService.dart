import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e, context);
      return null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred using Google Sign-In. Try again."),
        ),
      );
      return null;
    }
  }

  void _handleAuthError(FirebaseAuthException e, BuildContext context) {
    String errorMsg = "An authentication error occurred. Please try again.";
    if (e.code == 'account-exists-with-different-credential') {
      errorMsg = "An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.";
    } else if (e.code == 'invalid-credential') {
      errorMsg = "Error occurred while accessing credentials. Try again.";
    } // Agrega más manejo de errores según sea necesario

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMsg),
      ),
    );
  }
}
