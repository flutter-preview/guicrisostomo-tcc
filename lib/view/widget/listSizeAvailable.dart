// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/main.dart';

Widget listSize(nameSize, price) {
  return (
    ListView.builder(
      itemCount: 1,
      shrinkWrap:true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
      return Card(
        color: Colors.white,
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          leading: Icon(Icons.local_pizza, size: 50, color: globals.primary),
          
          title: Text(
            nameSize,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),

          trailing: SizedBox(
            width: 25,
            height: 25,
            
            child: ElevatedButton(
                
              onPressed: () {
                Navigator.push(
                  context,
                  navigator('products/add_product'),
                );
              },
              
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(2),
                backgroundColor: globals.primary,
                shape: const CircleBorder(),
              ),
              child: const Icon(Icons.add, size: 15, color: Colors.white,),
            )
          )
          
        ),
      );
    })
  );
}