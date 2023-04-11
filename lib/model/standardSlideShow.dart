import 'package:flutter/material.dart';
import 'package:tcc/controller/mysql/utils.dart';

class SlideShow {
  String path;
  String title;
  Function()? onTap;

  SlideShow({
    required this.path,
    required this.title,
    this.onTap,
  });
}