import 'package:tcc/controller/postgres/utils.dart';
import 'package:tcc/globals.dart' as globals;

class SlideShow {
  String path;
  String title;
  Function()? onTap;

  SlideShow({
    required this.path,
    required this.title,
    this.onTap,
  });

  static Future<List<SlideShow>> list(business, context) async {
    List<SlideShow> list = [];

    return await connectSupadatabase().then((conn) async {
      
      return await conn.query('''
        SELECT DISTINCT ON (v.category) v.category, v.url_image
        FROM products p
        INNER JOIN variations v ON v.id = p.id_variation
        WHERE v.business = @business AND p.fg_ativo = true AND v.fg_ativo = true AND v.is_show_home = true
        ORDER BY v.category
      ''', substitutionValues: {
        'business': business
      }).then((List value) {
        conn.close();
        for (final row in value) {
          list.add(
            SlideShow(
              title: row[0],
              path: row[1],
            )
          );

          if (globals.categoriesBusiness == []) {
            globals.categoriesBusiness.add(row[0]);
          } else {
            if (!globals.categoriesBusiness.contains(row[0])) {
              globals.categoriesBusiness.add(row[0]);
            }
          }
        }
        return list;
      }).catchError((e) {
        print(e);
        return list;
      });
    }).catchError((e) {
      print(e);
      return list;
    });
    // await connectMySQL().then((conn) async {
    //   var querySelect = '''
    //     SELECT DISTINCT category, url_image 
    //     FROM variations
    //     WHERE business = ? 
    //   ''';
    //   var results = await conn.query(querySelect, [business]);
    //   await conn.close();
    //   for (var row in results) {
    //     list.add(
    //       SlideShow(
    //         title: row[0],
    //         path: row[1],
    //       )
    //     );
    //   }
    // });

    // return list;
  }
}