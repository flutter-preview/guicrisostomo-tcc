import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/globals.dart' as globals;

class ProductsController {

  Future<List<String>> listCategories() async {
    List<String> listCategories = [];

    await connectMySQL().then((conn) async {
      var querySelect = 'SELECT DISTINCT v.category';
      querySelect += ' FROM products p';
      querySelect += ' INNER JOIN variations v ON v.id = p.id_variation';
      querySelect += ' WHERE v.business = ?';
      querySelect += ' GROUP BY v.category';
      querySelect += ' ORDER BY v.category';

      var results = await conn.query(querySelect, [globals.businessId]);
      await conn.close();
      
      if (results.isEmpty) {
        listCategories.add('Vazio');
      }
      
      for (var row in results) {
        listCategories.add(
          row[0]
        );
      }
    });

    return listCategories;
  }

  Future<List<String>> listSizes(category) async {
    List<String> listSizes = [];

    await connectMySQL().then((conn) async {
      var querySelect = 'SELECT DISTINCT v.size';
      querySelect += ' FROM products p';
      querySelect += ' INNER JOIN variations v ON v.id = p.id_variation';
      querySelect += ' WHERE v.category = ?';
      querySelect += ' ORDER BY v.size';

      var results = await conn.query(querySelect, [category]);
      await conn.close();

      print(results);

      if (results.isEmpty) {
        listSizes.add('Unico');
      }
      
      for (var row in results) {
        listSizes.add(
          row[0]
        );
      }
    });

    return listSizes;
  }

  Future<List<ProductItemList>> list(String categorySelected, String sizeSelected, String searchProduct) async {
    List<ProductItemList> list = [];
    searchProduct = '%$searchProduct%';
    
    await connectMySQL().then((conn) async {
      var querySelect = 'SELECT p.id, p.name, p.price, p.description, p.link_image, v.category, v.size';
      querySelect += ' FROM products p';
      querySelect += ' INNER JOIN variations v ON v.id = p.id_variation';
      querySelect += ' WHERE v.category = ? AND v.size = ? AND v.business = ? AND p.name LIKE ? AND p.fg_ativo = 1';
      querySelect += ' ORDER BY p.name';
      
      var results = await conn.query(querySelect, [categorySelected, sizeSelected, globals.businessId, searchProduct]);
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