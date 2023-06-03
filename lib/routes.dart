import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/model/Address.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/model/standardSlideShow.dart';
import 'package:tcc/utils.dart';
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
import 'package:tcc/view/pages/screen_error.dart';
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

class Routers {

  static Future<GoRouter> returnRouter() async {

    Future<bool> isDataBaseRunning() async {
      bool isRunning = false;

      await connectSupadatabase().then((value) {
        isRunning = true;
      }).catchError((onError) {
        isRunning = false;
      });

      return isRunning;
    }

    Future<List<String>> verifiyUserAuth() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      return await checkConnectionToInternet().then((value) async {
        if (!value) {
          return ['/error', 'Para utilizar o aplicativo, por favor, se conecte à internet'];
        } else {
          return await isDataBaseRunning().then((value) async {
            if (!value) {
              return ['/error', 'Estamos com problemas para conectar ao servidor :('];
            } else {
              if (user != null) {
                if (user.emailVerified == false && !user.isAnonymous) {

                  return ['/verify_email', ''];

                } else {
                  return await LoginController.instance.getTypeUser().then((value) {
                    if (value == 'Cliente') {
                      return ['/home', ''];
                    } else if (value == 'Gerente') {
                      return ['/home_manager', ''];
                    } else {
                      return ['/home_employee', ''];
                    }
                  }).catchError((onError) {
                    return ['/error', 'Estamos com problemas para conectar ao servidor :('];
                  });
                }
              } else {
                return ['/', ''];
              }
            }
          });
        }
      });
    }

    List<String> arguments = await verifiyUserAuth();
    
    final GoRouter router = GoRouter(
      initialLocation: arguments[0],
      initialExtra: arguments[1],
      routes: <RouteBase>[
        GoRoute(
          path: '/error',
          builder: (context, state) => ScreenError(msg: state.extra.toString(),),
        ),

        GoRoute(
          path: '/',
          builder: (context, state) => const ScreenPresentation(),
        ),

        GoRoute(
          path: '/verify_email',
          builder: (context, state) => const ScreenVerifyEmail(),
        ),

        GoRoute(
          path: '/login',
          builder: (context, state) => const ScreenLogin(),
        ),

        GoRoute(
          path: '/login/forget_password',
          builder: (context, state) => const ScreenForgetPassword(),
        ),

        GoRoute(
          path: '/register',
          builder: (context, state) => const ScreenRegister(),
        ),

        GoRoute(
          path: '/home',
          builder: (context, state) => const ScreenHome(),
        ),

        GoRoute(
          path: '/home_employee',
          builder: (context, state) => const ScreenHomeEmployee(),
        ),

        GoRoute(
          path: '/home_manager',
          builder: (context, state) => const ScreenHomeManager(),
        ),

        GoRoute(
          path: '/manager',
          builder: (context, state) => const ScreenManager(),
        ),

        GoRoute(
          path: '/manager/products',
          builder: (context, state) => const ScreenCreateProducts(),
        ),

        GoRoute(
          path: '/table',
          builder: (context, state) => const ScreenVerificationTable(),
        ),

        GoRoute(
          path: '/table/info',
          builder: (context, state) => ScreenInfoTable(arguments: state.extra),
        ),

        GoRoute(
          path: '/waiter',
          builder: (context, state) => const ScreenCallWaiter(),
        ),

        GoRoute(
          path: '/cart',
          builder: (context, state) => const ScreenCart(),
        ),

        GoRoute(
          path: '/cart/info_item',
          builder: (context, state) => ScreenInfoItem(arguments: state.extra),
        ),

        GoRoute(
          path: '/products',
          builder: (context, state) => ScreenProducts(arguments: state.extra as SlideShow?),
        ),

        GoRoute(
          path: '/products/info_product',
          builder: (context, state) => ScreenInfoProduct(arguments: state.extra),
        ),

        GoRoute(
          path: '/products/add_product',
          builder: (context, state) => ScreenAddItem(arguments: state.extra),
        ),

        GoRoute(
          path: '/profile',
          builder: (context, state) => const ScreenProfile(),
        ),

        GoRoute(
          path: '/profile/edit_datas',
          builder: (context, state) => ScreenEditDatas(arguments: state.extra),
        ),

        GoRoute(
          path: '/order',
          builder: (context, state) => const ScreenOrder(),
        ),

        GoRoute(
          path: '/order/info',
          builder: (context, state) => ScreenInfoOrder(arguments: state.extra),
        ),

        GoRoute(
          path: '/finalize_order_customer',
          builder: (context, state) => const ScreenFOMain(),
        ),

        GoRoute(
          path: '/finalize_order_customer/address',
          builder: (context, state) => ScreenFOGetAddress(typeSale: state.extra.toString()),
        ),

        GoRoute(
          path: '/finalize_order_customer/payment',
          builder: (context, state) => ScreenFOPayment(sale: state.extra as Sales),
        ),

        GoRoute(
          path: '/create_edit_address',
          builder: (context, state) => ScreenCreateEditAddress(addressSelected: state.extra as Address?),
        ),

        GoRoute(
          path: '/transition_manager_user',
          builder: (context, state) => const ScreenTransitionManagerUser(),
        ),

        GoRoute(
          path: '/register_business',
          builder: (context, state) => const ScreenRegisterBusiness(),
        ),

        GoRoute(
          path: '/terms',
          builder: (context, state) => const ScreenTerms(),
        ),

        GoRoute(
          path: '/employee/evaluation',
          builder: (context, state) => ScreenRatingEmployee(idEmployee: state.extra.toString()),
        ),

        GoRoute(
          path: '/loading',
          builder: (context, state) => const ScreenLoading(),
        ),

        /* screens for manager */

        GoRoute(
          path: '/business',
          builder: (context, state) => const ScreenBusiness(),
        ),

        GoRoute(
          path: '/categories',
          builder: (context, state) => const ScreenCategories(),
        ),

        GoRoute(
          path: '/categories/category',
          builder: (context, state) => ScreenInfoCategory(id: state.extra.toString()),
        ),

        GoRoute(
          path: '/employees',
          builder: (context, state) => const ScreenEmployees(),
        ),
        
        GoRoute(
          path: '/employee/info',
          builder: (context, state) => ScreenInfoEmployee(id: state.extra.toString()),
        ),

        GoRoute(
          path: '/employee/register',
          builder: (context, state) => const ScreenRegisterEmployee(),
        ),

        GoRoute(
          path: '/employee/smartphone',
          builder: (context, state) => ScreenSmartphoneEmployee(id: state.extra.toString()),
        ),

        GoRoute(
          path: '/employee/work_time',
          builder: (context, state) => ScreenTimeWorkEmployee(id: state.extra.toString()),
        ),

        GoRoute(
          path: '/permissions',
          builder: (context, state) => ScreenPermissions(id: state.extra.toString()),
        ),

        GoRoute(
          path: '/table_manager',
          builder: (context, state) => const ScreenTables(),
        ),

        GoRoute(
          path: '/more',
          builder: (context, state) => const ScreenMoreOption(),
        ),

        GoRoute(
          path: '/list_products',
          builder: (context, state) => const ScreenListProducts(),
        ),

        GoRoute(
          path: '/promotions',
          builder: (context, state) => const ScreenListPromotions(),
        ),

        GoRoute(
          path: '/promotion/info',
          builder: (context, state) => ScreenInfoPromotion(id: state.extra.toString()),
        ),

        GoRoute(
          path: '/promotion/create',
          builder: (context, state) => ScreenCreateEditPromotion(id: state.extra.toString()),
        ),

        GoRoute(
          path: '/size',
          builder: (context, state) => const ScreenListSize(),
        ),

        GoRoute(
          path: '/size/info',
          builder: (context, state) => ScreenInfoSize(id: state.extra.toString()),
        ),
      ],
    );

    return router;
  }
}