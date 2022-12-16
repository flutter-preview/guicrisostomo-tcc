import 'package:flutter/material.dart';

Widget button(String text, double width, double height, Function onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height), 
        backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
      ),
      
      onPressed: onPressed(),
      
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
        )
      ),

    );
  }