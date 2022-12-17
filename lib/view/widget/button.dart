import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

Widget button(String text, double width, double height, Function() onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: globals.primary,
        boxShadow: [
          BoxShadow(color: globals.primaryBlack, spreadRadius: 3),
        ],
      ),

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height), 
          backgroundColor: globals.primary,
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
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )
        ),

      ),
    );
  }