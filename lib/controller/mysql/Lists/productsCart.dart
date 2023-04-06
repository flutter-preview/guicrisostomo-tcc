// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/view/widget/listCart.dart';

class ProductsCartController {

  List<ProductsCartList> list(String? idSale) {
    List<ProductsCartList> list = [];
    num total = 0;
    
    connectMySQL().then((conn) async {
      var querySelect = 'SELECT i.id, i.id_product, p.name, i.price, i.qtd, p.id_variation';
      querySelect += ' FROM items';
      querySelect += ' WHERE id_order = ?';
      querySelect += ' INNER JOIN products p ON p.id = i.id_product';
      var results = await conn.query(querySelect, [idSale]);
      await conn.close();
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