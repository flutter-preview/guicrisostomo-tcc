import 'package:flutter/material.dart';
import 'package:tcc/view/screen_about.dart';
/*
import 'package:tcc/view/screen_add_product.dart';
*/
import 'package:tcc/view/screen_edit_datas.dart';
import 'package:tcc/view/screen_forget_password.dart';
import 'package:tcc/view/screen_home.dart';
import 'package:tcc/view/screen_info_order.dart';
import 'package:tcc/view/screen_info_product.dart';
import 'package:tcc/view/screen_login.dart';
import 'package:tcc/view/screen_order.dart';
import 'package:tcc/view/screen_presentation.dart';
import 'package:tcc/view/screen_products.dart';
import 'package:tcc/view/screen_profile.dart';
import 'package:tcc/view/screen_register.dart';
import 'package:tcc/view/screen_reset_password.dart';
import 'package:tcc/view/screen_validation_email.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App pizzaria',
      initialRoute: 'presentation',
      routes: {
        'presentation' :(context) => const ScreenPresentation(),
        'login' :(context) => const ScreenLogin(),
        'login/forget_password' :(context) => const ScreenForgetPassword(),
        'login/forget_password/validation_email' :(context) => const ScreenValidationEmail(),
        'login/forget_password/reset_password' :(context) => const ScreenResetPassword(),
        'register' :(context) => const ScreenRegister(),
        'home' :(context) => const ScreenHome(),
        'products' :(context) => const ScreenProducts(),
        'products/info_product' :(context) => const ScreenInfoProduct(),
        'profile' :(context) => const ScreenProfile(),
        'profile/edit_datas' :(context) => const ScreenEditDatas(),
        'profile/about' :(context) => const ScreenAbout(),
        'order' :(context) => const ScreenOrder(),
        'order/info' :(context) => const ScreenInfoOrder(),
      },
    )
  );
}