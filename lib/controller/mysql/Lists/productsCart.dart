// ignore_for_file: file_names

import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/model/ProductsCart.dart';
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
      return await conn.query('''
        SELECT i.id, i.id_product, p.name, p.price, i.qtd, p.id_variation 
          FROM items i 
          INNER JOIN products p ON p.id = i.id_product 
          WHERE id_order = @idOrder AND i.fg_current = false AND i.relation_id = i.id
          ORDER BY p.name
      ''', substitutionValues: {
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
              price: row[3],
              qtd: row[4],
              idVariation: row[5],
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
                idVariation: row[1],
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
                idVariation: row[1],
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
      
      return await conn.query('SELECT p.id_variation FROM items i INNER JOIN products p ON p.id = i.id_product WHERE i.id_order = @idOrder AND i.fg_current = @fgCurrent ORDER BY i.id', substitutionValues: {
        'idOrder': idSale,
        'fgCurrent': true
      }).then((List value) {
        conn.close();

        if (value.isEmpty) {
          return 0;
        }

        ProductsCartList product = value.map((e) => ProductsCartList(
          idVariation: e[0],
        )).toList().first;

        return product.idVariation!;
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

  Future<void> remove(int id, context) async {
    await connectSupadatabase().then((conn) async {
      
      await conn.query('delete from items where id = @id', substitutionValues: {
        'id': id,
      }).then((value) {
        success(context, 'Item removido com sucesso!');
      }).catchError((e) {
        error(context, 'Erro ao remover item!');
      });
      conn.close();
      // await conn.from('items').delete().eq('id', id);
      // await conn.query('delete from items where id = ?', [id]);
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
}