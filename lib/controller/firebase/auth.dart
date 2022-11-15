import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
            "phone" : phone,
          }
        );

      success(context, 'Usuário criado com sucesso.');
      Navigator.pop(context);
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
    Navigator.of(context).pop();
    Navigator.pushNamed(
      context,
      'login/forget_password',
    );
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  void logout(context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
    Navigator.pushNamed(
      context,
      'presentation',
    );
  }

  Future<String> userLogin() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var res;
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then(
      (q) {
        if (q.docs.isNotEmpty) {
          res = q.docs[0].data()['name'];
        } else {
          res = "";
        }
      },
    );
    return res;
  }
}