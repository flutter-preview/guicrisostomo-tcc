class Variation {
  late int? id;
  late String? category;
  late String?size;

  Variation({
    this.id = 0, 
    this.category = '', 
    this.size = ''
  });

  Variation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    size = json['size'];
  }
}