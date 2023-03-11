import 'package:flutter/material.dart';

class SlideShow {
  String path;
  String title;
  Function()? onTap;

  SlideShow({
    required this.path,
    required this.title,
    required this.onTap,
  });
}