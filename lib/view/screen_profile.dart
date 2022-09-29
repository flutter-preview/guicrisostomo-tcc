// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../modal/bottonNavigationCustomer.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'lib/images/imgProfile.svg',
                      width: 100,
                    ),

                    Text(
                      'Rodrigo',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    Text(
                      '(16) 99999-9999',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              
            ]
          )
        )
      ),

      bottomNavigationBar: Bottom(),
    );
  }
}