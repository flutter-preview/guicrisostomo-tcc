import 'package:flutter/material.dart';

button(text, context, screen) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(300, 50),
          primary: Color.fromRGBO(50, 62, 64, 1),
          
        ),
        
        child: Text(text,
          style: TextStyle(
          fontSize: 24,
        )
        ),

        //COMPORTAMENTO
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(
            context,
            screen,
          );
        },
      ),
    );
  }