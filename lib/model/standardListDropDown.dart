import 'package:flutter/material.dart';

class DropDownList {
  String name;
  IconData? icon;
  Widget? widget;
  void Function()? onSelected;

  DropDownList({
    required this.name,
    required this.icon,
    this.onSelected,
    this.widget,
  });
}