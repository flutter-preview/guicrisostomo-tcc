import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/globals.dart' as globals;

PreferredSizeWidget appBarWidget({
  required String pageName,
  required BuildContext context,
  IconData? icon,
  String svg = '',
}) {
  return AppBar(
    leading: icon == null ? SvgPicture.asset(
      svg,
      fit: BoxFit.scaleDown,
    ) : Icon(icon, color: Colors.white, size: 30),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: IconButton(
          icon: Icon(
            Icons.abc,
            size: 30,
          ),
          onPressed: () { 
            Navigator.pushNamed(context, '/cart');
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