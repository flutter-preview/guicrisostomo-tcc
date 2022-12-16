import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

Widget button(String text, double width, double height, Function() onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: globals.primary, spreadRadius: 1),
        ],
      ),

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height), 
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          )
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

      ),
    );
  }