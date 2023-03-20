// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/main.dart';

Widget cartInfo(context) {
  return !globals.isUserTyping && globals.isUserTyping != 'admin' ? Container(
    margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, navigator('cart'));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  globals.primaryBlack,
                  globals.primary.withOpacity(0.9),
                ]
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 20,
                    ),
        
                    SizedBox(width: 5),
        
                    Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
    
                const SizedBox(width: 5),
        
                const Text(
                  'Item(s)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
    
                const SizedBox(width: 5),
        
                Row(
                  children: const [
                    Text(
                      'R\$ 10,00',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
        
                    SizedBox(width: 5),
        
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, navigator('finalize_order_customer'));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  globals.primaryBlack,
                  globals.primary.withOpacity(0.9),
                ]
              ),
            ),
        
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20
                ),
    
                SizedBox(width: 5),
          
                Text(
                  'Finalizar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
    
                SizedBox(width: 5),
          
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 15
                ),
              ],
            ),
          ),
        )
      ],
    ),
  ) : const SizedBox();
}