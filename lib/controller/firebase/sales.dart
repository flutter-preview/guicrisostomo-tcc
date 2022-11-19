import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SalesController {
  void add(status) {
    FirebaseFirestore.instance.collection('sales').add(
      {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': status,
      },
    );
  }

  void update(id, status) {
    FirebaseFirestore.instance.collection('sales').doc(id).update(
      {
        'status': status,
      },
    );
  }
}