import 'package:flutter/material.dart';
import 'package:tcc/view/screen_about.dart';
import 'package:tcc/view/screen_add_product.dart';
import 'package:tcc/view/screen_edit_datas.dart';
import 'package:tcc/view/screen_home.dart';
import 'package:tcc/view/screen_info_order.dart';
import 'package:tcc/view/screen_info_product.dart';
import 'package:tcc/view/screen_login.dart';
import 'package:tcc/view/screen_order.dart';
import 'package:tcc/view/screen_presentation.dart';
import 'package:tcc/view/screen_products.dart';
import 'package:tcc/view/screen_profile.dart';
import 'package:tcc/view/screen_register.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App pizzaria',
      initialRoute: 'presentation',
      routes: {
        'presentation' :(context) => const ScreenPresentation(),
        'login' :(context) => const ScreenLogin(),
        'register' :(context) => const ScreenRegister(),
        'home' :(context) => const ScreenHome(),
        'products' :(context) => const ScreenProducts(),
        'products/info_product' :(context) => const ScreenInfoProduct(),
        'products/add_product' :(context) => const ScreenAddProduct(),
        'profile' :(context) => const ScreenProfile(),
        'profile/edit_datas' :(context) => const ScreenEditDatas(),
        'profile/about' :(context) => const ScreenAbout(),
        'order' :(context) => const ScreenOrder(),
        'order/info' :(context) => const ScreenInfoOrder(),
      },
    )
  );
}