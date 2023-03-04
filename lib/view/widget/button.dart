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
      return ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height), 
          backgroundColor: color ?? globals.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10)
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

      );
    }