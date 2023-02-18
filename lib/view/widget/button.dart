import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

Widget button(String text, double width, double height, IconData icon, Function() onPressed) {
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
          maximumSize: Size(width, height), 
          backgroundColor: globals.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          )
        ),
        
        onPressed: () {
          onPressed();
        },
        
        child: SizedBox(
          height: height,
          width: width,
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            
            children: [
          
              Icon(icon, size: 30,),
          
              Text(
                text,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }