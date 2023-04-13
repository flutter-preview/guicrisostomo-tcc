import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/Variation.dart';

class ProductsController {
  Future<int> getIdVariation(String category, String size) async {
    return await connectSupadatabase().then((conn) async {
      Variation results = await conn.from('variations').select('id').eq('category', category).eq('size', size).single();
      return results.id!;
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
      
// await conn.from('products').select('''
//         id, 
//         name, 
//         description, 
//         price,
//         id_variation,
//         variations!inner(category, size)
//       ''').eq('variations.business', globals.businessId).eq('fg_ativo', true).then((value) {
      return await conn.from('get_category').select('''
        category
      ''').eq('business', globals.businessId).eq('fg_ativo', true).then((value) {
        List<dynamic> item = value;
        List<Variation> results = item.map((e) => Variation.fromJson(e)).toList();

        return results.map((e) => e.category!).toList();
      });
      // if (results.isEmpty) {
      //   return [];
      // }
      
      // List<ProductItemList> list = results.map((e) => ProductItemList.fromJson(
      //   e.toJson()
      // )).toList();

      // return list.map((e) => e.category).toList();

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

      return await conn.from('get_size').select('''
        size
      ''').eq('category', category).eq('business', globals.businessId).eq('fg_ativo', true).then((value) {
        List<dynamic> item = value;
        List<Variation> results = item.map((e) => Variation.fromJson(e)).toList();

        return results.map((e) => e.size!).toList();
      });
    });
  }

  Future<List<ProductItemList>> list(String categorySelected, String sizeSelected, String searchProduct) async {
    searchProduct = '%$searchProduct%';
    
    return await connectSupadatabase().then((conn) async {
      // var querySelect = 'SELECT p.id, p.name, p.price, p.description, p.link_image, v.category, v.size, p.id_variation';
      // querySelect += ' FROM products p';
      // querySelect += ' INNER JOIN variations v ON v.id = p.id_variation';
      // querySelect += ' WHERE v.category = ? AND v.size = ? AND v.business = ? AND p.name LIKE ? AND p.fg_ativo = 1';
      // querySelect += ' ORDER BY p.name';
      
      return await conn.from('products').select('''
        id, 
        name, 
        price, 
        description, 
        link_image, 
        variations!inner(category, size),
        id_variation
      ''').eq('variations.category', categorySelected).eq('variations.size', sizeSelected).eq('variations.business', globals.businessId).like('name', searchProduct).eq('fg_ativo', 1).then((value) {
        List<dynamic> item = value;
        List<ProductItemList> results = item.map((e) => ProductItemList.fromJson(e)).toList();
        // if (item.isEmpty) {
        //   return [];
        // }

        
        results.forEach((element) async {
          element.variation ??= Variation(
            id: element.variation?.id = await getIdVariation(categorySelected, sizeSelected),
            category: categorySelected,
            size: sizeSelected
          );
        });

        return results.map((e) {
          return e;
        }).toList();
      }).catchError((e) {
        print(e);
      });
      
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