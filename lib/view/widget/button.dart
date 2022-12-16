import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

Widget button(String text, double width, double height, Function() onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height), 
        backgroundColor: Colors.white,
      ),
      
      onPressed: () {
        onPressed();
      },
      
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        )
      ),

    );
  }