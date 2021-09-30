import 'package:ecommerceproject/components/alert.dart';
import 'package:ecommerceproject/models/userInfo.dart';
import 'package:ecommerceproject/services/database.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
//log in with email and password
  Future logIn(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredentials = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredentials.user;
      await DatabaseService(uid: user?.uid).setLastSeen();
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
      await DatabaseService(uid: user?.uid).setLastSeen();
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

  // reset password
  Future resetPassword(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        alert(context, 'Email Address entered is invalid');
      }
      if (e.code == 'user-not-found') {
        alert(context, 'Account not found');
      }
      return null;
    }
  }

//log out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {}
  }

//get user data
  getUserData() {
    final User? user = _auth.currentUser;
    GlobalData.user = UserData(
        displayName: user?.displayName,
        email: user?.email,
        photoUrl: user?.photoURL,
        phoneNumber: user?.phoneNumber,
        uid: user?.uid);
  }

  updateProfilePic(String? photoUrl) async {
    final User? user = _auth.currentUser;
    user?.updatePhotoURL(photoUrl);
    await DatabaseService(uid: user?.uid).updateUserPhoto(photoUrl);
    return user;
  }
}
