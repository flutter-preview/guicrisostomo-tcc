// ignore_for_file: file_names
import 'package:flutter/material.dart';

Widget listSize(nameSize, price) {
  return (
    ListView.builder(
      itemCount: 1,
      shrinkWrap:true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
      return Card(
        color: const Color.fromRGBO(50, 62, 64, 1),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          leading: const Icon(Icons.local_pizza, size: 50, color: Colors.white),
          
          title: Text(
            nameSize,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),

          trailing: SizedBox(

            child: Text(
              price,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          
        ),
      );
    })
  );
}