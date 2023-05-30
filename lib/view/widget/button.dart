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
      String? pathImage,
    ]

  ) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
          
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(10)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
            elevation: MaterialStateProperty.all(05),
            shadowColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          
          onPressed: () {
            onPressed();
          },
          
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 10,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            
            children: [
      
              if (isLeftIconButon)
                if(icon != null) 
                  Icon(icon, size: 30,),
                if(pathImage != null)
                  Image.asset(
                    pathImage,
                    height: 35.0,
                  ),
          
              Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
      
              if (!isLeftIconButon && icon != null)
                Icon(icon, size: 30,),
            ],
          ),
      
        ),
      );
    }