// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tcc/controller/postgres/Lists/businessInfo.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/model/Variation.dart';
import 'package:tcc/view/widget/snackBars.dart';

class ProductsCartController {

  Future<List<ProductsCartList>> list(int idSale) async {
    List<ProductsCartList> list = [];
    num total = 0;
    
    return await connectSupadatabase().then((conn) async {
      // var querySelect = 'SELECT i.id, i.id_product, p.name, p.price, i.qtd, p.id_variation';
      // querySelect += ' FROM items i';
      // querySelect += ' INNER JOIN products p ON p.id = i.id_product';
      // querySelect += ' WHERE id_order = ?';
      // querySelect += ' ORDER BY p.name';
      String querySelect = '';

      await BusinessInformationController().getInfoCalcValue().then((value) {
        value == false ?
          querySelect = '''
            SELECT i.id, i.id_product, p.name, i.qtd, p.id_variation, i.relation_id, i.text_variation, i.created_at, (
              SELECT SUM(maxa.max) FROM (
                  SELECT AVG(pa.price * ia.qtd) FROM products pa
                  INNER JOIN items ia ON ia.id_product = pa.id
                  WHERE ia.id_order = @idOrder AND ia.fg_current = false AND ia.relation_id = i.relation_id
                  GROUP BY (ia.relation_id, ia.id_variation)
                ) AS maxa
              ), (
                SELECT COUNT(*) - 1 as count FROM products pb
                  INNER JOIN items ib ON ib.id_product = pb.id
                  WHERE ib.id_order = @idOrder AND ib.fg_current = false AND ib.relation_id = i.relation_id
              )
            FROM items i
            INNER JOIN products p ON p.id = i.id_product
            WHERE i.id_order = @idOrder AND i.fg_current = false AND i.relation_id = i.id
            ORDER BY i.id DESC;
          '''
        : querySelect = '''
            SELECT i.id, i.id_product, p.name, i.qtd, i.id_variation, i.relation_id, i.text_variation, i.created_at, (
              SELECT SUM(maxa.max) FROM (
                  SELECT MAX(pa.price * ia.qtd) FROM products pa
                  INNER JOIN items ia ON ia.id_product = pa.id
                  WHERE ia.id_order = @idOrder AND ia.fg_current = false AND ia.relation_id = i.relation_id
                  GROUP BY (ia.relation_id, ia.id_variation)
                ) AS maxa
              ), (
                SELECT COUNT(*) - 1 as count FROM products pb
                  INNER JOIN items ib ON ib.id_product = pb.id
                  WHERE ib.id_order = @idOrder AND ib.fg_current = false AND ib.relation_id = i.relation_id
              )
            FROM items i
            INNER JOIN products p ON p.id = i.id_product
            WHERE i.id_order = @idOrder AND i.fg_current = false AND i.relation_id = i.id
            ORDER BY i.id DESC;
          ''';
      });

      return await conn.query(querySelect, substitutionValues: {
        'idOrder': idSale
      }).then((List value) {
        conn.close();

        if (value.isEmpty) {
          return [];
        }

        for (var row in value) {
          list.add(
            ProductsCartList(
              id: row[0],
              idProduct: row[1],
              name: row[2],
              qtd: row[3],
              variation: Variation(
                id: row[4],
              ),
              idRelative: row[5],
              textVariation: row[6],
              date: row[7],
              price: row[8],
              agregateItems: row[9],
            )
          );

          total += row[3] * row[4];
        }

        ProductsCartList().setTotal(total);
      
        return list;
      });
      // var results = await conn.from('items').select('''
      //   id, 
      //   id_product, 
      //   qtd,
      //   products!inner(name, price, id_variation)
      // ''').eq('id_order', idSale);
      // var results = await conn.query(querySelect, [idSale]);
      // await conn.close();
      // for (var row in results) {
      //   list.add(
      //     ProductsCartList(
      //       id: row[0],
      //       idProduct: row[1],
      //       name: row[2],
      //       price: row[3],
      //       qtd: row[4],
      //       idVariation: row[5],
      //     )
      //   );

      //   total += row[3] * row[4];
      // }

      // ProductsCartList().setTotal(total);
    });
  }

  Future<List<ProductsCartList>> listItemCurrent(int idSale, [int idVariation = 0]) async {
    List<ProductsCartList> list = [];
    num total = 0;
    
    return await connectSupadatabase().then((conn) async {
      // var querySelect = 'SELECT p.price, p.id_variation';
      // querySelect += ' FROM items i';
      // querySelect += ' INNER JOIN products p ON p.id = i.id_product';
      // querySelect += ' WHERE i.id_order = ? AND i.fg_current = ? AND p.id_variation = ?';
      // querySelect += ' ORDER BY i.id';
      if (idVariation == 0) {
        return await conn.query('SELECT p.price, p.id_variation, p.name, p.id, i.qtd, i.id FROM items i INNER JOIN products p ON p.id = i.id_product WHERE i.id_order = @idOrder AND i.fg_current = @fgCurrent ORDER BY i.id', substitutionValues: {
          'idOrder': idSale,
          'fgCurrent': true,
        }).then((List<List<dynamic>> value) {
          conn.close();

          for(var row in value) {
            list.add(
              ProductsCartList(
                price: row[0],
                variation: Variation(
                  id: row[1],
                ),
                name: row[2],
                idProduct: row[3],
                qtd: row[4],
                id: row[5],
              )
            );
          }

          return list;
        });
      } else {
        return await conn.query('SELECT p.price, p.id_variation, p.name, p.id, i.qtd, i.id FROM items i INNER JOIN products p ON p.id = i.id_product WHERE i.id_order = @idOrder AND i.fg_current = @fgCurrent AND p.id_variation = @idVariation ORDER BY i.id', substitutionValues: {
          'idOrder': idSale,
          'fgCurrent': true,
          'idVariation': idVariation
        }).then((List<List<dynamic>> value) {
          conn.close();

          for(var row in value) {
            list.add(
              ProductsCartList(
                price: row[0],
                variation: Variation(
                  id: row[1],
                ),
                name: row[2],
                idProduct: row[3],
                qtd: row[4],
                id: row[5],
              )
            );
          }

          return list;
        });
      }
    });

    // return list;
  }

  Future<int> getVariationItem(int idSale) async {
    
    return await connectSupadatabase().then((conn) async {
      // var querySelect = 'SELECT p.id_variation';
      // querySelect += ' FROM items i';
      // querySelect += ' INNER JOIN products p ON p.id = i.id_product';
      // querySelect += ' WHERE i.id_order = ? AND i.fg_current = ?';
      // querySelect += ' ORDER BY i.id';
      
      return await conn.query('SELECT i.id_variation FROM items i INNER JOIN products p ON p.id = i.id_product WHERE i.id_order = @idOrder AND i.fg_current = @fgCurrent ORDER BY i.id', substitutionValues: {
        'idOrder': idSale,
        'fgCurrent': true
      }).then((List value) {
        conn.close();

        if (value.isEmpty) {
          return 0;
        }

        ProductsCartList product = value.map((e) => ProductsCartList(
          variation: Variation(
            id: e[0],
          ),
        )).toList().first;

        return product.variation!.id!;
      });
      // return await conn.from('items').select('''
      //   id_variation
      // ''').eq('id_order', idSale).eq('fg_current', true).then((value) {
      //   List list = value;

      //   if (list.isEmpty) {
      //     return 0;
      //   }

      //   ProductsCartList product = list.map((e) => ProductsCartList(
      //     idVariation: e['id_variation'],
      //   )).toList().first;

      //   return product.idVariation!;
      // });
      // var results = await conn.query(querySelect, [idSale, true]);
      // await conn.close();

      // if (results.isEmpty) {
      //   return null;
      // }

      // return results.first[0];
    });


  }

  Future<int> getIdRelation (int idOrder) async {
    return await connectSupadatabase().then((conn) async {
      
      return await conn.query('SELECT relation_id, id FROM items WHERE id_order = @idOrder AND fg_current = @fgCurrent ORDER BY id', substitutionValues: {
        'idOrder': idOrder,
        'fgCurrent': true
      }).then((List results) async {
        await conn.close();
        
        if (results.isEmpty) {
          return 0;
        } else {
          List list = results;
          ProductsCartList productsCartList;
          if (list.first[0] == null) {
            productsCartList = ProductsCartList(
              idRelative: list.first[1],
            );
          } else {
            productsCartList = ProductsCartList(
              idRelative: list.first[0],
            );
          }

          return productsCartList.idRelative!;
        }
      });
    });
  }

  Future<void> add(int idSale, int idItem, String name, int qtd, int idVariation, [bool fgCurrent = true]) async {
    int idRelation = 0;
    await getIdRelation(idSale).then((value) => idRelation = value);

    await connectSupadatabase().then((conn) async {
      
      await conn.query('insert into items (id_order, id_product, qtd, fg_current, relation_id, id_variation) values (@idOrder, @idProduct, @qtd, @fgCurrent, @relationId, @idVariation)', substitutionValues: {
        'idOrder': idSale,
        'idProduct': idItem,
        'qtd': qtd,
        'fgCurrent': true,
        'relationId': idRelation == 0 ? null : idRelation,
        'idVariation': idVariation,
      }).then((List value) {
        conn.close();

        updateIdRelation(idSale);
      });
      
      // await conn.from('items').insert({
      //   'id_order': idSale,
      //   'id_product': idItem,
      //   'qtd': qtd,
      //   'fg_current': fgCurrent,
      //   'relation_id': idRelation,
      //   'id_variation': idVariation,
      // });
      // await conn.query('insert into items (id_order, id_product, qtd, fg_current, relation_id) values (?, ?, ?, ?, ?)',
      // [idSale, idItem, qtd, fgCurrent, fgCurrent == 0 ? null : await getIdRelation(idSale)]);
      // await conn.close();
    });
  }

  Future<void> updateIdRelation(int idSale) async {
    int idRelation = 0;
    await getIdRelation(idSale).then((value) => idRelation = value);

    connectSupadatabase().then((conn) async {
      await conn.query('UPDATE items SET relation_id = @id WHERE relation_id IS NULL AND id_order = @idOrder AND fg_current = @fgCurrent', substitutionValues: {
        'id': idRelation,
        'idOrder': idSale,
        'fgCurrent': true
      });
      await conn.close();
    });
  }

  Future<void> addVariation(int idSale, int idItem, int qtd, int idVariation, String textVariation, [bool fgCurrent = true]) async {
    int? idRelation;
    await getIdRelation(idSale).then((value) => idRelation = value);

    await connectSupadatabase().then((conn) async {
      
      await conn.query('insert into items (id_order, id_product, qtd, fg_current, relation_id, id_variation, text_variation) values (@idOrder, @idProduct, @qtd, @fgCurrent, @relationId, @idVariation, @textVariation)', substitutionValues: {
        'idOrder': idSale,
        'idProduct': idItem,
        'qtd': qtd,
        'fgCurrent': fgCurrent,
        'relationId': idRelation,
        'idVariation': idVariation,
        'textVariation': textVariation,
      });
      conn.close();
      // await conn.from('items').insert({
      //   'id_order': idSale,
      //   'id_product': idItem,
      //   'qtd': qtd,
      //   'fg_current': fgCurrent,
      //   'relation_id': idRelation,
      //   'id_variation': idVariation,
      // });
      // await conn.query('insert into items (id_order, id_product, qtd, fg_current, relation_id) values (?, ?, ?, ?, ?)',
      // [idSale, idItem, qtd, fgCurrent, fgCurrent == 0 ? null : await getIdRelation(idSale)]);
      // await conn.close();
    });
  }

  void update(int id, int qtd) {
    connectSupadatabase().then((conn) async {
      
      await conn.query('update items set qtd = @qtd where id = @id', substitutionValues: {
        'qtd': qtd,
        'id': id,
      });
      conn.close();
      // await conn.from('items').update({'qtd': qtd}).eq('id', id);
      // await conn.query('update items set qtd = ? where id = ?',
      // [qtd, id]);
      // await conn.close();
    });
  }

  Future<void> updateInfoSale(int idSale, String obs, int qtd) async {
    int idRelation = 0;
    await getIdRelation(idSale).then((value) => idRelation = value);

    await connectSupadatabase().then((conn) async {
      
      await conn.query('update items set fg_current = false, observation = @obs, qtd = @qtd where relation_id = @id', substitutionValues: {
        'id': idRelation,
        'obs': obs,
        'qtd': qtd,
      });
      conn.close();
    });
  }

  Future<List<Variation>> getVariationItemRelation(int id) async {
    return await connectSupadatabase().then((conn) async {
      
      return await conn.query('''
          select distinct on (v.category) v.id, v.category, v.size, v.sub_variation
            from variations v
            inner join items i on i.id_variation = v.id
            where i.relation_id = @id
        ''', substitutionValues: {
          'id': id,
        }).then((List results) async {
        await conn.close();
        
        if (results.isEmpty) {
          return [];
        } else {
          List<Variation> listVariation = [];

          for (var row in results) {
            listVariation.add(Variation(
              id: row[0],
              category: row[1],
              size: row[2],
              idSubVariation: row[3] ?? 0,
            ));
          }

          listVariation.sort((a, b) => a.idSubVariation.compareTo(b.idSubVariation));

          return listVariation;
        }
      });
    });
  }

  Future<List<ProductsCartList>> getProductsIdRelation(int id, int idVariation) async {
    return await connectSupadatabase().then((conn) async {
      
      return await conn.query('''
        SELECT i.relation_id, i.id, p.name, p.price, i.id_variation, i.text_variation, p.id
          FROM items i
          INNER JOIN products p ON p.id = i.id_product
          WHERE i.relation_id = @id AND i.id_variation = @idVariation
          ORDER BY i.id_variation ASC
      ''', substitutionValues: {
        'id': id,
        'idVariation': idVariation,
      }).then((List results) async {
        await conn.close();
        
        if (results.isEmpty) {
          return [];
        } else {
          List<ProductsCartList> listProductsCartList = [];

          for (var row in results) {
            listProductsCartList.add(ProductsCartList(
              idRelative: row[0],
              id: row[1],
              name: row[2],
              price: row[3],
              variation: Variation(
                id: row[4],
              ),
              textVariation: row[5],
              idProduct: row[6],
            ));
          }

          return listProductsCartList;
        }
      });
    });
  }

  Future<void> clearCart(int idOrder) async {
    await connectSupadatabase().then((conn) async {
      
      await conn.query('delete from items where id_order = @idOrder', substitutionValues: {
        'idOrder': idOrder,
      });
      conn.close();
      // await conn.from('items').delete().eq('id_order', idOrder);
      // await conn.query('delete from items where id_order = ?', [idOrder]);
      // await conn.close();
    });
  }

  Future<bool> isMainIdItem(int id) async {
    return await connectSupadatabase().then((conn) async {
      
      return await conn.query('select id from items where relation_id = id and id = @id', substitutionValues: {
        'id': id,
      }).then((List results) async {
        await conn.close();
        
        if (results.isEmpty) {
          return false;
        } else {
          return true;
        }
      });
    });
  }

  Future<int?> getNextIdItem(int id) async {
    return await connectSupadatabase().then((conn) async {
      
      return await conn.query('select id from items where relation_id = @id and id != @id order by id', substitutionValues: {
        'id': id,
      }).then((List results) async {
        await conn.close();
        
        if (results.isEmpty) {
          return null;
        } else {
          return results[0][0];
        }
      });
    });
  }

  Future<void> deleteItem(int id, context, [bool isDeleteRelationId = false]) async {
    await connectSupadatabase().then((conn) async {
      await isMainIdItem(id).then((value) async {
        if (value) {
          await getNextIdItem(id).then((value) async {
            if (value != null) {
              await conn.query('update items set relation_id = @id where id = @id', substitutionValues: {
                'id': value,
              });
            }
          });
        }
      });

      if (isDeleteRelationId) {
        await conn.query('delete from items where relation_id = @id OR id = @id', substitutionValues: {
          'id': id,
        });
      } else {
        await conn.query('delete from items where id = @id', substitutionValues: {
          'id': id,
        });
      }

      await conn.close();
    });
  }

  Future<bool> getVariationItemPreSelected(BuildContext context, int itemVariationSelected) async {
    await SalesController().idSale().then((idOrder) async {
      await ProductsCartController().getVariationItem(idOrder).then((value) {
        print('itemVariationSelected: $itemVariationSelected - value: $value');
        if (itemVariationSelected != value && value != 0) {
          Navigator.pop(context);
          error(context, 'Não é possível adicionar produtos de variações diferentes no mesmo item');
          return false;
        }
      });
    });

    return true;
  }

  Future<bool> verifyItemEqual(BuildContext context, ProductItemList item) async {
    await SalesController().idSale().then((idOrder) async {
      await ProductsCartController().list(idOrder).then((value) {
        if (value.isNotEmpty) {
          for (var itemCart in value) {
            if (itemCart.idProduct == item.id) {
              Navigator.pop(context);
              error(context, 'Este produto já foi adicionado');
              return false;
            }
          }
        }
      });
    });

    return true;
  }

  Future<void> verifyItemSelected(BuildContext context, ProductItemList item) async {
    int idItemVariationSelected = item.variation!.id!;
    if (await getVariationItemPreSelected(context, idItemVariationSelected) == false) {
      return;
    }

    if (await verifyItemEqual(context, item) == false) {
      return;
    }
  }
}