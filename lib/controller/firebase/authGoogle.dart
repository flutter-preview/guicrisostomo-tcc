// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcc/view/widget/snackBars.dart';

Future<UserCredential> signInGoogle() async {
  
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

void signIn(context) async {
  await signInGoogle().then((value) {
    success(context, 'Usuário autenticado com sucesso');

    Navigator.of(context).pop();
    Navigator.pushNamed(
      context,
      'home',
    );
    //value.additionalUserInfo?.profile!['email']
  }).catchError((onError) {
    error(context, "Ocorreu um erro ao entrar: $onError");
  });
}