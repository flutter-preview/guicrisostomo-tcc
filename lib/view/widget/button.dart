import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

Widget button(
    String text,
    double width,
    double height,
    IconData? icon,
    Function() onPressed,

    [
      bool isLeftIconButon = true,
      double fontSize = 24,
      Color? color,
    ]

  ) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color ?? globals.primary,
              color == null ? globals.primary.withOpacity(0.8) : color.withOpacity(0.8),
            ]
          )
        ),
        child: ElevatedButton(
          
          style: ElevatedButton.styleFrom(
            minimumSize: Size(width, height),
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          
          onPressed: () {
            onPressed();
          },
          
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            
            children: [
      
              if (isLeftIconButon && icon != null)
                Icon(icon, size: 30,),
          
              Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
      
              if (!isLeftIconButon && icon != null)
                Icon(icon, size: 30,),
            ],
          ),
      
        ),
      );
    }