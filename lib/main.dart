import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tcc/firebase_options.dart';
import 'package:tcc/view/pages/screen_about.dart';
import 'package:tcc/view/pages/screen_create_order.dart';
import 'package:tcc/view/pages/screen_create_products.dart';
import 'package:tcc/view/pages/screen_add.dart';
import 'package:tcc/view/pages/screen_cart.dart';
import 'package:tcc/view/pages/screen_edit_datas.dart';
import 'package:tcc/view/pages/screen_forget_password.dart';
import 'package:tcc/view/pages/screen_home.dart';
import 'package:tcc/view/pages/screen_info_order.dart';
import 'package:tcc/view/pages/screen_info_product.dart';
import 'package:tcc/view/pages/screen_login.dart';
import 'package:tcc/view/pages/screen_manager.dart';
import 'package:tcc/view/pages/screen_order.dart';
import 'package:tcc/view/pages/screen_presentation.dart';
import 'package:tcc/view/pages/screen_products.dart';
import 'package:tcc/view/pages/screen_profile.dart';
import 'package:tcc/view/pages/screen_register.dart';
import 'package:tcc/view/pages/screen_reset_password.dart';
import 'package:tcc/view/pages/screen_validation_email.dart';

Future<void> main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        'manager' :(context) => const ScreenManager(),
        'manager/products' :(context) => const ScreenCreateProducts(),
        'manager/order' :(context) => const ScreenCreateOrder(),
        'cart' :(context) => const ScreenCart(),
        'products' :(context) => const ScreenProducts(),
        'products/info_product' :(context) => const ScreenInfoProduct(),
        'products/add_product' :(context) => const ScreenAddItem(),
        'profile' :(context) => const ScreenProfile(),
        'profile/edit_datas' :(context) => const ScreenEditDatas(),
        'profile/about' :(context) => const ScreenAbout(),
        'order' :(context) => const ScreenOrder(),
        'order/info' :(context) => const ScreenInfoOrder(),
      },
    )
  );
}