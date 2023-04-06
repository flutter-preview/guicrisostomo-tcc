import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mysql1/mysql1.dart';
import 'package:tcc/controller/mysql/connect.dart';
import 'package:tcc/shared/config.dart';
import 'package:tcc/view/widget/snackBars.dart';
      
class LoginController {

  Future<void> signInAnonymously(context) async {
    try {
      final userCredential =
      await FirebaseAuth.instance.signInAnonymously();
      success(context, 'Usuário autenticado com sucesso.');
    } on FirebaseAuthException catch (e) {
      error(context, 'Ocooreu um erro ao fazer login: ${e.code.toString()}');
    }
  }
  void createAccount(context, String name, String email, String phone, String password) {
    FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((res) async {

        final MySqlConnection conn = await connectMySQL();
        await conn.query('insert into user (uid, name, email, phone, type) values (?, ?, ?, ?, ?)',
        [res.user?.uid, name, email, phone.replaceAll(RegExp(r'[-() ]'), ''), 1]);

        conn.close();

        success(context, 'Usuário criado com sucesso.');
        Navigator.pop(context);
        Navigator.pushNamed(
          context,
          'home',
        );
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          error(context, 'O email já foi cadastrado.');
          break;
        case 'invalid-email':
          error(context, 'O email é inválido.');
          break;
        default:
          error(context, e.code.toString());
      }
    });
  }

  void login(context, String email, String senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      success(context, 'Usuário autenticado com sucesso.');
      Navigator.of(context).pop();
      Navigator.pushNamed(
        context,
        'home',
      );
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          error(context, 'O formato do email é inválido.');
          break;
        case 'user-not-found':
          error(context, 'Usuário não encontrado.');
          break;
        case 'wrong-password':
          error(context, 'Senha incorreta.');
          break;
        default:
          error(context, e.code.toString());
      }
    });
  }

  Future<void> forgetPassword(String email, context) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      success(context, 'E-mail de recuperação de senha enviado com sucesso');
    }).catchError((e) {
      error(context, 'Ocorreu um erro ao enviar seu e-mail de recuperação de senha: ${e.code.toString()}');
    });

    Navigator.of(context).pop();
    Navigator.pushNamed(
      context,
      'presentation',
    );
  }

  Future<void> logout(context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    if (googleSignIn.clientId != null) {
      await googleSignIn.signOut();
    }
    
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
    Navigator.pushNamed(
      context,
      'presentation',
    );
  }

  Future<dynamic> userLogin() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    dynamic res = '';
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then(
      (q) {
        if (q.docs.isNotEmpty) {
          res = q.docs[0];
          return res;
        } else {
          res = null;
        }
      },
    ).catchError((e) {
      res = null;
    });

    return res;
  }

  void updateUser(id, name, email, phone, context) {
    FirebaseFirestore.instance.collection('users').doc(id).update(
      {
        "name": name,
        "email": email,
        "phone": phone,
      },
    );

    Navigator.of(context).pop();
    Navigator.pushNamed(
      context,
      'home',
    );

  }

  // Sign in with Google

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

  Future<void> signIn(context) async {
    await signInGoogle(context).then((value) async {
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

          final MySqlConnection conn = await connectMySQL();
          await conn.query('insert into user (uid, name, email, phone, type, image) values (?, ?, ?, ?, ?, ?)',
          [value.user?.uid, value.user?.displayName, value.user?.email, null, 1, value.user?.photoURL]);

          conn.close();

          

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
}