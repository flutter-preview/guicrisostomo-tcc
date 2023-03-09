import 'package:flutter/material.dart';

Function validatorString(String text) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return text;
    }
    return null;
  };
}

Function validatorNumber(String text) {
  return (String? value) {
    value = value!.replaceFirst(',', '.');
    if (int.tryParse(value) == null) {
      return text;
    } else {
      if (value.isEmpty) {
        return text;
      }
      return null;
    }
  };
}

Function validatorEmail(String text) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return text;
    }

    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return text;
    } else {
      return null;
    }
  };
}

Function validatorPassword(String text) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return text;
    }
    return null;
  };
}

Function validatorConfirmPassword(String text, TextEditingController fieldPassword) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return text;
    }

    if (value != fieldPassword.text) {
      return 'As senhas devem ser iguais';
    }
    
    return null;
  };
}

Function validatorPhone(String text) {
  return (String? value) {
    value = value!.replaceAll(RegExp('[^0-9A-Za-z]'), '');

    if (int.tryParse(value) == null) {
      return text;
    }

    if (value.length < 14) {
      return text;
    }

    return null;
  };
}

//route to effect transition screen
Route navigator(otherPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => otherPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}