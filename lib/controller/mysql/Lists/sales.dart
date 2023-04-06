// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mysql1/mysql1.dart';
import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/view/widget/snackBars.dart';

class SalesController {
  void add() async {
    
    await FirebaseFirestore.instance.collection('sales').add(
      {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 0,
        'date': DateTime.now(),
        'total': 0,
      },
    );

    connectMySQL().then((conn) async {
      await conn.query('insert into orders (user, status, date) values (?, ?, ?)',
      [FirebaseAuth.instance.currentUser!.uid, DateTime.now()]);
      await conn.close();
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
  //   connectMySQL().then((conn) async {
  //     await conn.query('update orders set total = ? where id = ?',
  //     [total, id]);
  //     await conn.close();
  //   });
  // }

  Future<String> idSale() async {
    String res = '';

    await connectMySQL().then((conn) async {
      var results = await conn.query('select id from orders where user = ? and status = ?',
      [FirebaseAuth.instance.currentUser!.uid, 0]);

      if (results.isNotEmpty) {
        res = results.first[0].toString();
      } else {
        add();
        idSale();
      }

      await conn.close();
    });

    return res;
  }

  Future<num> getTotal() async {
    num res = 0;
    connectMySQL().then((conn) async {
      var result = await conn.query('select price, qtd from orders where user = ? and status = ?',
      [FirebaseAuth.instance.currentUser!.uid, 'ANDAMENTO']);

      for (var i in result) {
        res += i[0] * i[1];
      }

      await conn.close();
    });
    
    return res;
  }

  listSalesFinalize() async {
    return await connectMySQL().then((conn) async {
      var results = await conn.query('select * from orders where user = ? and status = ?',
      [FirebaseAuth.instance.currentUser!.uid, 'FINALIZADO']);
      await conn.close();
      return results;
    });
  }

  Future<ProductsCartList?> listSalesOnDemand() async {
    ProductsCartList? item;
    await connectMySQL().then((conn) async {
      var results = await conn.query('select id, datetime from orders where user = ? and status = ?',
      [FirebaseAuth.instance.currentUser!.uid, 'ANDAMENTO']);
      await conn.close();
      
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