import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mysql1/mysql1.dart';
import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/main.dart';
import 'package:tcc/view/widget/snackBars.dart';
      
class LoginController {
  Future<String?> getTypeUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final MySqlConnection conn = await connectMySQL();
    Results results = await conn.query('select tu.name from user u INNER JOIN type_user tu ON u.type = tu.id where uid = ?', [user?.uid]);
    conn.close();

    if (results.isEmpty) {
      return null;
    }

    for (var row in results) {
      return row[0];
    }
  }

  Future<void> signInAnonymously(context) async {
    (FirebaseAuth.instance.currentUser?.uid != null) ? {
      await userLogin(),
      success(context, 'Usuário autenticado com sucesso.')
    } : {
      await FirebaseAuth.instance.signInAnonymously().then((value) {
        userLogin();
      }).catchError((e) {
        error(context, 'Ocorreu um erro ao fazer login: ${e.code.toString()}');
      })
    };
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
        redirectUser(context);
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
        .then((res) async {
      success(context, 'Usuário autenticado com sucesso.');
      // Navigator.of(context).pop();
      redirectUser(context);

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

    return connectMySQL().then((conn) async {
      Results results = await conn.query('select * from user where uid = ?', [uid]);
      conn.close();
      return results.first;
    });
  }

  Future<void> updateUser(id, name, email, phone, context) async {
    final MySqlConnection conn = await connectMySQL();
    await conn.query('update user set name=?, email=?, phone=? where uid=?',
    [name, email, phone, id]);

    conn.close();

    redirectUser(context);

    success(context, 'Usuário atualizado com sucesso.');

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
      redirectUser(context, value);
      //value.additionalUserInfo?.profile!['email']
    }).catchError((onError) {
      error(context, "Ocorreu um erro ao entrar: $onError");
    });
  }

  Future<void> redirectUser(context, [value]) async {
    // Navigator.of(context).pop();
      // var t = await getTypeUser() ?? 'Cliente';
      // success(context, t);
      // return;
    await getTypeUser().then((String? typeUser) async {
      success(context, typeUser.toString());

      if (typeUser == null) {
        await connectMySQL().then((insert) {
          insert.query('insert into user (uid, name, email, phone, type, image) values (?, ?, ?, ?, ?, ?)',
            [value.user?.uid, value.user?.displayName, value.user?.email, null, 1, value.user?.photoURL]);
        },);

        Navigator.of(context).pop();
        Navigator.push(
          context,
          navigator('home'),
        );

        return;
      }

      switch (typeUser) {
        case 'Cliente':
          Navigator.of(context).pop();
          Navigator.push(
            context,
            navigator('home'),
          );
          break;
        case 'Gerente':
          Navigator.of(context).pop();
          Navigator.push(
            context,
            navigator('home_manager'),
          );
          break;
        default:
          Navigator.of(context).pop();
          Navigator.push(
            context,
            navigator('home_employee'),
          );
          break;
      }
    });
  }
}