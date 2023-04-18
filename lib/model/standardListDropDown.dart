import 'package:flutter/material.dart';

class DropDownList {
  String name;
  IconData icon;
  void Function()? onSelected;

  DropDownList({
    required this.name,
    required this.icon,
    this.onSelected,
  });
}