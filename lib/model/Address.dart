class Address {
  final int id;
  final String street;
  final String district;
  final int number;
  final String nickname;
  String? city;
  String? state;
  String? zip;
  String? complement;
  String? reference;

  Address({
    required this.id,
    required this.street,
    required this.district,
    required this.number,
    required this.nickname,
    this.city,
    this.state,
    this.zip,
    this.complement,
    this.reference,
  });
}