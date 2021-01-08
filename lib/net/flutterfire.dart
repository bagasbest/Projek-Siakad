import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    print(e.message);
    return false;
  }
}

Future<bool> register(String name, String email, String password) async {
  try {
    final c1 = Crypt.sha256(password);
    final User user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;
    FirebaseFirestore.instance.collection("users").doc(user.uid).set(
        {"name": name, "email": email, "password": c1.toString(), "image": ""});
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak');
    } else if (e.code == 'Email-already-in-use') {
      print('The account already used');
    }
    return false;
  } catch (signUpError) {
    if (signUpError is PlatformException) {
      if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        Fluttertoast.showToast(
            msg: "Email telah terdaftar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    return false;
  }
}
