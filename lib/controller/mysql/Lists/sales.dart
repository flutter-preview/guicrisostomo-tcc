// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/globals.dart' as globals;

class SalesController {
  Future<void> add() async {

    await connectSupadatabase().then((conn) async {
      await conn.from('orders').insert({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 'ANDAMENTO',
        'datetime': DateTime.now().toIso8601String(),
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
      return await conn.from('orders').select('id').eq('uid', FirebaseAuth.instance.currentUser!.uid).eq('status', 'ANDAMENTO').then((value) async {
        // await conn.close();
        List list = value;
        ProductsCartList productsCartList = ProductsCartList.fromJson(list[0]);

        if (productsCartList.id == null) {
          res = 0;
        } else {
          res = productsCartList.id!;
        }

        return res;
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
      return await conn.from('items').select('''
        products!inner(price),
        orders!inner(id, uid, status),
        qtd
      ''').eq('orders.uid', FirebaseAuth.instance.currentUser!.uid)
          .eq('orders.status', 'ANDAMENTO')
          .is_('relation_id', null)
          .eq('fg_current', false)
          .then((value) {
        // await conn.close();
            List item = value;
            List<ProductsCartList> productsCart = item.map((e) => ProductsCartList(
              price: e['products']['price'],
              qtd: e['qtd'],
            )).toList();
            print(item.first['price']);
            
            if (item.isEmpty) { 
              res = 0;
            } else {
              num price = 0;
              int qtd = 0;

              res = productsCart.map((e) {
                price = e.price!;
                qtd = e.qtd!;
                return price * qtd;
              }).reduce((value, element) => value + element);
              // productsCart.map((e) => {
              //   print(e),
              //   res += 
              // }).toList();
            }

            return res;
      }).catchError((e) {
        print(e);
      });
      // var result = await conn.query(querySelect,
      // [FirebaseAuth.instance.currentUser!.uid, 'ANDAMENTO']);
      // print(result);
    });
  }

  listSalesFinalize() async {
    return await connectSupadatabase().then((conn) async {
      var results = await conn.from('orders').select().eq('uid', FirebaseAuth.instance.currentUser!.uid).eq('status', 'FINALIZADO');
      // var results = await conn.query('select * from orders where user = ? and status = ?',
      // [FirebaseAuth.instance.currentUser!.uid, 'FINALIZADO']);
      // await conn.close();
      return results;
    });
  }

  Future<ProductsCartList?> listSalesOnDemand() async {
    ProductsCartList? item;
    return await connectSupadatabase().then((conn) async {
      return await conn.from('orders').select('id, datetime').eq('uid', FirebaseAuth.instance.currentUser!.uid).eq('status', 'ANDAMENTO').then((value) async {
        // await conn.close();
        List item = value;
        List<ProductsCartList> productsCart = item.map((e) => ProductsCartList.fromJson(e)).toList();
        return productsCart.first;
      });
      // var results = await conn.query('select id, datetime from orders where user = ? and status = ?',
      // [FirebaseAuth.instance.currentUser!.uid, 'ANDAMENTO']);
      // await conn.close();
      // List item = results;
      // List<ProductsCartList> productsCart = ProductsCartList.fromJson(item).productsCart ?? [];
      // item = ProductsCartList.fromJson(results);
    });

    // return item;
  }
}