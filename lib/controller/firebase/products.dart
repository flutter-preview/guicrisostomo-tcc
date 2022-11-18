import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsController {

  list() {
    return FirebaseFirestore.instance
      .collection('products');
  }

  void add(name, price, description, category, size, urlImage) {
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