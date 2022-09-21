// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tcc/modal/button.dart';

class ScreenPresentation extends StatelessWidget {
  const ScreenPresentation({super.key});

  final String assetPresentation = 'lib/images/imgPresentation.svg';
  
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
                        SvgPicture.asset(
                          assetPresentation,
                          height: 220,
                          fit: BoxFit.fill,
                        ),
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