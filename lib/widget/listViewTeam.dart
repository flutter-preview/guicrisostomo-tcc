// ignore_for_file: file_names
import 'package:flutter/material.dart';

Widget listViewTeam(name, func, img) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),

        leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              img,
              height: 50,
              width: 50,
            ),
        ),

        title: Text(
          name,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),

        subtitle: Text(
          func,
        ),

      ),
    );
  }