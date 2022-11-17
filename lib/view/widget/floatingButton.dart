import 'package:flutter/material.dart';

Widget floatingButton(context) {
  return FloatingActionButton(
    backgroundColor: const Color.fromRGBO(242, 169, 34, 1),
    onPressed: () {
      
    },

    child: const Icon(
      Icons.shopping_cart_outlined,
      color: Color.fromRGBO(50, 62, 64, 1),
    ),
  );
}