import 'package:flutter/material.dart';
import 'package:tcc/controller/mysql/utils.dart';

class SlideShow {
  String path;
  String title;
  Function()? onTap;

  SlideShow({
    required this.path,
    required this.title,
    this.onTap,
  });

  static Future<List<SlideShow>> list(business) async {
    List<SlideShow> list = [];
    
    await connectMySQL().then((conn) async {
      var querySelect = '''
        SELECT DISTINCT category, url_image 
        FROM variations
        WHERE business = ? 
      ''';
      var results = await conn.query(querySelect, [business]);
      await conn.close();
      for (var row in results) {
        list.add(
          SlideShow(
            title: row[0],
            path: row[1],
          )
        );
      }
    });

    return list;
  }
}