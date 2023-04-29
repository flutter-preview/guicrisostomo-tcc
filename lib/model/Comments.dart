class CommentsProduct {
  final int id;
  final int idProduct;
  final String idUser;
  final String comment;
  final DateTime date;
  final String nameUser;
  final String? urlImageUser;

  CommentsProduct({
    required this.id,
    required this.idProduct,
    required this.idUser,
    required this.comment,
    required this.date,
    required this.nameUser,
    required this.urlImageUser,
  });
}