import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcc/view/widget/snackBars.dart';

class LoginController {
  void createAccount(context, String name, String email, String phone, String password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((res) {

      FirebaseFirestore.instance.collection('users')
        .add(
          {
            "uid" : res.user!.uid.toString(),
            "name" : name,
            "email" : email,
            "phone" : phone,
            "photo" : 'https://i.pinimg.com/originals/0c/3b/3a/0c3b3adb1a7530892e55ef36d3be6cb8.png',
          }
        );

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

    await googleSignIn.signOut();
    
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
}