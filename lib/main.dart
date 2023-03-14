import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
import 'package:tcc/view/pages/screen_notificaties.dart';
import 'package:tcc/view/pages/screen_order.dart';
import 'package:tcc/view/pages/screen_presentation.dart';
import 'package:tcc/view/pages/screen_products.dart';
import 'package:tcc/view/pages/screen_profile.dart';
import 'package:tcc/view/pages/screen_register.dart';
import 'package:tcc/view/pages/screen_verification_table.dart';

Route navigator([String? name, Object? arguments]) {
  Widget page;
  switch (name) {
    case 'presentation' :
      page = const ScreenPresentation();
      break;
    case 'login' :
      page = const ScreenLogin();
      break;
    case 'login/forget_password' :
      page = const ScreenForgetPassword();
      break;
    case 'register' :
      page = const ScreenRegister();
      break;
    case 'home' :
      page = const ScreenHome();
      break;
    case 'manager' :
      page = const ScreenManager();
      break;
    case 'manager/products' :
      page = const ScreenCreateProducts();
      break;
    case 'table' :
      page = const ScreenVerificationTable();
      break;
    case 'waiter' :
      page = const ScreenCallWaiter();
      break;
    case 'cart' :
      page = const ScreenCart();
      break;
    case 'products' :
      page = ScreenProducts(arguments: arguments);
      break;
    case 'products/info_product' :
      page = const ScreenInfoProduct();
      break;
    case 'products/add_product' :
      page = ScreenAddItem(arguments: arguments);
      break;
    case 'profile' :
      page = const ScreenProfile();
      break;
    case 'profile/edit_datas' :
      page = ScreenEditDatas(arguments: arguments);
      break;
    case 'profile/about' :
      page = const ScreenAbout();
      break;
    case 'order' : 
      page = const ScreenOrder();
     break;
    case 'order/info' :
      page = ScreenInfoOrder(arguments: arguments);
      break;
    case 'finalize_order_customer' :
      page = const ScreenFOMain();
      break;
    case 'finalize_order_customer/address' :
      page = const ScreenFOGetAddress();
      break;
    case 'finalize_order_customer/payment' : 
      page = const ScreenFOPayment();
      break;
    case 'notifications' :
      page = const ScreenNotifications();
      break;
    default:
      page = const ScreenPresentation();
    }

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(seconds: 0),
    transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child), //{
      // const begin = Offset(0.0, 1.0);
      // const end = Offset.zero;
      // final tween = Tween(begin: begin, end: end);
      // final offsetAnimation = animation.drive(tween);
      // return SlideTransition(
      //   position: offsetAnimation,
      //   child: child,
      // );
    // },
  );
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
        'presentation' :(context) => const ScreenPresentation(),
        'login' :(context) => const ScreenLogin(),
        'login/forget_password' :(context) => const ScreenForgetPassword(),
        'register' :(context) => const ScreenRegister(),
        'home' :(context) => const ScreenHome(),
        'manager' :(context) => const ScreenManager(),
        'manager/products' :(context) => const ScreenCreateProducts(),
        'table' :(context) => const ScreenVerificationTable(),
        'waiter' :(context) => const ScreenCallWaiter(),
        'cart' :(context) => const ScreenCart(),
        'products' :(context) => ScreenProducts(),
        'products/info_product' :(context) => const ScreenInfoProduct(),
        'products/add_product' :(context) => ScreenAddItem(),
        'profile' :(context) => const ScreenProfile(),
        'profile/edit_datas' :(context) => ScreenEditDatas(),
        'profile/about' :(context) => const ScreenAbout(),
        'order' :(context) => const ScreenOrder(),
        'order/info' :(context) => ScreenInfoOrder(),
        'finalize_order_customer' :(context) => const ScreenFOMain(),
        'finalize_order_customer/address' :(context) => const ScreenFOGetAddress(),
        'finalize_order_customer/payment' :(context) => const ScreenFOPayment(),
        'notifications' :(context) => const ScreenNotifications(),
      },

      // onGenerateRoute: (settings) {
      //   final arguments = settings.arguments ?? {};
      //   switch (settings.name?.replaceFirst('/', '')) {
      //     case 'presentation' : return PageRouteBuilder(
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
      //     case 'login' : return PageRouteBuilder(
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
      //     case 'login/forget_password' :return PageRouteBuilder(
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
      //     case 'register' :return PageRouteBuilder(
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
      //     case 'home' :return PageRouteBuilder(
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
      //     case 'manager' :return PageRouteBuilder(
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
      //     case 'manager/products' :return PageRouteBuilder(
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
      //     case 'table' :return PageRouteBuilder(
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
      //     case 'waiter' :return PageRouteBuilder(
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
      //     case 'cart' :return PageRouteBuilder(
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
      //     case 'products' :return PageRouteBuilder(
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
      //     case 'products/info_product' :return PageRouteBuilder(
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
      //     case 'products/add_product' :return PageRouteBuilder(
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
      //     case 'profilea' :return PageRouteBuilder(
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
      //     case 'profile/edit_datas' :return PageRouteBuilder(
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
      //     case 'profile/about' :return PageRouteBuilder(
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
      //     case 'order/info' :return PageRouteBuilder(
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
      //     case 'finalize_order_customer' :return PageRouteBuilder(
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
      //     case 'finalize_order_customer/address' :return PageRouteBuilder(
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
      //     case 'finalize_order_customer/payment' :return PageRouteBuilder(
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
    ),
  );

  FlutterNativeSplash.remove();
}