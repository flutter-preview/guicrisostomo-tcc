import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsController {

  list() {
    return FirebaseFirestore.instance
      .collection('products');
  }

  listSearch(String name) {
    return FirebaseFirestore.instance
      .collection('products')
      .where('name', isGreaterThanOrEqualTo: name.toString().toUpperCase())
      .where('name', isLessThan: '${name.toString().toUpperCase()}\uf8ff');
  }

  void add(String name, num price, String description, String category, String size, String urlImage) {
    FirebaseFirestore.instance.collection('products').add(
      {
        'name': name.toUpperCase(),
        'price': price,
        'description': description,
        'category': category,
        'size': size,
        'urlImage': urlImage,
      },
    );
  }

  void remove(String id) {
    FirebaseFirestore.instance.collection('products').doc(id).delete();
  }

  void update(String id, String name, num price, String description, String category, String size, String urlImage) {
    FirebaseFirestore.instance.collection('products').doc(id).update(
      {
        'name': name,
        'price': price,
        'description': description,
        'category': category,
        'size': size,
        'urlImage': urlImage,
      },
    );
  }
}