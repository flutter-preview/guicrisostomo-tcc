import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/model/ProductItemList.dart';

class ProductsController {

  Future<List<ProductItemList>> list() async {
    List<ProductItemList> list = [];
    
    await connectMySQL().then((conn) async {
      var querySelect = 'SELECT p.id, p.name, p.price, p.description, p.link_image, v.category, v.size';
      querySelect += ' FROM products p';
      querySelect += ' INNER JOIN variations v ON v.id = p.id_variation';

      var results = await conn.query(querySelect);
      await conn.close();
      
      for (var row in results) {
        list.add(
          ProductItemList(
            id: row[0],
            name: row[1],
            price: row[2],
            description: row[3],
            link_image: row[4],
            category: row[5],
            size: row[6],
          )
        );
      }
    });

    return list;
  }
  // list() async {
  //   return await connectMySQL().then((conn) async {
  //     var results = await conn.query('SELECT * FROM products');
  //     await conn.close();
  //     return results;
  //   });
  // }

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