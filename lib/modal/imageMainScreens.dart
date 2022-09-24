import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

imgCenter(image) {
  return Container(
    child: Center(
      child: Column(
        children: [
          SvgPicture.asset(
            image,
            fit: BoxFit.scaleDown,
          ),
            
        ],
      ),
    )
  );
}