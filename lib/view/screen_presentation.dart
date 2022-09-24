// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tcc/modal/button.dart';

import '../modal/imageMainScreens.dart';

class ScreenPresentation extends StatelessWidget {
  const ScreenPresentation({super.key});

  final String imgPresentation = 'lib/images/imgPresentation.svg';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(20),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                  SizedBox(height: 0,),
                  Container(
                    child: Column(
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
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      button('Entrar', context, 'login'),
                      button('Cadastrar', context, 'register'),
                    ],
                  )
              ]),
          ),
        ),
    );
  }
}