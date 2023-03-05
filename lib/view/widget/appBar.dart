import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/globals.dart' as globals;

PreferredSizeWidget appBarWidget({
  required String pageName,
  IconData? icon,
  String svg = '',
}) {
  return AppBar(
    leading: icon == null ? SvgPicture.asset(
      svg,
      fit: BoxFit.scaleDown,
    ) : Icon(icon, color: Colors.white, size: 30),
    title: Text(pageName),
    
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            globals.primary,
            Colors.white10
          ]
        )
      ),
    ),
    backgroundColor: globals.primary,
  );
}