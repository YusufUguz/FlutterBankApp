import 'package:bank_app/screens/home_screen.dart';
import 'package:bank_app/widgets/scale_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  final firebaseAuth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> signInWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    final UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    // ignore: use_build_context_synchronously
    final navigator = Navigator.of(context);

    try {
      if (userCredential.user != null) {
        navigator.push(scaleAnimation(const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> signUpWithEmailAndPassword(
      {required BuildContext context,
      required String adSoyad,
      required String tcNo,
      required String telNo,
      required String email,
      required String dogumTarihi,
      required String password}) async {
    final UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    try {
      if (userCredential.user != null) {
        _createUser(
            adSoyad: adSoyad,
            tcNo: tcNo,
            telNo: telNo,
            email: email,
            dogumTarihi: dogumTarihi,
            password: password);
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> _createUser(
      {required String adSoyad,
      required String tcNo,
      required String telNo,
      required String email,
      required String dogumTarihi,
      required String password}) async {
    await userCollection.doc().set({
      'adSoyad': adSoyad,
      'TCNO': tcNo,
      'telNo': telNo,
      'email': email,
      'dogumTarihi': dogumTarihi,
      'sifre': password,
    });
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
