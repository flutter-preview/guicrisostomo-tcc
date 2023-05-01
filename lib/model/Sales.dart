class Sales {
  int id;
  String uid;
  int? addressId;
  int? table;
  String cnpj;
  String? payment;
  String? type;
  String? observation;
  String status;
  DateTime date;
  static num total = 0.0;
  
  Sales({
    required this.id,
    required this.uid,
    this.addressId,
    this.table,
    required this.cnpj,
    this.payment,
    this.type,
    this.observation,
    required this.status,
    required this.date,
  });

  num getTotal() {
    return total;
  }

  void setTotal(num value) {
    total = value;
  }
}