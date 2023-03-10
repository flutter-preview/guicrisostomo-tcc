import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/firebase_options.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/pages/customer/screen_call_waiter.dart';
import 'package:tcc/view/pages/customer/screen_fo_get_adress.dart';
import 'package:tcc/view/pages/customer/screen_fo_main.dart';
import 'package:tcc/view/pages/customer/screen_fo_payment.dart';
import 'package:tcc/view/pages/screen_about.dart';
import 'package:tcc/view/pages/screen_create_products.dart';
import 'package:tcc/view/pages/screen_add.dart';
import 'package:tcc/view/pages/screen_cart.dart';
import 'package:tcc/view/pages/screen_edit_datas.dart';
import 'package:tcc/view/pages/screen_forget_password.dart';
import 'package:tcc/view/pages/customer/screen_home.dart';
import 'package:tcc/view/pages/screen_info_order.dart';
import 'package:tcc/view/pages/screen_info_product.dart';
import 'package:tcc/view/pages/screen_login.dart';
import 'package:tcc/view/pages/customer/screen_manager.dart';
import 'package:tcc/view/pages/screen_order.dart';
import 'package:tcc/view/pages/screen_presentation.dart';
import 'package:tcc/view/pages/screen_products.dart';
import 'package:tcc/view/pages/screen_profile.dart';
import 'package:tcc/view/pages/screen_register.dart';
import 'package:tcc/view/pages/screen_verification_table.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var route = 'presentation';

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await LoginController().userLogin().then((dynamic value){
    if (value == '' || value == null) {
      route = 'presentation';
    } else {
      route = 'home';
    }
  }).catchError((erro) {
    route = 'presentation';
  });
  
  runApp(
    MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      
      supportedLocales: const [
        Locale('pt', 'BR')
      ],

      debugShowCheckedModeBanner: false,
      title: 'App pizzaria',
      initialRoute: route,

      theme: ThemeData(scaffoldBackgroundColor: const Color.fromRGBO(252, 252, 252, 1)),

      routes: {
        'presentation' :(context) => const ScreenPresentation({}),
        'login' :(context) => const ScreenLogin({}),
        'login/forget_password' :(context) => const ScreenForgetPassword({}),
        'register' :(context) => const ScreenRegister({}),
        'home' :(context) => const ScreenHome({}),
        'manager' :(context) => const ScreenManager({}),
        'manager/products' :(context) => const ScreenCreateProducts({}),
        'table' :(context) => const ScreenVerificationTable({}),
        'waiter' :(context) => const ScreenCallWaiter({}),
        'cart' :(context) => const ScreenCart({}),
        'products' :(context) => const ScreenProducts({}),
        'products/info_product' :(context) => const ScreenInfoProduct({}),
        'products/add_product' :(context) => const ScreenAddItem({}),
        'profile' :(context) => const ScreenProfile({}),
        'profile/edit_datas' :(context) => const ScreenEditDatas({}),
        'profile/about' :(context) => const ScreenAbout({}),
        'order' :(context) => const ScreenOrder({}),
        'order/info' :(context) => const ScreenInfoOrder({}),
        'finalize_order_customer' :(context) => const ScreenFOMain({}),
        'finalize_order_customer/address' :(context) => const ScreenFOGetAddress({}),
        'finalize_order_customer/payment' :(context) => const ScreenFOPayment({}),
      },

      // onGenerateRoute: (settings) {
      //   final arguments = settings.arguments ?? {};
      //   switch (settings.name?.replaceFirst('/', '')) {
      //     case 'presentation' :PageRouteBuilder(
      //         pageBuilder: (context, animation, secondaryAnimation) => ScreenPresentation(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'login' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenLogin(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'login/forget_password' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenForgetPassword(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'register' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenRegister(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'home' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenHome(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'manager' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenManager(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'manager/products' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenCreateProducts(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'table' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenVerificationTable(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'waiter' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenCallWaiter(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'cart' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenCart(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'products' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenProducts(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'products/info_product' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenInfoProduct(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'products/add_product' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenAddItem(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'profile' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenProfile(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'profile/edit_datas' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenEditDatas(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'profile/about' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenAbout(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'order' : 
      //       return PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenAbout(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'order/info' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenInfoOrder(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'finalize_order_customer' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenFOMain(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'finalize_order_customer/address' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenFOGetAddress(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     case 'finalize_order_customer/payment' : PageRouteBuilder(
      //         pageBuilder:(context, animation, secondaryAnimation) => ScreenFOPayment(arguments),
      //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //           const begin = Offset(0.0, 1.0);
      //           const end = Offset.zero;
      //           final tween = Tween(begin: begin, end: end);
      //           final offsetAnimation = animation.drive(tween);
      //           return SlideTransition(
      //             position: offsetAnimation,
      //             child: child,
      //           );
      //         },
      //       );
      //       break;
      //     default:
      //       return null;
      //   }
      // },
    )
  );
}