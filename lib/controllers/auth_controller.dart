// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_diary/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

// SharedPreferences preferences = await SharedPreferences.getInstance();
//         await preferences.setInt('user_id', responseMap['data']['id']);
//         await preferences.setString('name', responseMap['data']['name']);
//         await preferences.setString('email', responseMap['data']['email']);
//         await preferences.setString('token', responseMap['access_token']);
