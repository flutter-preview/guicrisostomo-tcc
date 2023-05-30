import 'package:tcc/model/Variation.dart';

class ProductItemList {
  int id;
  String name;
  String? description;
  String? linkImage;
  num price;
  Variation? variation;
  bool isFavorite = false;

  ProductItemList({
    required this.id,
    required this.name,
    required this.description,
    required this.linkImage,
    required this.price,
    required this.variation,
    required this.isFavorite,
  });
}