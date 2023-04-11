class Business {
  String? cnpj;
  String? name;
  String? description;
  String? linkImage;
  BigInt? phone;
  bool? active;
  bool? highValue;

  Business({
    this.cnpj,
    this.name,
    this.description,
    this.linkImage,
    this.phone,
    this.active,
    this.highValue,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    cnpj: json["cnpj"],
    name: json["name"],
    description: json["description"],
    linkImage: json["link_image"],
    phone: json["phone"],
    active: json["active"],
    highValue: json["high_value"],
  );
}