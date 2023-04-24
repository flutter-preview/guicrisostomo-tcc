import 'package:flutter/material.dart';

class RadioButtonList {
  String name;
  String? value;
  String? description;
  IconData icon;
  static String group = '';
  void Function(String)? callback;

  static void setGroup(String value) {
    group = value;
  }

  static String getGroup() {
    return group;
  }

  RadioButtonList({
    required this.name,
    required this.icon,
    this.value,
    this.description,
    this.callback,
  });
}