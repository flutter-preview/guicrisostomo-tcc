// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/globals.dart' as globals;

class SalesController {
  Future<void> add() async {

    await connectSupadatabase().then((conn) async {
      await conn.from('orders').insert({
        'user': FirebaseAuth.instance.currentUser!.uid,
        'status': 'ANDAMENTO',
        'datetime': DateTime.now().toUtc(),
        'cnpj': globals.businessId,
      });
      // await conn.query('insert into orders (user, status, datetime, cnpj) values (?, ?, ?, ?)',
      // [FirebaseAuth.instance.currentUser!.uid, 'ANDAMENTO', DateTime.now().toUtc(), globals.businessId]);
      // await conn.close();
    });
  }

  // void update(id, status, context) {
  //   FirebaseFirestore.instance.collection('sales').doc(id).update(
  //     {
  //       'status': status,
  //       'date': DateTime.now(),
  //     },
  //   ).then((value) => {
  //     success(context, 'Pedido finalizado com sucesso')
  //   }).catchError((e) {
  //     error(context, 'Ocorreu um erro ao finalizar o pedido ${e.code.toString()}');
  //   });
  // }

  // void updateTotal(id, total) {
  //   connectSupadatabase().then((conn) async {
  //     await conn.query('update orders set total = ? where id = ?',
  //     [total, id]);
  //     await conn.close();
  //   });
  // }

  Future<int> idSale() async {
    int res;
    return await connectSupadatabase().then((conn) async {
      return await conn.from('orders').select('id').eq('user', FirebaseAuth.instance.currentUser!.uid).eq('status', 'ANDAMENTO').then((value) async {
        // await conn.close();

        if (value.isNotEmpty) {
          return res = value.first[0];
        } else {
          await add();
          return idSale();
        }
      });
    });
  }

  Future<num> getTotal() async {
    num res = 0;
    return await connectSupadatabase().then((conn) async {
      // String querySelect = 'SELECT p.price, i.qtd from items i';
      // querySelect += ' INNER JOIN products p ON p.id = i.id_product';
      // querySelect += ' INNER JOIN orders o ON o.id = i.id_order';
      // querySelect += ' where o.user = ? and o.status = ? and i.relation_id is null';
      var result = await conn.from('items').select('''
        products (
          price
        ),
        qtd
      ''').eq('user', FirebaseAuth.instance.currentUser!.uid).eq('status', 'ANDAMENTO').eq('relation_id', null);
      // var result = await conn.query(querySelect,
      // [FirebaseAuth.instance.currentUser!.uid, 'ANDAMENTO']);
      // print(result);
      for (var i in result) {
        res += i[0] * i[1];
      }

      // await conn.close();
      print('Total: $res');
      return res;
    });
  }

  listSalesFinalize() async {
    return await connectSupadatabase().then((conn) async {
      var results = await conn.from('orders').select('*').eq('user', FirebaseAuth.instance.currentUser!.uid).eq('status', 'FINALIZADO');
      // var results = await conn.query('select * from orders where user = ? and status = ?',
      // [FirebaseAuth.instance.currentUser!.uid, 'FINALIZADO']);
      // await conn.close();
      return results;
    });
  }

  Future<ProductsCartList?> listSalesOnDemand() async {
    ProductsCartList? item;
    await connectSupadatabase().then((conn) async {
      var results = await conn.from('orders').select('id, datetime').eq('user', FirebaseAuth.instance.currentUser!.uid).eq('status', 'ANDAMENTO');
      // var results = await conn.query('select id, datetime from orders where user = ? and status = ?',
      // [FirebaseAuth.instance.currentUser!.uid, 'ANDAMENTO']);
      // await conn.close();
      
      if (results.isNotEmpty) {
        item = ProductsCartList(
          id: results.first[0],
          date: results.first[1],
        );
      } else {
        item = null;
      }
    });

    return item;
  }
}