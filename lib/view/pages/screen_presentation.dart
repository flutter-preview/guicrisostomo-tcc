// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';

class ScreenPresentation extends StatelessWidget {
  const ScreenPresentation({super.key});

  final String imgPresentation = 'lib/images/imgPresentation.svg';
  
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
                      Navigator.pop(context);
                      GoRouter.of(context).go('/login');
                    }, false),

                    button('Cadastrar', MediaQuery.of(context).size.width * 0.4, 70, Icons.person_add_outlined, () {
                      Navigator.pop(context);
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
                      Navigator.pop(context);
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