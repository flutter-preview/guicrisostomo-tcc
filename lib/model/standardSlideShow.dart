import 'package:tcc/controller/mysql/utils.dart';
import 'package:tcc/view/widget/snackBars.dart';

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
      
      return await conn.query('SELECT DISTINCT category, url_image FROM variations WHERE business = @v_business', substitutionValues: {
        'v_business': business
      }).then((List value) {
        conn.close();
        for (final row in value) {
          list.add(
            SlideShow(
              title: row[0],
              path: row[1],
            )
          );
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