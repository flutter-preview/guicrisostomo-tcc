// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/view/widget/snackBars.dart';

Future<UserCredential> signInGoogle(context) async {
  
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
  await signInGoogle(context).then((value) {
    success(context, 'Usuário autenticado com sucesso');

    FirebaseFirestore.instance.collection('users')
        .add(
          {
            "uid" : value.user?.uid,
            "name" : value.user?.displayName,
            "email" : value.user?.email,
            "phone" : null,
            "photo" : value.user?.photoURL,
          }
        );

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