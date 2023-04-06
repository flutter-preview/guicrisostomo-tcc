import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/controller/mysql/connect.dart';

class ProductsController {
  getIdVariation(String category, String size) async {
    return await connectMySQL().then((conn) async {
      var results = await conn.query('SELECT id FROM variations WHERE category = ? AND size = ?', [category, size]);
      await conn.close();
      return results;
    });
  }

  list() async {
    return await connectMySQL().then((conn) async {
      var results = await conn.query('SELECT * FROM products');
      await conn.close();
      return results;
    });
  }

  listSearch(String name) async {
    return await connectMySQL().then((conn) async {
      var results = await conn.query('SELECT * FROM products WHERE name LIKE ?', ['%$name%']);
      await conn.close();
      return results;
    });
  }

  Future<void> add(String name, num price, String description, String category, String size, String urlImage) async {
    getIdVariation(category, size).then((results) async {
      await connectMySQL().then((conn) async {
        await conn.query('insert into products (name, price, description, id_variation, urlImage) values (?, ?, ?, ?, ?)',
        [name.toUpperCase(), price, description, results.first[0], urlImage]);
        await conn.close();
      });
    });
  }

  Future<void> remove(String id) async {
    await connectMySQL().then((conn) async {
      await conn.query('delete from products where id = ?', [id]);
      await conn.close();
    });
  }

  void update(String id, String name, num price, String description, String category, String size, String urlImage) {
    getIdVariation(category, size).then((results) async {
      await connectMySQL().then((conn) async {
        await conn.query('update products set name = ?, price = ?, description = ?, id_variation = ?, urlImage = ? where id = ?',
        [name.toUpperCase(), price, description, results.first[0], urlImage, id]);
        await conn.close();
      });
    });
  }
}