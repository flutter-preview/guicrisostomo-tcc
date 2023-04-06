// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/controller/mysql/utils.dart';

class ProductsCartController {

  list(idSale) {
    return connectMySQL().then((conn) async {
      var results = await conn.query('SELECT * FROM items WHERE id_order = ?', [idSale]);
      await conn.close();
      return results;
    });
  }

  void add(String idSale, String idItem, String name, num price, int qtd, String category, String size) {
    getIdVariation(category, size).then((results) async {
      await connectMySQL().then((conn) async {
        await conn.query('insert into items (id_order, id_product, price, qtd, id_variation) values (?, ?, ?, ?, ?)',
        [idSale, idItem, price, qtd, results.first[0]]);
        await conn.close();
      });
    });
  }

  void remove(String id) {
    connectMySQL().then((conn) async {
      await conn.query('delete from items where id = ?', [id]);
      await conn.close();
    });
  }

  void update(String id, int qtd) {
    connectMySQL().then((conn) async {
      await conn.query('update items set qtd = ? where id = ?',
      [qtd, id]);
      await conn.close();
    });
  }
}