// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

Widget floatingButton(context) {
  print(globals.isUserTyping);
  return !globals.isUserTyping ? Padding(
    padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2000),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            globals.primary,
            globals.primary.withOpacity(0.8),
          ]
        )
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.pushNamed(context, 'finalize_order_customer');
        },
      
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    ),
  ) : const SizedBox();
}