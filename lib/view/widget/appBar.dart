import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/main.dart';

PreferredSizeWidget appBarWidget({
  required String pageName,
  required BuildContext context,
  IconData? icon,
  String svg = '',
}) {
  return AppBar(
    leading: icon == null ? SvgPicture.asset(
      svg,
      fit: BoxFit.scaleDown,
    ) : Icon(icon, color: Colors.white, size: 30),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: const CircleBorder(),
            shadowColor: Colors.transparent,
          ),
          
          child: Row(
            children: const [
              Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),

              SizedBox(width: 10),

              Icon(
                Icons.notifications_active,
                size: 30,
              ),
            ],
          ),
          onPressed: () { 
            Navigator.push(context, navigator('cart'));
          },
        ),
      ),
    ],
    title: Text(pageName),
    
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            globals.primaryBlack,
            globals.primary.withRed(100),
          ]
        )
      ),
    ),
    backgroundColor: globals.primary,
  );
}