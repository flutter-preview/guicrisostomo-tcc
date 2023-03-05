import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

PreferredSizeWidget appBarWidget({
  required String pageName,
  required IconData icon,
}) {
  return AppBar(
    leading: Icon(icon, color: Colors.white, size: 30),
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