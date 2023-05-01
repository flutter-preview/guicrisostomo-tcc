// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/controller/postgres/Lists/businessInfo.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/Sales.dart';

class SalesController {
  Future<void> add() async {

    await connectSupadatabase().then((conn) async {
      
      await conn.query('insert into orders (uid, status, datetime, cnpj) values (@uid, @status, @datetime, @cnpj)', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 'ANDAMENTO',
        'datetime': DateTime.now().toIso8601String(),
        'cnpj': globals.businessId,
      });
      conn.close();
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
    return await connectSupadatabase().then((conn) async {
      
      return await conn.query('SELECT id FROM orders WHERE uid = @uid and status = @status', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 'ANDAMENTO',
      }).then((List value) {
        conn.close();
        List list = value;

        if (list.isEmpty) {
          add();
        } else {
          return list.first[0];
        }

        return 0;
      });
    });
  }

  Future<List<num>> getTotal() async {
    return await connectSupadatabase().then((conn) async {

      return await BusinessInformationController().getInfoCalcValue().then((value) async {
        if (value == true || value == null) {
          return await conn.query('''
            SELECT SUM(MAX.MAX), COUNT(*) FROM (
              SELECT MAX(p.price * i.qtd) from items i 
                INNER JOIN products p ON p.id = i.id_product 
                INNER JOIN orders o ON o.id = i.id_order 
                where o.uid = @uid and o.status = @status and i.fg_current = false
                GROUP BY (i.relation_id, i.id_variation)
              ) AS max
            ''', substitutionValues: {
            'uid': FirebaseAuth.instance.currentUser!.uid,
            'status': 'ANDAMENTO',
          }).then((List value) {
            conn.close();

            if (value.isEmpty) {
              return [0, 0];
            } else {
              if (value.first[0] == null) {
                return [0, 0];
              } else {
                return [value.first[0], value.first[1]];
              }
            }
          });
        } else {
          return await conn.query('''
            SELECT SUM(avg.AVG), COUNT(*) FROM (
              SELECT AVG(p.price * i.qtd) from items i 
                INNER JOIN products p ON p.id = i.id_product 
                INNER JOIN orders o ON o.id = i.id_order 
                where o.uid = @uid and o.status = @status and i.fg_current = false
                GROUP BY (i.relation_id, i.id_variation)
              ) AS avg
            ''', substitutionValues: {
            'uid': FirebaseAuth.instance.currentUser!.uid,
            'status': 'ANDAMENTO',
          }).then((List value) {
            conn.close();

            if (value.isEmpty) {
              return [0, 0];
            } else {
              if (value.first[0] == null) {
                return [0, 0];
              } else {
                return [value.first[0], value.first[1]];
              }
            }
          });
        }
      });
    });
  }

  listSalesFinalize() async {
    return await connectSupadatabase().then((conn) async {
      
      return await conn.query('SELECT * FROM orders WHERE uid = @uid and status = @status', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 'FINALIZADO',
      }).then((List value) {
        conn.close();
        List<ProductsCartList> productsCart = [];

        for (var element in value) {
          productsCart.add(element);
        }
        return productsCart;
      });
    });
  }

  Future<Sales?> listSalesOnDemand() async {
    return await connectSupadatabase().then((conn) async {
      
      return await conn.query(
        '''
        SELECT id, cnpj, datetime, uid, table_number
          FROM orders 
          WHERE uid = @uid and status = @status
        ''', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 'ANDAMENTO',
      }).then((List value) {
        conn.close();
        
        if (value.isEmpty) {
          return null;
        } else {
          Sales sale = Sales(
            id: value.first[0],
            cnpj: value.first[1],
            date: value.first[2],
            uid: value.first[3],
            status: 'ANDAMENTO',
            table: value.first[4],
          );

          sale.setTotal(globals.totalSale);
          
          return sale;
        }
      }).catchError((e) {
        print(e);
      });
    });
  }
}