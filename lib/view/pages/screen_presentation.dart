// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';

class ScreenPresentation extends StatefulWidget {
  const ScreenPresentation({super.key});

  @override
  State<ScreenPresentation> createState() => _ScreenPresentationState();
}

class _ScreenPresentationState extends State<ScreenPresentation> {
  final String imgPresentation = 'lib/images/imgPresentation.svg';

  Future<bool> isDataBaseRunning() async {
    bool isRunning = false;

    await connectSupadatabase().then((value) {
      isRunning = true;
    }).catchError((onError) {
      isRunning = false;
    });

    return isRunning;
  }

  verifiyUserAuth(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    
    if (user != null) {
      if (user.emailVerified == false) {
        GoRouter.of(context).go('/verify_email');
        isDataBaseRunning().then((value) {
          if (!value) {
            GoRouter.of(context).go('/error');
          }
        });
      } else {
        LoginController().getTypeUser().then((value) {
          if (value == 'Cliente') {
            GoRouter.of(context).go('/home');
          } else if (value == 'Gerente') {
            GoRouter.of(context).go('/home_manager');
          } else {
            GoRouter.of(context).go('/home_employee');
          }
        }).catchError((onError) {
          GoRouter.of(context).go('/error');
        });
      }
    } else {
      isDataBaseRunning().then((value) {
        if (!value) {
          GoRouter.of(context).go('/error');
        }
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      verifiyUserAuth(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50,),

            Column(
              children: [
                imgCenter(imgPresentation),
                SizedBox(height: 14,),
                Text(
                  'Peça sua pizza de onde quiser e divida com quem você ama',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    
                    button('Entrar', MediaQuery.of(context).size.width * 0.4, 70, Icons.input, () {
                      // GoRouter.of(context).pop();
                      GoRouter.of(context).go('/login');
                    }, false),

                    button('Cadastrar', MediaQuery.of(context).size.width * 0.4, 70, Icons.person_add_outlined, () {
                      // 
                      GoRouter.of(context).go('/register');
                    }),
                  ],
                ),
              ],
            ),

            Column(
              children: [
                Center(
                  child: button('Continuar sem logar', MediaQuery.of(context).size.width - 100, 50, Icons.arrow_forward, () async {
                    await LoginController.instance.signInAnonymously(context).whenComplete(() {
                      
                      GoRouter.of(context).go('/home');
                    });
                  }, false),
                ),

                SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ao continuar, você concorda com os nossos ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go('/terms');
                      },
                      child: Text(
                        'Termos de Uso',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            )
          ]
        ),
      ),
    );
  }
}