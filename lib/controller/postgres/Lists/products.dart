import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/model/Comments.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/model/Variation.dart';

class ProductsController {
  Future<int> getIdVariation(String category, String size) async {
    return await connectSupadatabase().then((conn) async {
      
      return await conn.query('SELECT id FROM variations WHERE category = @category AND size = @size AND business = @business AND fg_ativo = true', substitutionValues: {
        'category': category,
        'size': size,
        'business': globals.businessId
      }).then((List value) {
        conn.close();
        return value[0]['id'];
      });
      // Variation results = await conn.from('variations').select('id').eq('category', category).eq('size', size).single();
      // return results.id!;
    });
  }

  Future<List<Variation>> listVariations(int idVariation) async {
    // Variation().clearValues();

    return await connectSupadatabase().then((conn) async {
      // var querySelect = '''
      return await conn.query('''
        SELECT DISTINCT ON (category) category, size, is_drop_down, limit_items, price_per_item, id FROM variations 
        WHERE business = @business AND fg_ativo = true AND is_show_home = false AND sub_variation = @subvariation 
        ''', 
        substitutionValues: {
        'business': globals.businessId,
        'subvariation': idVariation
      }).then((List value) {
        conn.close();
        List<Variation> list = [];

        if (value.isEmpty) {
          return list;
        }

        for (final row in value) {
          list.add(
            Variation(
              category: row[0],
              size: row[1],
              isDropDown: row[2],
              limitItems: row[3],
              pricePerItem: row[4],
              id: row[5]
            )
          );
        }
        return list;
      });
    });
  }

  Future<List<ProductItemList>> getAllProductsVariations(String product, String category) async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query(
        '''
        SELECT p.id, p.name, p.price, p.description, p.link_image, v.category, v.size, p.id_variation, COALESCE(
          (SELECT f.id
            FROM favorites f 
            WHERE f.id_product = p.id AND f.uid = @uid
          ), 0)
          FROM products p
          INNER JOIN variations v ON v.id = p.id_variation
          WHERE v.business = @business AND p.fg_ativo = true AND v.category = @category AND p.name = @product
          ORDER BY p.name
        ''', 
        substitutionValues: {
          'business': globals.businessId,
          'product': product,
          'category': category,
          'uid': FirebaseAuth.instance.currentUser!.uid
        }
      ).then((List value) {
        conn.close();
        List<ProductItemList> list = [];

        if (value.isEmpty) {
          return list;
        }

        for(final row in value) {
          list.add(ProductItemList(
            id: row[0],
            name: row[1],
            price: row[2],
            description: row[3],
            link_image: row[4],
            variation: Variation(
              category: row[5],
              size: row[6],
              id: row[7]
            ),
            isFavorite: row[8] != 0
          ));
        }

        return list;
      });
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
      // return await conn.from('get_category').select('''
      //   category
      // ''').eq('business', globals.businessId).eq('fg_ativo', true).then((value) {
      //   List<dynamic> item = value;
      //   List<Variation> results = item.map((e) => Variation.fromJson(e)).toList();

      //   return results.map((e) => e.category!).toList();
      // });
      return await conn.query('''
        SELECT DISTINCT v.category
        FROM products p
        INNER JOIN variations v ON v.id = p.id_variation
        WHERE v.business = @business AND p.fg_ativo = true AND v.fg_ativo = true AND v.is_show_home = true
        GROUP BY v.category
        ORDER BY v.category
      ''', substitutionValues: {
        'business': globals.businessId
      }).then((List value) {
        conn.close();
        for (var row in value) {
          listCategories.add(row[0]);
        }

        return listCategories;
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

      // return await conn.from('products').select('''
      //   variations!inner(size)
      // ''').eq('variations.category', category).eq('variations.business', globals.businessId).eq('fg_ativo', true).then((value) {
      //   List<dynamic> item = value;
      //   List<Variation> results = item.map((e) => Variation.fromJson(e)).toList();

      //   return results.map((e) => e.size!).toList();
      // });
      
      return await conn.query('''
        SELECT DISTINCT v.size
        FROM products p
        INNER JOIN variations v ON v.id = p.id_variation
        WHERE v.category = @category AND p.fg_ativo = true AND v.fg_ativo = true AND v.business = @business
        ORDER BY v.size
      ''', substitutionValues: {
        'category': category,
        'business': globals.businessId
      }).then((List value) {
        conn.close();
        for (var row in value) {
          listSizes.add(row[0]);
        }

        return listSizes;
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
      
      // return await conn.from('products').select('''
      //   id, 
      //   name, 
      //   price, 
      //   description, 
      //   link_image, 
      //   variations!inner(category, size),
      //   id_variation
      // ''').eq('variations.category', categorySelected).eq('variations.size', sizeSelected).eq('variations.business', globals.businessId).like('name', searchProduct).eq('fg_ativo', 1).then((value) {
      //   List<dynamic> item = value;
      //   List<ProductItemList> results = item.map((e) => ProductItemList(
      //     id: e['id'],
      //     name: e['name'],
      //     price: e['price'],
      //     description: e['description'],
      //     link_image: e['link_image'],
      //     variation: Variation(
      //       category: e['variations']['category'],
      //       size: e['variations']['size'],
      //       id: e['id_variation']
      //     ),
      //   )).toList();
      
      return await conn.query('''
          SELECT p.id, p.name, p.price, p.description, p.link_image, v.category, v.size, p.id_variation, COALESCE(
          (SELECT f.id
            FROM favorites f 
            WHERE f.id_product = p.id AND f.uid = @uid
          ), 0)
          FROM products p
          INNER JOIN variations v ON v.id = p.id_variation
          WHERE v.category = @category AND v.size = @size AND v.business = @business AND p.name LIKE @search AND p.fg_ativo = true
          ORDER BY p.name
        ''', substitutionValues: {
          'category': categorySelected,
          'size': sizeSelected,
          'business': globals.businessId,
          'search': searchProduct,
          'uid': FirebaseAuth.instance.currentUser!.uid
        }).then((List value) {
        // List<dynamic> item = value;
        // List<ProductItemList> results = item.map((e) => ProductItemList(
        //   id: e['id'],
        //   name: e['name'],
        //   price: e['price'],
        //   description: e['description'],
        //   link_image: e['link_image'],
        //   variation: Variation(
        //     category: e['category'],
        //     size: e['size'],
        //     id: e['id_variation']
        //   ),
        // )).toList();
        List<ProductItemList> results = [];
        for(final row in value) {
          results.add(ProductItemList(
            id: row[0],
            name: row[1],
            price: row[2],
            description: row[3],
            link_image: row[4],
            variation: Variation(
              category: row[5],
              size: row[6],
              id: row[7]
            ),
            isFavorite: row[8] != 0
          ));
        }
        // List<ProductItemList> results = value.map((e) => ProductItemList(
        //   id: e[0],
        //   name: e[1],
        //   price: e[2],
        //   description: e[3],
        //   link_image: e[4],
        //   variation: Variation(
        //     category: e[5],
        //     size: e[6],
        //     id: e[7]
        //   ),
        // )).toList();
        conn.close();
        // if (item.isEmpty) {
        //   return [];
        // }

        return results;
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
        // await conn.from('products').insert({
        //   'name': name.toUpperCase(),
        //   'price': price,
        //   'description': description,
        //   'id_variation': results,
        //   'urlImage': urlImage
        // });
        
        await conn.query('insert into products (name, price, description, id_variation, urlImage) values (@name, @price, @description, @id_variation, @urlImage)', substitutionValues: {
          'name': name.toUpperCase(),
          'price': price,
          'description': description,
          'id_variation': results,
          'urlImage': urlImage
        });
        conn.close();
        // await conn.query('insert into products (name, price, description, id_variation, urlImage) values (?, ?, ?, ?, ?)',
        // [name.toUpperCase(), price, description, results.first[0], urlImage]);
        // await conn.close();
      });
    });
  }

  Future<void> remove(String id) async {
    await connectSupadatabase().then((conn) async {
      // await conn.from('products').delete().eq('id', id);
      
      await conn.query('delete from products where id = @id', substitutionValues: {
        'id': id
      });
      conn.close();
      // await conn.query('delete from products where id = ?', [id]);
      // await conn.close();
    });
  }

  void update(String id, String name, num price, String description, String category, String size, String urlImage) {
    getIdVariation(category, size).then((results) async {
      await connectSupadatabase().then((conn) async {
        
        await conn.query('update products set name = @name, price = @price, description = @description, id_variation = @id_variation, urlImage = @urlImage where id = @id', substitutionValues: {
          'name': name.toUpperCase(),
          'price': price,
          'description': description,
          'id_variation': results,
          'urlImage': urlImage,
          'id': id
        });
        conn.close();
        // await conn.from('products').update({
        //   'name': name.toUpperCase(),
        //   'price': price,
        //   'description': description,
        //   'id_variation': results,
        //   'urlImage': urlImage
        // }).eq('id', id);
        // await conn.query('update products set name = ?, price = ?, description = ?, id_variation = ?, urlImage = ? where id = ?',
        // [name.toUpperCase(), price, description, results.first[0], urlImage, id]);
        // await conn.close();
      });
    });
  }

  Future<List<CommentsProduct>> getCommentsProductUser(String nameProduct, String categoryProduct) async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query('''
        SELECT c.id, c.comment, c.uid, c.id_product, c.created_at, u.name, u.image
          FROM comments c
          INNER JOIN tb_user u ON u.uid = c.uid
          INNER JOIN products p ON p.id = c.id_product
          INNER JOIN variations v ON v.id = p.id_variation
          WHERE p.name = @name_product AND v.category = @category_product
        ORDER BY c.created_at DESC
      ''', substitutionValues: {
        'name_product': nameProduct,
        'category_product': categoryProduct
      }).then((List value) {
        conn.close();

        List<CommentsProduct> results = [];

        if (value.isEmpty) {
          return [];
        }

        for(final row in value) {
          results.add(CommentsProduct(
            id: row[0],
            comment: row[1],
            idUser: row[2],
            idProduct: row[3],
            date: row[4],
            nameUser: row[5],
            urlImageUser: row[6]
          ));
        }

        return results;
      });
    });
  }

  Future<void> addCommentProductUser(int idProduct, String idUser, String comment) async {
    await connectSupadatabase().then((conn) async {
      await conn.query('''
        INSERT INTO comments (comment, uid, id_product, created_at)
        VALUES (@comment, @id_user, @id_product, @date)
      ''', substitutionValues: {
        'comment': comment,
        'id_user': idUser,
        'id_product': idProduct,
        'date': DateTime.now().toUtc()
      });
      conn.close();
    });
  }

  Future<DateTime?> getProductLastSale(String nameProduct, String categoryProduct) async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query('''
        SELECT MAX(i.created_at)
          FROM items i
          INNER JOIN products p ON p.id = i.id_product
          INNER JOIN variations v ON v.id = p.id_variation
          INNER JOIN orders o ON o.id = i.id_order
          INNER JOIN tb_user u ON u.uid = o.uid
          WHERE p.name = @name_product AND v.category = @category_product AND u.uid = @uid
      ''', substitutionValues: {
        'name_product': nameProduct,
        'category_product': categoryProduct,
        'uid': FirebaseAuth.instance.currentUser!.uid
      }).then((List value) {
        conn.close();

        if (value.isEmpty) {
          return null;
        }

        return value.first[0];
      });
    });
  }

  Future<ProductItemList> getProduct(int id) async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query('''
        SELECT p.id, p.name, p.price, p.description, p.link_image, v.category, v.size, v.id, COALESCE(
          (SELECT f.id
            FROM favorites f 
            WHERE f.id_product = p.id AND f.uid = @uid
          ), 0)
          FROM products p
          INNER JOIN variations v ON v.id = p.id_variation
          WHERE p.id = @id
      ''', substitutionValues: {
        'id': id,
        'uid': FirebaseAuth.instance.currentUser!.uid
      }).then((List value) {
        conn.close();

        ProductItemList product = ProductItemList(
          id: 0,
          name: '',
          price: 0,
          description: '',
          link_image: '',
          variation: Variation(
            category: '',
            size: '',
            id: 0
          ),
          isFavorite: false
        );
        
        if (value.isNotEmpty) {
          product = ProductItemList(
            id: value.first[0],
            name: value.first[1],
            price: value.first[2],
            description: value.first[3],
            link_image: value.first[4],
            variation: Variation(
              category: value.first[5],
              size: value.first[6],
              id: value.first[7]
            ),
            isFavorite: value.first[8] != 0
          );
        }

        return product;
      });
    });
  }

  Future<List<ProductItemList>> productsBestSellesUser() async {
    return await connectSupadatabase().then((conn) async {
      
      return await conn.query(
        '''
          SELECT t.* FROM 
          (
            SELECT distinct on (p.id) p.id, p.name, p.price, p.id_variation, v.category, v.size, p.description, p.link_image, COALESCE(
              (SELECT f.id
                FROM favorites f 
                WHERE f.id_product = p.id AND f.uid = @uid
              ), 0),

              (
                SELECT SUM(ia.qtd) from items ia
                INNER JOIN orders oa ON oa.id = ia.id_order
                WHERE oa.uid = @uid and oa.status = @status and ia.fg_current = false AND ia.id_product = i.id_product
                GROUP BY (ia.id_product)
              )

            FROM items i 
            INNER JOIN products p ON p.id = i.id_product 
            INNER JOIN variations v ON v.id = i.id_variation 
            INNER JOIN orders o ON o.id = i.id_order
            where o.uid = @uid and o.status = @status and i.fg_current = false
            ) t
          ORDER BY t.sum DESC
          LIMIT 10
        ''', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 'FINALIZADO',
      }).then((List value) {
        conn.close();
        List<ProductItemList> productsCart = [];

        if (value.isEmpty) {
          return productsCart;
        }

        for (var element in value) {
          productsCart.add(
            ProductItemList(
              id: element[0],
              name: element[1],
              price: element[2],
              variation: Variation(
                id: element[3],
                category: element[4],
                size: element[5],
              ),
              description: '${element[9]} quantidades${element[6] == null ? '' : '\n${element[6]}'}',
              link_image: element[7],
              isFavorite: element[8] != 0
            )
          );
        }

        return productsCart;
      });
    });
  }

  Future<void> setProductFavorite(int idProduct, bool isFavorite) async {
    await connectSupadatabase().then((conn) async {

      if (!isFavorite) {
        await conn.query('''
          INSERT INTO favorites (id_product, uid)
          VALUES (@id_product, @uid)
        ''', substitutionValues: {
          'id_product': idProduct,
          'uid': FirebaseAuth.instance.currentUser!.uid
        });
      } else {
        await conn.query('''
          DELETE FROM favorites
          WHERE id_product = @id_product AND uid = @uid
        ''', substitutionValues: {
          'id_product': idProduct,
          'uid': FirebaseAuth.instance.currentUser!.uid
        });
      }

      conn.close();
    });
  }

  Future<List<ProductItemList>> getProductsFavorites() async {
    return await connectSupadatabase().then((conn) async {
      return await conn.query('''
        SELECT p.id, p.name, p.price, p.id_variation, v.category, v.size, p.description, p.link_image, COALESCE(
          (SELECT f.id
            FROM favorites f 
            WHERE f.id_product = p.id AND f.uid = @uid
          ), 0)
        FROM products p
        INNER JOIN variations v ON v.id = p.id_variation
        WHERE p.id IN (
          SELECT f.id_product
          FROM favorites f
          WHERE f.uid = @uid
        )
      ''', substitutionValues: {
        'uid': FirebaseAuth.instance.currentUser!.uid
      }).then((List value) {
        conn.close();
        List<ProductItemList> productsCart = [];

        if (value.isEmpty) {
          return productsCart;
        }

        for (var element in value) {
          productsCart.add(
            ProductItemList(
              id: element[0],
              name: element[1],
              price: element[2],
              variation: Variation(
                id: element[3],
                category: element[4],
                size: element[5],
              ),
              description: element[6],
              link_image: element[7],
              isFavorite: element[8] != 0
            )
          );
        }

        return productsCart;
      });
    });
  }
}