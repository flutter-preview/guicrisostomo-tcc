import 'package:flutter/material.dart';

Widget button(text, context, screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50), 
        backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
      ),
      
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
        )
      ),
      
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.pushNamed(
          context,
          screen,
        );
      },
    );
  }