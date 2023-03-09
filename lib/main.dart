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

      routes: <String, WidgetBuilder>{
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

      onGenerateRoute: (settings) {
        final arguments = settings.arguments ?? {};
        switch (settings.name) {
          case 'presentation' :(context) => ScreenPresentation(arguments);
            break;
          case 'login' :(context) => ScreenLogin(arguments);
            break;
          case 'login/forget_password' :(context) => ScreenForgetPassword(arguments);
            break;
          case 'register' :(context) => ScreenRegister(arguments);
            break;
          case 'home' :(context) => ScreenHome(arguments);
            break;
          case 'manager' :(context) => ScreenManager(arguments);
            break;
          case 'manager/products' :(context) => ScreenCreateProducts(arguments);
            break;
          case 'table' :(context) => ScreenVerificationTable(arguments);
            break;
          case 'waiter' :(context) => ScreenCallWaiter(arguments);
            break;
          case 'cart' :(context) => ScreenCart(arguments);
            break;
          case 'products' :(context) => ScreenProducts(arguments);
            break;
          case 'products/info_product' :(context) => ScreenInfoProduct(arguments);
            break;
          case 'products/add_product' :(context) => ScreenAddItem(arguments);
            break;
          case 'profile' :(context) => ScreenProfile(arguments);
            break;
          case 'profile/edit_datas' :(context) => ScreenEditDatas(arguments);
            break;
          case 'profile/about' :(context) => ScreenAbout(arguments);
            break;
          case 'order' :(context) => ScreenOrder(arguments);
            break;
          case 'order/info' :(context) => ScreenInfoOrder(arguments);
            break;
          case 'finalize_order_customer' :(context) => ScreenFOMain(arguments);
            break;
          case 'finalize_order_customer/address' :(context) => ScreenFOGetAddress(arguments);
            break;
          case 'finalize_order_customer/payment' :(context) => ScreenFOPayment(arguments);
            break;
          default:
            return null;
        }
      },
    )
  );
}