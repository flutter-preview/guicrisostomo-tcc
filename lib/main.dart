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
        'presentation' :(context) => ScreenPresentation(),
        'login' :(context) => ScreenLogin(),
        'register' :(context) => ScreenRegister(),
        'home' :(context) => ScreenHome(),
        'products' :(context) => ScreenProducts(),
        'product' :(context) => ScreenInfoProduct(),
        'add_product' :(context) => ScreenAddProduct(),
        'profile' :(context) => ScreenProfile(),
        'profile/edit_datas' :(context) => ScreenEditDatas(),
        'profile/about' :(context) => ScreenAbout(),
        'order' :(context) => ScreenOrder(),
        'order/info' :(context) => ScreenInfoOrder(),
      },
    )
  );
}