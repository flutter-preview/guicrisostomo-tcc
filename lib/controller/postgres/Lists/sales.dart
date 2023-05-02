// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
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

  Future<List<Sales>> getSales(String cnpj, String dateStart, String dateEnd, String buttonStatusSelected) async {
    String querySelect = '';
    DateTime date1 = DateTime.now();
    DateTime date2 = DateTime.now();

    if (buttonStatusSelected == '') {
      buttonStatusSelected = '%%';
    }

    if (dateStart == 'Hoje') {
      date1 = DateTime.now();
    } else if (dateStart == 'Ontem') {
      date1 = DateTime.now().subtract(const Duration(days: 1));
    } else if (dateStart == 'Últimos 7 dias') {
      date1 = DateTime.now().subtract(const Duration(days: 7));
    } else if (dateStart == 'Últimos 30 dias') {
      date1 = DateTime.now().subtract(const Duration(days: 30));
    } else if (dateStart == 'Últimos 90 dias') {
      date1 = DateTime.now().subtract(const Duration(days: 90));
    } else if (dateStart == 'Últimos 180 dias') {
      date1 = DateTime.now().subtract(const Duration(days: 180));
    } else if (dateStart == 'Últimos 365 dias') {
      date1 = DateTime.now().subtract(const Duration(days: 365));
    } else if (dateStart == 'Tudo') {
      date1 = DateTime.parse('2021-01-01');
    } else {
      String dateCustom = dateEnd.split(' - ').map((e) => e.split('/').reversed.join('-')).toString().replaceAll(RegExp('([()])'), '');
      List<String> listDateCustom = dateCustom.split(', ');
      
      if (listDateCustom.length == 1) {
        dateEnd = dateCustom;
        dateStart = dateCustom;
      } else {
        dateEnd = listDateCustom[1];
        dateStart = listDateCustom[0];
      }

      date1 = DateTime.parse(dateStart);

      if (dateStart == dateEnd) {
        date2 = DateTime.parse(dateEnd).add(const Duration(days: 1));
      } else {
        date2 = DateTime.parse(dateEnd);
      }
    }
    
    return await connectSupadatabase().then((conn) async {
      await BusinessInformationController().getInfoCalcValue().then((value) {
        if (value == true || value == null) {
          querySelect = '''
            SELECT o.id, o.cnpj, o.datetime, o.uid, o.status, o.table_number, 
              (
                SELECT SUM(MAX.MAX) FROM (
                  SELECT MAX(p.price * i.qtd) from items i 
                    INNER JOIN products p ON p.id = i.id_product 
                    INNER JOIN orders o ON o.id = i.id_order 
                    WHERE o.cnpj = @cnpj and (o.status LIKE @status AND o.datetime BETWEEN @datetime and @datetime2)
                    GROUP BY (i.relation_id, i.id_variation)
                  ) AS max
              ) AS total, 
              (
                SELECT COUNT(*) FROM (
                  SELECT MAX(p.price * i.qtd) from items i 
                    INNER JOIN products p ON p.id = i.id_product 
                    INNER JOIN orders o ON o.id = i.id_order 
                    WHERE o.cnpj = @cnpj and (o.status LIKE @status AND o.datetime BETWEEN @datetime and @datetime2)
                    GROUP BY (i.relation_id, i.id_variation)
                  ) AS max
              ) AS qtd
              FROM orders o
              INNER JOIN business b ON b.cnpj = o.cnpj
              WHERE o.cnpj = @cnpj AND (o.status LIKE @status AND o.datetime BETWEEN @datetime and @datetime2)
            ''';
        } else {
          querySelect = '''
            SELECT o.id, o.cnpj, o.datetime, o.uid, o.status, o.table_number, 
              (
                SELECT SUM(avg.AVG) FROM (
                  SELECT AVG(p.price * i.qtd) from items i 
                    INNER JOIN products p ON p.id = i.id_product 
                    INNER JOIN orders o ON o.id = i.id_order 
                    WHERE o.cnpj = @cnpj and (o.status LIKE @status AND o.datetime BETWEEN @datetime and @datetime2)
                    GROUP BY (i.relation_id, i.id_variation)
                  ) AS avg
              ) AS total, 
              (
                SELECT COUNT(*) FROM (
                  SELECT AVG(p.price * i.qtd) from items i 
                    INNER JOIN products p ON p.id = i.id_product 
                    INNER JOIN orders o ON o.id = i.id_order 
                    WHERE o.cnpj = @cnpj and (o.status LIKE @status AND o.datetime BETWEEN @datetime and @datetime2)
                    GROUP BY (i.relation_id, i.id_variation)
                  ) AS avg
              ) AS qtd
              FROM orders o
              INNER JOIN business b ON b.cnpj = o.cnpj
              WHERE o.cnpj = @cnpj and (o.status LIKE @status AND o.datetime BETWEEN @datetime and @datetime2)
            ''';
        }

      });

      return await conn.query(querySelect, substitutionValues: {
        'cnpj': cnpj,
        'datetime': date1,
        'datetime2': date2,
        'status': buttonStatusSelected,
      }).then((List value) {
        conn.close();
        List<Sales> sales = [];

        for (var element in value) {
          sales.add(
            Sales(
              id: element[0],
              cnpj: element[1],
              date: element[2],
              uid: element[3],
              status: element[4],
              table: element[5],
              total: element[6],
            ),
          );
        }

        return sales;
      }).catchError((e) {
        print(e);
      });
    });
  }
}