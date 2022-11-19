import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SalesController {
  void add() {
    FirebaseFirestore.instance.collection('sales').add(
      {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 0,
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

  Future<String?> idSale() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var res;
    await FirebaseFirestore.instance
        .collection('sales')
        .where('uid', isEqualTo: uid)
        .get()
        .then(
      (q) {
        if (q.docs.isNotEmpty) {
          return res = q.docs[0].id;
        } else {
          add();
          idSale();
        }
      },
    );

    return res;
  }
}