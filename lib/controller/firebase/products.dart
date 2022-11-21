import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsController {

  list() {
    return FirebaseFirestore.instance
      .collection('products');
  }

  listSearch(name) {
    return FirebaseFirestore.instance
      .collection('products')
      .where('name', isGreaterThanOrEqualTo: name.toString().toUpperCase())
      .where('name', isLessThan: '${name.toString().toUpperCase()}\uf8ff');
  }

  void add(name, num price, description, category, size, urlImage) {
    FirebaseFirestore.instance.collection('products').add(
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

  void remove(id) {
    FirebaseFirestore.instance.collection('products').doc(id).delete();
  }

  void update(id, name, price, description, category, size, urlImage) {
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