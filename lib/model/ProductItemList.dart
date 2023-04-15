import 'package:tcc/model/Variation.dart';

class ProductItemList {
  int id;
  String name;
  String description;
  String? link_image;
  num price;
  Variation? variation;

  ProductItemList({
    required this.id,
    required this.name,
    required this.description,
    required this.link_image,
    required this.price,
    required this.variation,
  });
}