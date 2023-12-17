// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_diary/screens/home_screen.dart';
import 'package:expense_diary/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// register function
createUserWithEmailAndPassword(BuildContext context, emailAddress,
    String password, String fullname, String gender, String address) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    // insert user data in users collection
    User? user = credential.user;
    FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'fullname': fullname,
      'email': emailAddress,
      'gender': gender,
      'address': address,
      'uid': user.uid,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

// login function
signInWithEmailAndPassword(
    BuildContext context, emailAddress, String password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    User? user = credential.user;
    if (user != null) {
      // store user id as token in the device
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('user_id', user.uid);
      await preferences.setString('email', user.email.toString());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
      print('Successfully Login!');
    } else {
      print('Login Failed!');
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

// logout or signout function
signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  // remove all data from SharedPreferences
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));
}

forgotPassword(BuildContext context, emailAddress) async {
  await FirebaseAuth.instance
      .sendPasswordResetEmail(email: emailAddress)
      .then((value) => {print("Email sent")});

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));

  try {} on FirebaseAuthException catch (e) {
    print("Error $e");
  }
}
