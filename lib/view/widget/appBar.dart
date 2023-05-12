import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/main.dart';

PreferredSizeWidget appBarWidget({
  required String pageName,
  required BuildContext context,
  IconData? icon,
  String svg = '',
  bool withoutIcons = false,
}) {
  return AppBar(
    leading: icon == null ? withoutIcons == false ? SvgPicture.asset(
      svg,
      fit: BoxFit.scaleDown,
    ) : null
      : Icon(icon, color: Colors.white, size: 30),
      
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: const CircleBorder(),
            shadowColor: Colors.transparent,
          ),
          
          child: const Icon(
              Icons.logout,
              size: 30,
            ),
          onPressed: () { 
            LoginController().logout(context);
          },
        ),
      ),
    ],
    title: Text(pageName),
    
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            globals.primaryBlack,
            globals.primary.withRed(100),
          ]
        )
      ),
    ),
    backgroundColor: globals.primary,
  );
}