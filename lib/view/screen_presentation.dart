// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenPresentation extends StatelessWidget {
  const ScreenPresentation({super.key});

  final String assetPresentation = 'lib/images/imgPresentation.svg';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),

          child: Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  assetPresentation,
                  height: 220,
                  fit: BoxFit.fill,
                ),

                Text(
                  'Peça sua pizza de onde quiser e divida com quem você ama',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}