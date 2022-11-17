// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget imgCenter(image) {
  return Center(
    child: Column(
      children: [
        SvgPicture.asset(
          image,
          fit: BoxFit.scaleDown,
        ),
      ],
    ),
  );
}