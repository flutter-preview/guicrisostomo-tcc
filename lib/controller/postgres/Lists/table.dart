import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/snackBars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TablesController {
  static TablesController? _instance;
  static TablesController get instance {
    _instance ??= TablesController();
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

  Future<void> callWaiter(context, int idSale) async {
    await isTableAlreadyCallWaiter(idSale).then((value) {
      if (value) {
        error(context, 'Já existe um chamado para esta mesa!');
      }
    });
    
    await FirebaseFirestore.instance.collection('tables').add({
      'idSale': idSale,
      'table': globals.numberTable,
      'cnpj': globals.businessId,
    }).then((value) {
      success(context, 'Chamado enviado com sucesso!');
    }).catchError((e) {
      error(context, 'Erro ao enviar chamado!');
    });
  }

  Future<bool> isTableAlreadyCallWaiter(int? idSale) async {
    return await FirebaseFirestore.instance.collection('tables').where('idSale', isEqualTo: idSale).get().then((value) {
      if (value.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    });
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> getAllTablesCallWaiter() {

    return FirebaseFirestore.instance.collection('tables').snapshots().listen((event) {
      for (var element in event.docChanges) {
        if (element.type == DocumentChangeType.added) {
          FirebaseFirestore.instance.collection('tables').doc(element.doc.id).update({
            'status': 'Aguardando',
          });
        }
      }
    });
  }
}