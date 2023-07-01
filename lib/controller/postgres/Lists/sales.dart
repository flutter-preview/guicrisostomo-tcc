// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:postgres/postgres.dart';
import 'package:tcc/controller/postgres/Lists/businessInfo.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/Sales.dart';

class SalesController {
  static SalesController? _instance;
  static SalesController get instance {
    _instance ??= SalesController();
    return _instance!;
  }

  static final StreamController<List<int>> _tablesActivated = StreamController<List<int>>.broadcast(
    
  );

  static PostgreSQLConnection? conn;

  static PostgreSQLConnection? get getConn => conn;
  static set setConn(PostgreSQLConnection? conn) => SalesController.conn = conn;

  static closeConn() {
    if (conn != null) {
      conn!.close();
      conn = null;
    }
  }

  Stream<List<int>> get tablesActivated => _tablesActivated.stream;
  StreamSubscription? _subscriptionTablesActivated;
  
  static Future<int> add(PostgreSQLConnection conn) async {

    DateTime now = DateTime.now();
      
    await conn.query('insert into orders (status, datetime, cnpj, table_number, type) values (@status, @datetime, @cnpj, @tableNumber, @type)', substitutionValues: {
      'status': 'Aguardando usuário',
      'datetime': now,
      'cnpj': globals.businessId,
      'tableNumber': globals.numberTable,
      'type': globals.numberTable != null ? 'Mesa' : null,
    });

    return await conn.query(
      '''
        select id from orders where datetime = @datetime and cnpj = @cnpj and status = @status and coalesce(type, 'Vazio') = @type
      ''', substitutionValues: {
        'datetime': now,
        'cnpj': globals.businessId,
        'status': 'Aguardando usuário',
        'type': globals.numberTable != null ? 'Mesa' : 'Vazio',
      },
    ).then((List value) {
      List list = value;

      if (list.isNotEmpty) {
        return list[0][0];
      }
    }).catchError((e) {
    });
  }

  Future<void> addOrderEmployee(int idOrder) async {
    await getConn!.query('insert into order_employee (uid, id_order) values (@uid, @idOrder)', substitutionValues: {
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'idOrder': idOrder,
    }).catchError((e) {
    });
  }

  Future<int?> getOrderEmployee() async {
    return await getConn!.query('''
      select oe.id_order 
        from order_employee oe
        inner join orders o on o.id = oe.id_order
        where oe.uid = @uid and o.status = @status and o.cnpj = @cnpj and coalesce(o.table_number, 0) = @table
    ''', substitutionValues: {
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'status': 'Andamento',
      'cnpj': globals.businessId,
      'table': globals.numberTable ?? 0,
    }).then((value) {
      List list = value;

      if (list.isEmpty) {
        return null;
      }

      return list.first[0];

    }).catchError((e) {
    });
  }

  Future<void> updateStatus(String status, int id) async {
    await getConn!.query('update orders set status = @status where id = @id', substitutionValues: {
      'status': status,
      'id': id,
    }).catchError((e) {
    });
  }

  Future<void> addRelationUserOrder(int idOrder) async {
    await getConn!.query('insert into user_order (uid, id_order) values (@id_user, @id_order)', substitutionValues: {
      'id_user': FirebaseAuth.instance.currentUser!.uid,
      'id_order': idOrder,
    }).catchError((e) {
    });
  }

  Future<void> removeRelationUserOrder(int idOrder) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('update user_order set fg_ativo = false where uid = @id_user and id_order = @id_order', substitutionValues: {
        'id_user': FirebaseAuth.instance.currentUser!.uid,
        'id_order': idOrder,
      }).catchError((e) {
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
      });
    });
  }

  Future<int> idSale() async {
    if (globals.idSaleSelected == null) {
      return await connectSupadatabase().then((conn) async {
        setConn = conn;
        
        return (globals.userType == 'employee' || globals.userType == 'manager') ?
          await getOrderEmployee().then((value) async {
            if (value == null) {
              return await add(getConn!).then((idSaleVar) async {
                await addOrderEmployee(idSaleVar);
                await addRelationUserOrder(idSaleVar);

                await updateStatus('Andamento', idSaleVar);

                closeConn();

                return idSaleVar;
              });
            } else {
              globals.idSaleSelected = value;

              closeConn();

              return value;
            }
          })
        : await getConn!.query('''
          SELECT orders.id 
            FROM orders 
            INNER JOIN user_order ON user_order.id_order = orders.id
            INNER JOIN order_employee ON order_employee.id_order <> orders.id
            WHERE user_order.uid = @uid and orders.status = @status and user_order.fg_ativo = true and coalesce(orders.table_number, 0) = @table
        ''', substitutionValues: {
          'uid': FirebaseAuth.instance.currentUser?.uid,
          'status': 'Andamento',
          'table': globals.numberTable ?? 0,
        }).then((List? value) async {

          List list = value ?? [];

          if (list.isEmpty) {
            return add(getConn!).then((idSale) async {
              await addRelationUserOrder(idSale);
              await updateStatus('Andamento', idSale);

              closeConn();

              return idSale;
            });
          } else {
            closeConn();
            globals.idSaleSelected = list.first[0];
            return list.first[0];
          }
        }).catchError((e) {
        });
      });
    } else {
      return globals.idSaleSelected!;
    }
  }

  Future<List<num>> getTotal() async {
    return await connectSupadatabase().then((conn) async {

      return idSale().then((idSale) async {
        return await BusinessInformationController.instance.getInfoCalcValue().then((value) async {
          if (value == true || value == null) {
            return await conn.query('''
              SELECT SUM(MAX.MAX), COUNT(*) FROM (
                SELECT MAX(p.price * i.qtd) from items i 
                  INNER JOIN products p ON p.id = i.id_product 
                  INNER JOIN orders o ON o.id = i.id_order 
                  INNER JOIN user_order u ON u.id_order = o.id
                  where u.uid = @uid and o.status = @status and i.status = 'Ativo' and o.id = @idSale and u.fg_ativo = true
                  GROUP BY (i.relation_id, i.id_variation)
                ) AS max
              ''', substitutionValues: {
              'uid': FirebaseAuth.instance.currentUser!.uid,
              'status': 'Andamento',
              'idSale': idSale,
            }).then((List value) {
              conn.close();

              if (value.isEmpty) {
                return [0, 0];
              } else {
                if (value.first[0] == null || value.first[1] == 0) {
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
                  where u.uid = @uid and o.status = @status and i.status = 'Ativo' and o.id = @idSale and u.fg_ativo = true
                  GROUP BY (i.relation_id, i.id_variation)
                ) AS avg
              ''', substitutionValues: {
              'uid': FirebaseAuth.instance.currentUser!.uid,
              'status': 'Andamento',
              'idSale': idSale,
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
    });
  }

  Future<List<num>> getTotalTable() async {
    return await connectSupadatabase().then((conn) async {

      return await BusinessInformationController.instance.getInfoCalcValue().then((value) async {
        if (value == true || value == null) {
          return await conn.query('''
            SELECT SUM(MAX.MAX), COUNT(*) FROM (
              SELECT MAX(p.price * i.qtd) from items i 
                INNER JOIN products p ON p.id = i.id_product 
                INNER JOIN orders o ON o.id = i.id_order
                where coalesce(o.table_number, 0) = @table and o.status = @status and o.cnpj = @cnpj and o.id = @idSale
                GROUP BY (i.relation_id, i.id_variation)
              ) AS max
            ''', substitutionValues: {
            'table': globals.numberTable ?? 0,
            'status': 'Andamento',
            'cnpj': globals.businessId,
            'idSale': await idSale(),
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
                where coalesce(o.table_number, 0) = @table and o.status = @status and o.cnpj = @cnpj and o.id = @idSale
                GROUP BY (i.relation_id, i.id_variation)
              ) AS avg
            ''', substitutionValues: {
            'table': globals.numberTable ?? 0,
            'status': 'Andamento',
            'cnpj': globals.businessId,
            'idSale': await idSale(),
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
      await BusinessInformationController.instance.getInfoCalcValue().then((value) async {
        if (value == true || value == null) {
          return await conn.query('''
            SELECT o.id, o.cnpj, o.datetime, uo.uid, coalesce(o.table_number, 0), o.type, (
              SELECT SUM(MAX.MAX) FROM (
                SELECT MAX(p.price * i.qtd) from items i 
                  INNER JOIN products p ON p.id = i.id_product 
                  INNER JOIN orders o ON o.id = i.id_order 
                  INNER JOIN user_order u ON u.id_order = o.id
                  where u.uid = @uid and o.status = @status and i.status = 'Ativo' and coalesce(o.table_number, 0) = @table and u.fg_ativo = true
                  GROUP BY (i.relation_id, i.id_variation)
                ) AS max
            ), (
              SELECT ua.name
                FROM tb_user ua
                INNER JOIN user_order uoa ON uoa.uid = ua.uid
                WHERE uoa.id_order = o.id and uoa.fg_ativo = true
                ORDER BY uoa.id
            )
              FROM orders o
              INNER JOIN user_order uo ON uo.id_order = o.id
              WHERE uo.uid = @uid and o.status = @status and coalesce(o.table_number, 0) = @table and uo.fg_ativo = true and o.id = @idSale
            ''', substitutionValues: {
            'uid': FirebaseAuth.instance.currentUser!.uid,
            'status': 'Andamento',
            'table': globals.numberTable ?? 0,
            'idSale': await idSale(),
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
                total: value.first[6] ?? 0,
                nameUserCreatedSale: value.first[7],
              );
              
              return sale;
            }
          }).catchError((e) {
            print(e);
            return null;
          });
        } else {
          return await conn.query('''
            SELECT o.id, o.cnpj, o.datetime, uo.uid, coalesce(o.table_number, 0), o.type, (
              SELECT SUM(avg.AVG) FROM (
                SELECT AVG(p.price * i.qtd) from items i 
                  INNER JOIN products p ON p.id = i.id_product 
                  INNER JOIN orders o ON o.id = i.id_order 
                  INNER JOIN user_order u ON u.id_order = o.id
                  where u.uid = @uid and o.status = @status and i.status = 'Ativo' and coalesce(o.table_number, 0) = @table and u.fg_ativo = true
                  GROUP BY (i.relation_id, i.id_variation)
                ) AS avg
            ), (
              SELECT ua.name
                FROM tb_user ua
                INNER JOIN user_order uoa ON uoa.uid = ua.uid
                WHERE uoa.id_order = o.id and uoa.fg_ativo = true
                ORDER BY uoa.id
            )
              FROM orders o
              INNER JOIN user_order uo ON uo.id_order = o.id
              WHERE uo.uid = @uid and o.status = @status and coalesce(o.table_number, 0) = @table and uo.fg_ativo = true and o.id = @idSale
            ''', substitutionValues: {
            'uid': FirebaseAuth.instance.currentUser!.uid,
            'status': 'Andamento',
            'table': globals.numberTable ?? 0,
            'idSale': await idSale(),
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
        SELECT o.id, o.cnpj, o.datetime, uo.uid, coalesce(o.table_number, 0), o.type, (
            SELECT ua.name
              FROM tb_user ua
              INNER JOIN user_order uoa ON uoa.uid = ua.uid
              WHERE uoa.id_order = o.id and uoa.fg_ativo = true
              ORDER BY uoa.id
          )
          FROM orders o
          INNER JOIN user_order uo ON uo.id_order = o.id
          WHERE uo.uid = @uid and o.status = @status and coalesce(o.table_number, 0) = @table and uo.fg_ativo = true
        ''', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 'Andamento',
        'table': globals.numberTable ?? 0,
        'idSale': await idSale(),
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
    bool isEmployee = globals.userType == 'employee' || globals.userType == 'manager';

    if (buttonStatusSelected == '') {
      buttonStatusSelected = '%%';
    }

    if (dateStart == 'Hoje') {
      date1 = DateTime.now().subtract(const Duration(days: 1));
    } else if (dateStart == 'Ontem') {
      date1 = DateTime.now().subtract(const Duration(days: 2));
      date2 = DateTime.now().subtract(const Duration(days: 1));
    } else if (dateStart == 'Últimos 7 dias') {
      date1 = DateTime.now().subtract(const Duration(days: 8));
    } else if (dateStart == 'Últimos 30 dias') {
      date1 = DateTime.now().subtract(const Duration(days: 31));
    } else if (dateStart == 'Últimos 90 dias') {
      date1 = DateTime.now().subtract(const Duration(days: 91));
    } else if (dateStart == 'Últimos 180 dias') {
      date1 = DateTime.now().subtract(const Duration(days: 181));
    } else if (dateStart == 'Últimos 365 dias') {
      date1 = DateTime.now().subtract(const Duration(days: 366));
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
      await BusinessInformationController.instance.getInfoCalcValue().then((value) {
        if (value == true || value == null) {
          querySelect = '''
            SELECT o.id, o.cnpj, o.datetime, uo.uid, o.status, o.payment, o.type, o.change, o.observation, coalesce(o.table_number, 0), o.address,
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
              ) AS qtd,
              (
                SELECT true
                  FROM order_employee oea
                  where oea.uid = uo.uid and oea.id_order = o.id
              ) as verify_employee
              FROM orders o
              INNER JOIN business b ON b.cnpj = o.cnpj
              INNER JOIN user_order uo ON uo.id_order = o.id
              WHERE o.cnpj = @cnpj AND (o.status LIKE @status AND o.datetime BETWEEN @datetime and @datetime2) and uo.fg_ativo = true and uo.uid = @uid
              ORDER BY o.datetime DESC
            ''';
        } else {
          querySelect = '''
            SELECT o.id, o.cnpj, o.datetime, uo.uid, o.status, o.payment, o.type, o.change, o.observation, coalesce(o.table_number, 0), o.address, 
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
              ) AS qtd,
              (
                SELECT true
                  FROM order_employee oea
                  where oea.uid = uo.uid and oea.id_order = o.id
              ) as verify_employee
              FROM orders o
              INNER JOIN business b ON b.cnpj = o.cnpj
              INNER JOIN user_order uo ON uo.id_order = o.id
              WHERE o.cnpj = @cnpj and (o.status LIKE @status AND o.datetime BETWEEN @datetime and @datetime2) and uo.fg_ativo = true and uo.uid = @uid
              ORDER BY o.datetime DESC
            ''';
        }

      });

      return await conn.query(querySelect, substitutionValues: {
        'cnpj': cnpj,
        'datetime': date1,
        'datetime2': date2,
        'status': buttonStatusSelected,
        'uid': FirebaseAuth.instance.currentUser!.uid,
      }).then((List value) {
        conn.close();
        List<Sales> sales = [];

        if (value.isEmpty) {
          return sales;
        }

        for (var element in value) {
          if (element[13] ?? false == isEmployee) {
            sales.add(
              Sales(
                id: element[0],
                cnpj: element[1],
                date: element[2],
                uid: element[3],
                status: element[4],
                payment: element[5],
                type: element[6],
                change: num.parse(element[7] ?? '0'),
                observation: element[8],
                table: element[9],
                addressId: element[10],
                total: element[11] ?? 0,
                items: element[12],
              ),
            );
          }
        }

        return sales;
      }).onError((error, stackTrace) {
        conn.close();
        print(error);
        return [];
      });
    });
  }

  Future<void> finalizeSale({
    bool hasFinishSale = true, 
    String type = '', 
    int? idAddressSelected, 
    String typePayment = '', 
    num change = 0, 
    int? idOrder,
    int? numberTable
  }) async {
    if (typePayment != 'Dinheiro') {
      change = 0;
    }

    type = globals.numberTable != null ? 'Mesa' : type;

    await connectSupadatabase().then((conn) async {

      await conn.query('''
        UPDATE items SET status = 'Para impressão' 
          WHERE id_order = @idSale AND status = 'Ativo'
      ''', substitutionValues: {
        'idSale': idOrder ?? await idSale(),
      }).catchError((e) {
      });

      if (hasFinishSale) {
        await conn.query('''
          UPDATE orders SET status = 'Ativo', type = @type, address = @address, payment = @payment, change = @change
            WHERE id = @idSale AND status = 'Andamento'
        ''', substitutionValues: {
          'cnpj': globals.businessId,
          'type': type,
          'address': idAddressSelected,
          'payment': typePayment,
          'change': change,
          'idSale': idOrder ?? await idSale(),
        }).catchError((e) {
        });

        if (globals.numberTable != null || numberTable != null) {
          await conn.query('''
          UPDATE orders SET status = 'Cancelado'
              WHERE table_number = @table AND status = 'Andamento'
          ''', substitutionValues: {
            'table': numberTable ?? globals.numberTable,
          }).catchError((e) {
          });
        }

        globals.idSaleSelected = null;
      }

      conn.close();
    });
  }

  void initSearchForTablesActivated() {

    if (_subscriptionTablesActivated != null) {
      _subscriptionTablesActivated!.pause();
    }
    
    _subscriptionTablesActivated = getListTablesOnDemand().listen((event) {
      _tablesActivated.add(event);
    });

    _subscriptionTablesActivated!.resume();
  }

  void disposeTablesActivated() {
    _subscriptionTablesActivated?.cancel();
  }

  Stream<List<int>> getListTablesOnDemand() async* {
    List<int> list = [];
    
    while (!_subscriptionTablesActivated!.isPaused || _subscriptionTablesActivated != null) {
      list = [];

      await connectSupadatabase().then((conn) async {
        await conn.query('''
          SELECT o.table_number
            FROM orders o
            INNER JOIN user_order uo ON uo.id_order = o.id
            WHERE o.cnpj = @cnpj AND (o.status = 'Andamento' OR o.status = 'Ativo') AND o.table_number IS NOT NULL
            GROUP BY o.table_number
        ''', substitutionValues: {
          'cnpj': globals.businessId,
        }).then((List value) {
          conn.close();

          for (var element in value) {
            list.add(element[0]);
          }

        }).catchError((e) async {
          conn.close();
          return;
        });
      });

      yield list;
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  Future<List<Sales>> getInfoTable(int numberTable) async {
    return connectSupadatabase().then((conn) {
      return conn.query('''
        SELECT DISTINCT ON (u.name) o.id, o.datetime, u.name, coalesce(info.price, 0),
          (
            SELECT true
              FROM order_employee oea
              where oea.uid = u.uid and oea.id_order = o.id
          ) as verify_employee,
          o.cnpj, o.status, u.uid
          FROM orders o
          INNER JOIN user_order uo ON uo.id_order = o.id
          INNER JOIN tb_user u ON u.uid = uo.uid
          INNER JOIN business b ON b.cnpj = o.cnpj
          LEFT JOIN LATERAL (
            SELECT SUM(max.priceA) as price FROM (
              SELECT CASE b.highvalue 
                WHEN true THEN MAX(pa.price * ia.qtd)
                ELSE AVG(pa.price * ia.qtd)
              END priceA from items ia 
                INNER JOIN products pa ON pa.id = ia.id_product 
                INNER JOIN orders oa ON oa.id = ia.id_order 
                WHERE coalesce(oa.table_number, 0) = @table AND (ia.status = 'Ativo' OR ia.status = 'Andamento' OR ia.status = 'Para impressão')
                GROUP BY (ia.relation_id, ia.id_variation)
            ) AS max
          ) info on true
          WHERE o.cnpj = @cnpj and (o.status = 'Ativo' OR o.status = 'Andamento') and coalesce(o.table_number, 0) = @table;
        ''', substitutionValues: {
        'cnpj': globals.businessId,
        'table': numberTable,
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
              date: element[1],
              nameUserCreatedSale: element[2],
              total: element[3] ?? 0,
              isEmployee: element[4] ?? false,
              cnpj: element[5],
              status: element[6],
              uid: element[7],
            ),
          );
        }

        sales.sort((a, b) => a.date.compareTo(b.date));

        return sales;
      }).catchError((e) {
        conn.close();
        return [];
      });
    });
  }
}