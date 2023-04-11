// ignore_for_file: file_names

import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/globals.dart' as globals;

class ProductsCartController {

  List<ProductsCartList> list(int idSale) {
    List<ProductsCartList> list = [];
    num total = 0;
    
    connectSupadatabase().then((conn) async {
      // var querySelect = 'SELECT i.id, i.id_product, p.name, p.price, i.qtd, p.id_variation';
      // querySelect += ' FROM items i';
      // querySelect += ' INNER JOIN products p ON p.id = i.id_product';
      // querySelect += ' WHERE id_order = ?';
      // querySelect += ' ORDER BY p.name';
      
      var results = await conn.from('items').select('''
        i.id, 
        i.id_product, 
        i.qtd,
        products (
          p.name, 
          p.price,  
          p.id_variation
        )
      ''').eq('id_order', idSale);
      // var results = await conn.query(querySelect, [idSale]);
      // await conn.close();
      for (var row in results) {
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
    });

    return list;
  }

  Future<List<ProductsCartList>> listItemCurrent(int idSale, int idVariation) async {
    List<ProductsCartList> list = [];
    num total = 0;
    
    await connectSupadatabase().then((conn) async {
      // var querySelect = 'SELECT p.price, p.id_variation';
      // querySelect += ' FROM items i';
      // querySelect += ' INNER JOIN products p ON p.id = i.id_product';
      // querySelect += ' WHERE i.id_order = ? AND i.fg_current = ? AND p.id_variation = ?';
      // querySelect += ' ORDER BY i.id';
      
      var results = await conn.from('items').select('''
        p.price, 
        p.id_variation
      ''').eq('id_order', idSale).eq('fg_current', true).eq('id_variation', idVariation);
      // var results = await conn.query(querySelect, [idSale, true, idVariation]);
      // await conn.close();
      for (var row in results) {
        list.add(
          ProductsCartList(
            price: row[0],
            idVariation: row[1],
          )
        );
      }
    });

    return list;
  }

  Future<int?> getVariationItem(int idSale) async {
    
    return await connectSupadatabase().then((conn) async {
      // var querySelect = 'SELECT p.id_variation';
      // querySelect += ' FROM items i';
      // querySelect += ' INNER JOIN products p ON p.id = i.id_product';
      // querySelect += ' WHERE i.id_order = ? AND i.fg_current = ?';
      // querySelect += ' ORDER BY i.id';
      
      var results = await conn.from('items').select('''
        p.id_variation
      ''').eq('id_order', idSale).eq('fg_current', true);
      // var results = await conn.query(querySelect, [idSale, true]);
      // await conn.close();

      if (results.isEmpty) {
        return null;
      }

      return results.first[0];
    });


  }

  Future<int?> getIdRelation (int idOrder) async {
    return await connectSupadatabase().then((conn) async {
      return await conn.from('items').select('relation_id').eq('id_order', idOrder).eq('fg_current', true).then((results) async {
        // await conn.close();
        
        if (results.isEmpty) {
          return null;
        } else {
          if (results.first[0] == null) {
            return results.first[1];
          } else {
            return results.first[0];
          }
        }
      });
      // conn.query('SELECT relation_id, id FROM items WHERE id_order = ? AND fg_current = ? ORDER BY id', [idOrder, true]).then((results) async {
      //   await conn.close();
        
      //   if (results.isEmpty) {
      //     return null;
      //   } else {
      //     if (results.first[0] == null) {
      //       return results.first[1];
      //     } else {
      //       return results.first[0];
      //     }
      //   }
      // });
      
    });
  }

  Future<void> add(int idSale, int idItem, String name, int qtd, int idVariation, [int fgCurrent = 1]) async {
    int? idRelation = await getIdRelation(idSale);

    await connectSupadatabase().then((conn) async {
      await conn.from('items').insert({
        'id_order': idSale,
        'id_product': idItem,
        'qtd': qtd,
        'fg_current': fgCurrent,
        'relation_id': fgCurrent == 0 ? null : idRelation,
      });
      // await conn.query('insert into items (id_order, id_product, qtd, fg_current, relation_id) values (?, ?, ?, ?, ?)',
      // [idSale, idItem, qtd, fgCurrent, fgCurrent == 0 ? null : await getIdRelation(idSale)]);
      // await conn.close();
    });
  }

  void remove(String id) {
    connectSupadatabase().then((conn) async {
      await conn.from('items').delete().eq('id', id);
      // await conn.query('delete from items where id = ?', [id]);
      // await conn.close();
    });
  }

  void update(String id, int qtd) {
    connectSupadatabase().then((conn) async {
      await conn.from('items').update({'qtd': qtd}).eq('id', id);
      // await conn.query('update items set qtd = ? where id = ?',
      // [qtd, id]);
      // await conn.close();
    });
  }
}