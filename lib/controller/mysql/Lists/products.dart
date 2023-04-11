import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/globals.dart' as globals;

class ProductsController {
  Future<int> getIdVariation(String category, String size) async {
    return await connectSupadatabase().then((conn) async {
      ProductItemList results = await conn.from('variations').select('id').eq('category', category).eq('size', size).single();
      return results.id_variation;
    });
  }

  Future<List<String>> listCategories() async {
    List<String> listCategories = [];

    return await connectSupadatabase().then((conn) async {
      // var querySelect = '''

      // ''';
      // var querySelect = 'SELECT DISTINCT v.category';
      // querySelect += ' FROM products p';
      // querySelect += ' INNER JOIN variations v ON v.id = p.id_variation';
      // querySelect += ' WHERE v.business = ?';
      // querySelect += ' GROUP BY v.category';
      // querySelect += ' ORDER BY v.category';

      List<ProductItemList> results = await conn.from('variations').select('category').eq('business', globals.businessId).eq('fg_ativo', 1);
      
      if (results.isEmpty) {
        return [];
      }
      
      var list = results.map((e) => ProductItemList.fromJson(
        e.toJson()
      )).toList();

      return list.map((e) => e.category).toList();

    });
  }

  Future<List<String>> listSizes(category) async {
    List<String> listSizes = [];

    return await connectSupadatabase().then((conn) async {
      // var querySelect = 'SELECT DISTINCT v.size';
      // querySelect += ' FROM products p';
      // querySelect += ' INNER JOIN variations v ON v.id = p.id_variation';
      // querySelect += ' WHERE v.category = ?';
      // querySelect += ' ORDER BY v.size';

      List<ProductItemList> results = await conn.from('variations').select('size').eq('category', category).eq('business', globals.businessId).eq('fg_ativo', 1);

      if (results.isEmpty) {
        return ['Único'];
      }
      
      var list = results.map((e) => ProductItemList.fromJson(
        e.toJson()
      )).toList();

      return list.map((e) => e.size).toList();
    });
  }

  Future<List<ProductItemList>> list(String categorySelected, String sizeSelected, String searchProduct) async {
    List<ProductItemList> list = [];
    searchProduct = '%$searchProduct%';
    
    return await connectSupadatabase().then((conn) async {
      var querySelect = 'SELECT p.id, p.name, p.price, p.description, p.link_image, v.category, v.size, p.id_variation';
      querySelect += ' FROM products p';
      querySelect += ' INNER JOIN variations v ON v.id = p.id_variation';
      querySelect += ' WHERE v.category = ? AND v.size = ? AND v.business = ? AND p.name LIKE ? AND p.fg_ativo = 1';
      querySelect += ' ORDER BY p.name';
      
      List<ProductItemList> results = await conn.from('products').select('''
        id, 
        name, 
        price, 
        description, 
        link_image, 
        variations (
          category, 
          size
        ),
        id_variation
      ''').eq('category', categorySelected).eq('size', sizeSelected).eq('business', globals.businessId).like('name', searchProduct).eq('fg_ativo', 1);
      
      if (results.isEmpty) {
        return [];
      }

      return results.map((e) => ProductItemList.fromJson(
        e.toJson()
      )).toList();
      
    });
  }
  // list() async {
  //   return await connectSupadatabase().then((conn) async {
  //     var results = await conn.query('SELECT * FROM products');
  //     await conn.close();
  //     return results;
  //   });
  // }

  Future<void> add(String name, num price, String description, String category, String size, String urlImage) async {
    getIdVariation(category, size).then((results) async {
      await connectSupadatabase().then((conn) async {
        await conn.from('products').insert({
          'name': name.toUpperCase(),
          'price': price,
          'description': description,
          'id_variation': results,
          'urlImage': urlImage
        });
        // await conn.query('insert into products (name, price, description, id_variation, urlImage) values (?, ?, ?, ?, ?)',
        // [name.toUpperCase(), price, description, results.first[0], urlImage]);
        // await conn.close();
      });
    });
  }

  Future<void> remove(String id) async {
    await connectSupadatabase().then((conn) async {
      await conn.from('products').delete().eq('id', id);
      // await conn.query('delete from products where id = ?', [id]);
      // await conn.close();
    });
  }

  void update(String id, String name, num price, String description, String category, String size, String urlImage) {
    getIdVariation(category, size).then((results) async {
      await connectSupadatabase().then((conn) async {
        await conn.from('products').update({
          'name': name.toUpperCase(),
          'price': price,
          'description': description,
          'id_variation': results,
          'urlImage': urlImage
        }).eq('id', id);
        // await conn.query('update products set name = ?, price = ?, description = ?, id_variation = ?, urlImage = ? where id = ?',
        // [name.toUpperCase(), price, description, results.first[0], urlImage, id]);
        // await conn.close();
      });
    });
  }
}