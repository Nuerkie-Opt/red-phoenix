import 'package:ecommerceproject/components/alert.dart';
import 'package:ecommerceproject/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
//log in with email and password
  Future logIn(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredentials = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredentials.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        alert(context, 'User not found');
        print(e);
      } else if (e.code == 'wrong-password') {
        alert(context, 'Invalid credentials');
        print(e);
      }
      return null;
    }
  }

//sign up with email and password
  Future signUp(String name, String email, String password, BuildContext context) async {
    try {
      UserCredential userCredentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredentials.user;

      user?.updateDisplayName(name);
      await DatabaseService(uid: user?.uid).updateUserDData(name, email);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        alert(context, 'The password provided is too weak');
        print(e);
      } else if (e.code == 'email-already-in-use') {
        alert(context, 'An account already exists for this email');
        print(e);
      }
      return null;
    }
  }

//log out

}
