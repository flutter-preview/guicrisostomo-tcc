// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/controller/postgres/Lists/businessInfo.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/Sales.dart';

class SalesController {
  Future<int> add() async {

    return await connectSupadatabase().then((conn) async {
      DateTime now = DateTime.now();
      
      await conn.query('insert into orders (status, datetime, cnpj, table_number, type) values (@status, @datetime, @cnpj, @tableNumber, @type)', substitutionValues: {
        'status': 'Aguardando usuário',
        'datetime': now,
        'cnpj': globals.businessId,
        'tableNumber': globals.numberTable,
        'type': globals.numberTable != null ? 'Mesa' : null,
      });

      return await conn.query(
        'select id from orders where datetime = @datetime and cnpj = @cnpj and status = @status and type = @type', substitutionValues: {
          'datetime': now,
          'cnpj': globals.businessId,
          'status': 'Aguardando usuário',
          'type': globals.numberTable != null ? 'Mesa' : null,
        },
      ).then((List value) {
        conn.close();
        List list = value;

        if (list.isNotEmpty) {
          return list[0][0];
        }
      }).catchError((e) {
        print(e);
      });
    });
  }

  Future<void> updateStatus(String status, int id) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('update orders set status = @status where id = @id', substitutionValues: {
        'status': status,
        'id': id,
      }).catchError((e) {
        print(e);
      });

      conn.close();
    });
  }

  Future<void> addRelationUserOrder(int idOrder) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('insert into user_order (uid, id_order) values (@id_user, @id_order)', substitutionValues: {
        'id_user': FirebaseAuth.instance.currentUser!.uid,
        'id_order': idOrder,
      }).catchError((e) {
        print(e);
      });

      conn.close();
    });
  }

  Future<void> removeRelationUserOrder(int idOrder) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('update user_order set fg_ativo = false where uid = @id_user and id_order = @id_order', substitutionValues: {
        'id_user': FirebaseAuth.instance.currentUser!.uid,
        'id_order': idOrder,
      }).catchError((e) {
        print(e);
      });

      conn.close();
    });
  }

  Future<void> activateRelationUserOrder(int idOrder) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('update user_order set fg_ativo = true where uid = @id_user and id_order = @id_order', substitutionValues: {
        'id_user': FirebaseAuth.instance.currentUser!.uid,
        'id_order': idOrder,
      }).catchError((e) {
        print(e);
      });

      conn.close();
    });
  }

  Future<void> verifyRelationUserOrder(int idOrder) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('select uid from user_order where uid = @id_user and id_order = @id_order', substitutionValues: {
        'id_user': FirebaseAuth.instance.currentUser!.uid,
        'id_order': idOrder,
      }).then((value) {
        conn.close();
        List list = value;

        if (list.isEmpty) {
          addRelationUserOrder(idOrder);
        } else {
          activateRelationUserOrder(idOrder);
        }
      }).catchError((e) {
        print(e);
      });
    });
  }

  // void update(id, status, context) {
  //   FirebaseFirestore.instance.collection('sales').doc(id).update(
  //     {
  //       'status': status,
  //       'date': DateTime.now(),
  //     },
  //   ).then((value) => {
  //     success(context, 'Pedido Finalizado com sucesso')
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
    return (globals.numberTable == null) ?
    await connectSupadatabase().then((conn) async {
      
      return await conn.query('''
        SELECT orders.id 
          FROM orders 
          INNER JOIN user_order ON user_order.id_order = orders.id
          WHERE user_order.uid = @uid and orders.status = @status and user_order.fg_ativo = true
      ''', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 'Andamento',
      }).then((List value) async {
        conn.close();
        List list = value;

        if (list.isEmpty) {
          await add().then((value) async {
            await addRelationUserOrder(value);
            await updateStatus('Andamento', value);
          });
          return await idSale();
        } else {
          return list.first[0];
        }
      }).catchError((e) {
        print(e);
      });
    })
    : await connectSupadatabase().then((conn) async {
      return await conn.query('SELECT id FROM orders WHERE table_number = @table and status = @status and cnpj = @cnpj', substitutionValues: {
        'table': globals.numberTable,
        'status': 'Andamento',
        'cnpj': globals.businessId,
      }).then((List value) async {
        conn.close();
        List list = value;

        if (list.isEmpty) {
          await add().then((value) async {
            await verifyRelationUserOrder(value);
            await updateStatus('Andamento', value);
          });
          return await idSale();
        } else {
          await verifyRelationUserOrder(list.first[0]);
          return list.first[0];
        }
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
                INNER JOIN user_order u ON u.id_order = o.id
                where u.uid = @uid and o.status = @status and i.status = 'Ativo' and o.table_number = @table and u.fg_ativo = true
                GROUP BY (i.relation_id, i.id_variation)
              ) AS max
            ''', substitutionValues: {
            'uid': FirebaseAuth.instance.currentUser!.uid,
            'status': 'Andamento',
            'table': globals.numberTable,
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
                INNER JOIN user_order u ON u.id_order = o.id
                where u.uid = @uid and o.status = @status and i.status = 'Ativo' and o.table_number = @table and u.fg_ativo = true
                GROUP BY (i.relation_id, i.id_variation)
              ) AS avg
            ''', substitutionValues: {
            'uid': FirebaseAuth.instance.currentUser!.uid,
            'status': 'Andamento',
            'table': globals.numberTable,
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

  Future<List<num>> getTotalTable() async {
    return await connectSupadatabase().then((conn) async {

      return await BusinessInformationController().getInfoCalcValue().then((value) async {
        if (value == true || value == null) {
          return await conn.query('''
            SELECT SUM(MAX.MAX), COUNT(*) FROM (
              SELECT MAX(p.price * i.qtd) from items i 
                INNER JOIN products p ON p.id = i.id_product 
                INNER JOIN orders o ON o.id = i.id_order
                where o.table_number = @table and o.status = @status and o.cnpj = @cnpj
                GROUP BY (i.relation_id, i.id_variation)
              ) AS max
            ''', substitutionValues: {
            'table': globals.numberTable,
            'status': 'Andamento',
            'cnpj': globals.businessId,
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
                where o.table_number = @table and o.status = @status and o.cnpj = @cnpj
                GROUP BY (i.relation_id, i.id_variation)
              ) AS avg
            ''', substitutionValues: {
            'table': globals.numberTable,
            'status': 'Andamento',
            'cnpj': globals.businessId,
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

  Future<Sales?> listSalesOnDemand() async {
    return await connectSupadatabase().then((conn) async {
      return (globals.totalSale == 0) ?
      await BusinessInformationController().getInfoCalcValue().then((value) async {
        if (value == true || value == null) {
          return await conn.query('''
            SELECT o.id, o.cnpj, o.datetime, uo.uid, o.table_number, o.type, (
              SELECT SUM(MAX.MAX) FROM (
                SELECT MAX(p.price * i.qtd) from items i 
                  INNER JOIN products p ON p.id = i.id_product 
                  INNER JOIN orders o ON o.id = i.id_order 
                  INNER JOIN user_order u ON u.id_order = o.id
                  where u.uid = @uid and o.status = @status and i.status = 'Ativo' and o.table_number = @table and u.fg_ativo = true
                  GROUP BY (i.relation_id, i.id_variation)
                ) AS max
            ), (
              SELECT ua.name
                FROM tb_user ua
                INNER JOIN user_order uoa ON uoa.uid = ua.uid
                WHERE uoa.id_order = o.id and uoa.fg_ativo = true
                ORDER BY uoa.id
                LIMIT 1
            )
              FROM orders o
              INNER JOIN user_order uo ON uo.id_order = o.id
              WHERE uo.uid = @uid and o.status = @status and o.table_number = @table and uo.fg_ativo = true
            ''', substitutionValues: {
            'uid': FirebaseAuth.instance.currentUser!.uid,
            'status': 'Andamento',
            'table': globals.numberTable,
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
                status: 'Andamento',
                table: value.first[4],
                type: value.first[5],
                total: value.first[6],
                nameUserCreatedSale: value.first[7],
              );
              
              return sale;
            }
          });
        } else {
          return await conn.query('''
            SELECT o.id, o.cnpj, o.datetime, uo.uid, o.table_number, o.type, (
              SELECT SUM(avg.AVG) FROM (
                SELECT AVG(p.price * i.qtd) from items i 
                  INNER JOIN products p ON p.id = i.id_product 
                  INNER JOIN orders o ON o.id = i.id_order 
                  INNER JOIN user_order u ON u.id_order = o.id
                  where u.uid = @uid and o.status = @status and i.status = 'Ativo' and o.table_number = @table and u.fg_ativo = true
                  GROUP BY (i.relation_id, i.id_variation)
                ) AS avg
            ), (
              SELECT ua.name
                FROM tb_user ua
                INNER JOIN user_order uoa ON uoa.uid = ua.uid
                WHERE uoa.id_order = o.id and uoa.fg_ativo = true
                ORDER BY uoa.id
                LIMIT 1
            )
              FROM orders o
              INNER JOIN user_order uo ON uo.id_order = o.id
              WHERE uo.uid = @uid and o.status = @status and o.table_number = @table and uo.fg_ativo = true
            ''', substitutionValues: {
            'uid': FirebaseAuth.instance.currentUser!.uid,
            'status': 'Andamento',
            'table': globals.numberTable,
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
                status: 'Andamento',
                table: value.first[4],
                type: value.first[5],
                total: value.first[6],
                nameUserCreatedSale: value.first[7],
              );

              sale.setTotal(globals.totalSale);
              
              return sale;
            }
          });
        }
      })
      : await conn.query('''
        SELECT o.id, o.cnpj, o.datetime, uo.uid, o.table_number, o.type, (
            SELECT ua.name
              FROM tb_user ua
              INNER JOIN user_order uoa ON uoa.uid = ua.uid
              WHERE uoa.id_order = o.id and uoa.fg_ativo = true
              ORDER BY uoa.id
              LIMIT 1
          )
          FROM orders o
          INNER JOIN user_order uo ON uo.id_order = o.id
          WHERE uo.uid = @uid and o.status = @status and o.table_number = @table and uo.fg_ativo = true
        ''', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 'Andamento',
        'table': globals.numberTable,
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
            status: 'Andamento',
            table: value.first[4],
            type: value.first[5],
            total: globals.totalSale,
            nameUserCreatedSale: value.first[6],
          );
          
          return sale;
        }
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
    } else if (dateStart == 'Todos') {
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
            SELECT o.id, o.cnpj, o.datetime, uo.uid, o.status, o.table_number, 
              (
                SELECT SUM(MAX.MAX) FROM (
                  SELECT MAX(pa.price * ia.qtd) from items ia 
                    INNER JOIN products pa ON pa.id = ia.id_product 
                    INNER JOIN orders oa ON oa.id = ia.id_order 
                    WHERE oa.id = o.id and ia.status <> 'Cancelado'
                    GROUP BY (ia.relation_id, ia.id_variation)
                  ) AS max
              ) AS total, 
              (
                SELECT COUNT(*) FROM (
                  SELECT MAX(pa.price * ia.qtd) from items ia 
                    INNER JOIN products pa ON pa.id = ia.id_product 
                    INNER JOIN orders oa ON oa.id = ia.id_order 
                    WHERE oa.id = o.id and ia.status <> 'Cancelado'
                    GROUP BY (ia.relation_id, ia.id_variation)
                  ) AS max
              ) AS qtd
              FROM orders o
              INNER JOIN business b ON b.cnpj = o.cnpj
              INNER JOIN user_order uo ON uo.id_order = o.id
              WHERE o.cnpj = @cnpj AND (o.status LIKE @status AND o.datetime BETWEEN @datetime and @datetime2) and uo.fg_ativo = true
            ''';
        } else {
          querySelect = '''
            SELECT o.id, o.cnpj, o.datetime, uo.uid, o.status, o.table_number, 
              (
                SELECT SUM(MAX.avg) FROM (
                  SELECT AVG(pa.price * ia.qtd) from items ia 
                    INNER JOIN products pa ON pa.id = ia.id_product 
                    INNER JOIN orders oa ON oa.id = ia.id_order 
                    WHERE oa.id = o.id and ia.status <> 'Cancelado'
                    GROUP BY (ia.relation_id, ia.id_variation)
                  ) AS max
              ) AS total, 
              (
                SELECT COUNT(*) FROM (
                  SELECT MAX(pa.price * ia.qtd) from items ia 
                    INNER JOIN products pa ON pa.id = ia.id_product 
                    INNER JOIN orders oa ON oa.id = ia.id_order 
                    WHERE oa.id = o.id and ia.status <> 'Cancelado'
                    GROUP BY (ia.relation_id, ia.id_variation)
                  ) AS max
              ) AS qtd
              FROM orders o
              INNER JOIN business b ON b.cnpj = o.cnpj
              INNER JOIN user_order uo ON uo.id_order = o.id
              WHERE o.cnpj = @cnpj and (o.status LIKE @status AND o.datetime BETWEEN @datetime and @datetime2) and uo.fg_ativo = true
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

        if (value.isEmpty) {
          return sales;
        }

        for (var element in value) {
          sales.add(
            Sales(
              id: element[0],
              cnpj: element[1],
              date: element[2],
              uid: element[3],
              status: element[4],
              table: element[5],
              total: element[6] ?? 0.0,
            ),
          );
        }

        return sales;
      }).onError((error, stackTrace) {
        conn.close();
        print(error);
        return [];
      });
    });
  }

  Future<void> finalizeSale([bool hasCloseTable = true]) async {
    await connectSupadatabase().then((conn) async {

      await conn.query('''
        UPDATE items SET status = 'Para impressão' 
          WHERE id_order = (
            SELECT o.id 
              FROM orders o
              INNER JOIN user_order uo ON uo.id_order = o.id
              WHERE o.cnpj = @cnpj AND uo.uid = @uid AND o.status = 'Andamento' AND o.table_number = @table and uo.fg_ativo = true
          ) AND status = 'Ativo'
      ''', substitutionValues: {
        'cnpj': globals.businessId,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'table': globals.numberTable,
      }).catchError((e) {
        print(e);
      });

      if (hasCloseTable) {
        await conn.query('''
          UPDATE orders SET status = 'Para impressão'
            WHERE id = (
              SELECT o.id 
                FROM orders o
                INNER JOIN user_order uo ON uo.id_order = o.id
                WHERE o.cnpj = @cnpj AND uo.uid = @uid AND o.status = 'Andamento' AND o.table_number = @table and uo.fg_ativo = true
            ) AND status = 'Andamento'
        ''', substitutionValues: {
          'cnpj': globals.businessId,
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'table': globals.numberTable,
        }).catchError((e) {
          print(e);
        });
      }

      conn.close();
    });
  }
}