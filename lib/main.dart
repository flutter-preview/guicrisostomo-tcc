import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/firebase_options.dart';
import 'package:tcc/model/Address.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/model/standardSlideShow.dart';
import 'package:tcc/view/pages/customer/screen_call_waiter.dart';
import 'package:tcc/view/pages/customer/screen_create_edit_address.dart';
import 'package:tcc/view/pages/customer/screen_fo_get_adress.dart';
import 'package:tcc/view/pages/customer/screen_fo_main.dart';
import 'package:tcc/view/pages/customer/screen_fo_payment.dart';
import 'package:tcc/view/pages/customer/screen_register_business.dart';
import 'package:tcc/view/pages/customer/screen_transition_manager.dart';
import 'package:tcc/view/pages/employee/screen_home.dart';
import 'package:tcc/view/pages/manager/screen_business.dart';
import 'package:tcc/view/pages/manager/screen_create_edit_promotions.dart';
import 'package:tcc/view/pages/manager/screen_employee_time_work.dart';
import 'package:tcc/view/pages/manager/screen_employees.dart';
import 'package:tcc/view/pages/manager/screen_home.dart';
import 'package:tcc/view/pages/manager/screen_info_category.dart';
import 'package:tcc/view/pages/manager/screen_info_employee.dart';
import 'package:tcc/view/pages/manager/screen_info_promotion.dart';
import 'package:tcc/view/pages/manager/screen_info_size.dart';
import 'package:tcc/view/pages/manager/screen_list_products.dart';
import 'package:tcc/view/pages/manager/screen_list_promotions.dart';
import 'package:tcc/view/pages/manager/screen_list_size.dart';
import 'package:tcc/view/pages/manager/screen_list_smartphone_employee.dart';
import 'package:tcc/view/pages/manager/screen_more_option.dart';
import 'package:tcc/view/pages/manager/screen_permissions.dart';
import 'package:tcc/view/pages/manager/screen_register_employee.dart';
import 'package:tcc/view/pages/screen_info_item.dart';
import 'package:tcc/view/pages/screen_loading.dart';
import 'package:tcc/view/pages/screen_tables.dart';
import 'package:tcc/view/pages/manager/screen_category.dart';
import 'package:tcc/view/pages/screen_rating_employee.dart';
import 'package:tcc/view/pages/screen_create_products.dart';
import 'package:tcc/view/pages/screen_add.dart';
import 'package:tcc/view/pages/screen_cart.dart';
import 'package:tcc/view/pages/screen_edit_datas.dart';
import 'package:tcc/view/pages/screen_forget_password.dart';
import 'package:tcc/view/pages/customer/screen_home.dart';
import 'package:tcc/view/pages/screen_info_order.dart';
import 'package:tcc/view/pages/screen_info_product.dart';
import 'package:tcc/view/pages/screen_info_table.dart';
import 'package:tcc/view/pages/screen_login.dart';
import 'package:tcc/view/pages/customer/screen_manager.dart';
// import 'package:tcc/view/pages/screen_notificaties.dart';
import 'package:tcc/view/pages/screen_order.dart';
import 'package:tcc/view/pages/screen_presentation.dart';
import 'package:tcc/view/pages/screen_products.dart';
import 'package:tcc/view/pages/screen_profile.dart';
import 'package:tcc/view/pages/screen_register.dart';
import 'package:tcc/view/pages/screen_terms.dart';
import 'package:tcc/view/pages/screen_verification_table.dart';
import 'package:tcc/view/pages/screen_verify_email.dart';

Route navigator([String? name, Object? arguments]) {
  Widget page;
  switch (name) {
    case 'presentation' :
      page = const ScreenPresentation();
      break;
    case 'verify_email' :
      page = const ScreenVerifyEmail();
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
    case 'home_employee' :
      page = const ScreenHomeEmployee();
      break;
    case 'home_manager' :
      page = const ScreenHomeManager();
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
    case 'table/info' :
      page = ScreenInfoTable(arguments: arguments);
      break;
    case 'waiter' :
      page = const ScreenCallWaiter();
      break;
    case 'cart' :
      page = const ScreenCart();
      break;
    case 'cart/info_item' :
      page = ScreenInfoItem(arguments: arguments);
      break;
    case 'products' :
      page = ScreenProducts(arguments: arguments as SlideShow?);
      break;
    case 'products/info_product' :
      page = ScreenInfoProduct(arguments: arguments);
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
      page = ScreenFOGetAddress(typeSale: arguments.toString(),);
      break;
    case 'finalize_order_customer/payment' : 
      page = ScreenFOPayment(sale: arguments as Sales,);
      break;
    case 'create_edit_address' :
      page = ScreenCreateEditAddress(addressSelected: arguments as Address?);
      break;
    case 'transition_manager_user' :
      page = const ScreenTransitionManagerUser();
      break;
    case 'register_business' :
      page = const ScreenRegisterBusiness();
      break;
    // case 'notifications' :
    //   page = const ScreenNotifications();
    //   break;
    case 'terms' :
      page = const ScreenTerms();
      break;
    case 'employee/evaluation' :
      page = ScreenRatingEmployee(idEmployee: arguments.toString());
      break;
    case 'loading' :
      page = const ScreenLoading();
      break;
    /* screens for manager */
    case 'business' :
      page = const ScreenBusiness();
      break;
    case 'categories' :
      page = const ScreenCategories();
      break;
    case 'categories/category' :
      page = ScreenInfoCategory(id: arguments.toString());
      break;
    case 'employees' :
      page = const ScreenEmployees();
      break;
    case 'employee/info' :
      page = ScreenInfoEmployee(id: arguments.toString());
      break;
    case 'employee/register' :
      page = const ScreenRegisterEmployee();
      break;
    case 'employee/smartphone' :
      page = ScreenSmartphoneEmployee(id: arguments.toString());
      break;
    case 'employee/work_time' :
      page = ScreenTimeWorkEmployee(id: arguments.toString());
      break;
    case 'permissions' :
      page = ScreenPermissions(id: arguments.toString());
      break;
    case 'table_manager' :
      page = const ScreenTables();
      break;
    case 'more' :
      page = const ScreenMoreOption();
      break;
    case 'list_products' :
      page = const ScreenListProducts();
      break;
    case 'promotions' :
      page = const ScreenListPromotions();
      break;
    case 'promotion/info' :
      page = ScreenInfoPromotion(id: arguments.toString());
      break;
    case 'promotion/create' :
      page = ScreenCreateEditPromotion(id: arguments?.toString());
      break;
    case 'size' :
      page = const ScreenListSize();
      break;
    case 'size/info' :
      page = ScreenInfoSize(id: arguments.toString());
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
  String route;

  await dotenv.load(fileName: ".env");
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  print(user?.uid);
  
  if (user != null) {
    if (user.emailVerified == false) {
      route = 'verify_email';
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
        return 'presentation';
      });
    }
  } else {
    route = 'presentation';
  }
  
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
        'verify_email' :(context) => const ScreenVerifyEmail(),
        'login' :(context) => const ScreenLogin(),
        'login/forget_password' :(context) => const ScreenForgetPassword(),
        'register' :(context) => const ScreenRegister(),
        'home' :(context) => const ScreenHome(),
        'home_employee' :(context) => const ScreenHomeEmployee(),
        'home_manager' :(context) => const ScreenHomeManager(),
        'manager' :(context) => const ScreenManager(),
        'manager/products' :(context) => const ScreenCreateProducts(),
        'table' :(context) => const ScreenVerificationTable(),
        'table/info' :(context) => const ScreenInfoTable(),
        'waiter' :(context) => const ScreenCallWaiter(),
        'cart' :(context) => const ScreenCart(),
        'cart/info_item' :(context) => const ScreenInfoItem(arguments: null,),
        'products' :(context) => const ScreenProducts(),
        'products/info_product' :(context) => const ScreenInfoProduct(arguments: {},),
        'products/add_product' :(context) => const ScreenAddItem(),
        'list_products' :(context) => const ScreenListProducts(),
        'profile' :(context) => const ScreenProfile(),
        'profile/edit_datas' :(context) => ScreenEditDatas(),
        'order' :(context) => const ScreenOrder(),
        'order/info' :(context) => ScreenInfoOrder(),
        'finalize_order_customer' :(context) => const ScreenFOMain(),
        'finalize_order_customer/address' :(context) => const ScreenFOGetAddress(typeSale: '',),
        'finalize_order_customer/payment' :(context) => ScreenFOPayment(sale: Sales(id: 0, uid: '0', cnpj: '0', status: 'a', date: DateTime.now()),),
        'create_edit_address' :(context) => ScreenCreateEditAddress(),
        'transition_manager_user' :(context) => const ScreenTransitionManagerUser(),
        'register_business' :(context) => const ScreenRegisterBusiness(),
        // 'notifications' :(context) => const ScreenNotifications(),
        'terms' :(context) => const ScreenTerms(),
        'loading' :(context) => const ScreenLoading(),
        // manager routes
        'business' :(context) => const ScreenBusiness(),
        'categories' :(context) => const ScreenCategories(),
        'categories/category' :(context) => const ScreenInfoCategory(id: '1'),
        'employees' :(context) => const ScreenEmployees(),
        'employee/register' :(context) => const ScreenRegisterEmployee(),
        'employee/evaluation' :(context) => const ScreenRatingEmployee(idEmployee: null,),
        'employee/info' :(context) => const ScreenInfoEmployee(id: null,),
        'employee/smartphone' :(context) => const ScreenSmartphoneEmployee(id: null,),
        'employee/work_time' :(context) => const ScreenTimeWorkEmployee(id: null,),
        'permissions' :(context) => const ScreenPermissions(id: null),
        'table_manager' :(context) => const ScreenTables(),
        'more' :(context) => const ScreenMoreOption(),
        'promotions' :(context) => const ScreenListPromotions(),
        'promotion/info' :(context) => const ScreenInfoPromotion(id: '1'),
        'promotion/create' :(context) => const ScreenCreateEditPromotion(),
        'size' :(context) => const ScreenListSize(),
        'size/info' :(context) => const ScreenInfoSize(id: '1'),
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