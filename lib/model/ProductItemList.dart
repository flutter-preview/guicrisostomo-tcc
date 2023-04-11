class ProductItemList {
  int id;
  String name;
  String description;
  String? link_image;
  num price;
  String category;
  String size;
  int id_variation;

  ProductItemList({
    required this.id,
    required this.name,
    required this.description,
    required this.link_image,
    required this.price,
    required this.category,
    required this.size,
    required this.id_variation,
  });

  factory ProductItemList.fromJson(Map<String, dynamic> json) => ProductItemList(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    link_image: json["link_image"],
    price: json["price"],
    category: json["category"],
    size: json["size"],
    id_variation: json["id_variation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "link_image": link_image,
    "price": price,
    "category": category,
    "size": size,
    "id_variation": id_variation,
  };
}