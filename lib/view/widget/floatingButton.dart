// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

Widget floatingButton(context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        FloatingActionButton(
          backgroundColor: globals.primary,
          onPressed: () {
            Navigator.pushNamed(context, 'finalize_order_customer');
          },
        
          child: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
    
        const SizedBox(width: 10),
    
        FloatingActionButton(
          backgroundColor: globals.primary,
          onPressed: () {
            Navigator.pushNamed(context, 'cart');
          },
    
          child: const Icon(
            Icons.shopping_cart_rounded,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}