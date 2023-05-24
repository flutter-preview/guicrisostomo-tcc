import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/snackBars.dart';

class TablesController {
  static TablesController? _instance;
  static TablesController get instance {
    if (_instance == null) _instance = TablesController();
    return _instance!;
  }

  Future<int> verifyCode(String code) async {
    return await connectSupadatabase().then((value) async {
      return await value.query('''
        SELECT number FROM tables WHERE code = '$code';
      ''').then((value) {
        if (value.isNotEmpty) {
          return value[0][0];
        } else {
          return 0;
        }
      });
    });
  }

  Future<bool> isTableCreated(int number) async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query('''
        SELECT table_number FROM sales WHERE table_number = @number AND status = 'Andamento' AND uo.fg_ativo = true;
      ''').then((value) {
        if (value.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      });
    });
  }

  Future<int> userVinculatedToTable() async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query('''
        SELECT table_number 
          FROM orders o
          INNER JOIN user_order uo ON uo.id_order = o.id 
          WHERE o.status = 'Andamento' AND uo.uid = @uid AND o.type = 'Mesa' AND uo.fg_ativo = true;
      ''', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser!.uid,
      }).then((value) {
        if (value.isNotEmpty) {
          return value[0][0] ?? 0;
        } else {
          return 0;
        }
      });
    });
  }

  Future<void> callWaiter(context) async {
    await TablesController().isTableAlreadyCallWaiter(globals.numberTable).then((value) {
      if (!value) {
        connectSupadatabase().then((conn) async {
          await conn.query('''
            INSERT INTO call_waiter (table_number, business) VALUES (@tableNumber, @business);
          ''', substitutionValues: {
            'tableNumber': globals.numberTable,
            'business': globals.businessId,
          });
        }).then((value) {
          success(context, 'Garçom chamado com sucesso');
        });
      } else {
        error(context, 'Já foi chamado o garçom');
      }
    });
  }

  Future<bool> isTableAlreadyCallWaiter(int? tableNumber) async {
    if (tableNumber == null) return false;

    return await connectSupadatabase().then((conn) async {
      return await conn.query('''
        SELECT table_number FROM call_waiter WHERE table_number = @tableNumber AND business = @business;
      ''', substitutionValues: {
        'tableNumber': tableNumber,
        'business': globals.businessId,
      }).then((value) {
        if (value.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      });
    });
  }

  Future<List<int>> getAllTablesCallWaiter() async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query('''
        SELECT table_number FROM call_waiter WHERE business = @business ORDER BY id DESC;
      ''', substitutionValues: {
        'business': globals.businessId,
      }).then((value) {
        if (value.isNotEmpty) {
          List<int> list = [];

          for (var item in value) {
            list.add(item[0]);
          }

          return list;
        } else {
          return [];
        }
      });
    });
  }
}