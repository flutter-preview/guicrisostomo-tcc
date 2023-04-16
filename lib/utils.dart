import 'package:flutter/material.dart';

String? validatorString(String? text) {
  if (text == null || text.isEmpty) {
    return text;
  }
  return null;
}

String? validatorNumber(String? text) {
  
  text = text!.replaceFirst(',', '.');
  if (int.tryParse(text) == null) {
    return text;
  } else {
    if (text.isEmpty) {
      return text;
    }
    return null;
  }
  
}

String? validatorEmail(String? text) {
  
  if (text == null || text.isEmpty) {
    return text;
  }

  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(text)) {
    return text;
  } else {
    return null;
  }
  
}

String? validatorPassword(String? text) {
  
  if (text == null || text.isEmpty) {
    return text;
  }
  return null;
  
}

String? validatorConfirmPassword(String? text, TextEditingController fieldPassword) {
  
  if (text == null || text.isEmpty) {
    return text;
  }

  if (text != fieldPassword.text) {
    return 'As senhas devem ser iguais';
  }
  
  return null;
  
}

String? validatorPhone(String? text) {
  
  text = text!.replaceAll(RegExp('[^0-9A-Za-z]'), '');

  if (int.tryParse(text) == null) {
    return text;
  }

  if (text.length < 14) {
    return text;
  }

  return null;
  
}