import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:origin/model/responses/customer.dart';
import 'package:origin/user_preferences/user_preferences.dart';
import '../ui/screens/home/dashboard.dart';
import '../ui/screens/login/loginScreen.dart';

class Auth {
  Login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await UserPreferences.saveLoginUserInfo(
          ModelCustomer(email: email, id: userCredential.user!.uid));
      print('Email Login:  ${await UserPreferences.getUserEmail()}');
      if (userCredential != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Dashboard()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User Not Found')));
      }
    }
  }

  SignUp(
      {required String emailid,
      required String pass,
      required BuildContext context,
      required String username}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailid, password: pass);

      User? user = userCredential.user;
      await user?.updateDisplayName(username);

      FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set({'uid': user!.uid, 'uemail': userCredential.user!.email, 'uname': userCredential.user!.displayName});

      await UserPreferences.saveLoginUserInfo(ModelCustomer(
          email: emailid,
          name: userCredential.user!.displayName,
          id: userCredential.user!.uid));
      print("Email Signup:  ${await UserPreferences.getUserEmail()}");
      print("UserName Signup:  ${await UserPreferences.getLoginUserInfo(ModelCustomer())}");

      if (userCredential != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User Not Found')));
      }
    }
  }

  ResetPasss({required String emailid, context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailid,
      );
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User Not Found')));
      }
    }
  }
}

