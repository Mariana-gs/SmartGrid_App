import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_grid/screens/home_screen.dart';


class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signWithEmailAndPasswaord({
    required String email,
    required String password,

  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password
      );
  }


  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
  }

  Future<void> signOut() async{
    await _auth.signOut();
  }

}