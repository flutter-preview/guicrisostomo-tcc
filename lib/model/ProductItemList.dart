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

  factory ProductItemList.fromJson(Map<String, dynamic> json) => ProductItemList(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    link_image: json["link_image"],
    price: json["price"],
    variation: json["variation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "link_image": link_image,
    "price": price,
    "variation": variation,
  };
}