import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/controller/others/notification.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/firebase_options.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/routes.dart';

  // return PageRouteBuilder(
  //   pageBuilder: (context, animation, secondaryAnimation) => page,
  //   transitionDuration: const Duration(seconds: 0),
  //   transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child), //{
  // );

Future<bool> isDataBaseRunning() async {
  bool isRunning = false;

  await connectSupadatabase().then((value) {
    isRunning = true;
  }).catchError((onError) {
    isRunning = false;
  });

  return isRunning;
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  String route;

  await dotenv.load(fileName: ".env");
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationController.instance.init();

  // AwesomeNotifications().setListeners(
  //     onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
  //     onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
  //     onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
  //     onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
  // );
  
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  
  if (user != null) {
    if (user.emailVerified == false) {
      route = 'verify_email';
      isDataBaseRunning().then((value) {
        if (!value) {
          route = 'error';
        }
      });
    } else {
      route = await LoginController().getTypeUser().then((value) {
        if (value == 'Cliente') {
          return 'home';
        } else if (value == 'Gerente') {
          return 'home_manager';
        } else {
          return 'home_employee';
        }
      }).catchError((onError) {
        return 'error';
      });
    }
  } else {
    route = 'presentation';
    isDataBaseRunning().then((value) {
      if (!value) {
        route = 'error';
      }
    });
  }
  
  runApp(
    MaterialApp.router(
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

      theme: ThemeData(scaffoldBackgroundColor: const Color.fromRGBO(252, 252, 252, 1)),
      
      routeInformationParser: Routers.returnRouter(false).routeInformationParser,
      routerDelegate: Routers.returnRouter(false).routerDelegate,
    ),
  );

  FlutterNativeSplash.remove();
}