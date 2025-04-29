import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Google Sign-In
  Future<User?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;
      
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = 
          await _auth.signInWithCredential(credential);
      
      if (userCredential.user != null) {
        await _createUserDocument(userCredential.user!);
      }
      return userCredential.user;
    } catch (e) {
      _showErrorToast("Google sign-in failed");
      debugPrint("Google sign-in error: $e");
      return null;
    }
  }

  // Email Login
  Future<User?> login(String email, String password) async {
    try {
      final UserCredential userCredential = 
          await _auth.signInWithEmailAndPassword(
            email: email, 
            password: password
          );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _showErrorToast(_getAuthErrorMessage(e));
      return null;
    }
  }

  // Email Signup
  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = 
          await _auth.createUserWithEmailAndPassword(
            email: email, 
            password: password
          );

      if (userCredential.user != null) {
        await _createUserDocument(userCredential.user!);
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _showErrorToast(_getAuthErrorMessage(e));
      return null;
    }
  }

  // Create/Update User Document
  Future<void> _createUserDocument(User user) async {
    await _firestore.collection('Users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Helper Methods
  String _getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password': return 'Password is too weak!';
      case 'email-already-in-use': return 'Email already in use!';
      case 'user-not-found': return 'No user found with this email';
      case 'wrong-password': return 'Incorrect password';
      case 'invalid-email': return 'Invalid email address';
      case 'user-disabled': return 'This account has been disabled';
      default: return 'Authentication failed';
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  Future<String> getUID() async {
  final user = _auth.currentUser;
  if (user == null) {
    throw Exception("User not authenticated");
  }
  return user.uid;
}
}