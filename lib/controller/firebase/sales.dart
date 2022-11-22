import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcc/view/widget/snackBars.dart';

class SalesController {
  void add() async {
    await FirebaseFirestore.instance.collection('sales').add(
      {
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'status': 0,
        'date': DateTime.now(),
        'total': 0,
      },
    );
  }

  void update(id, status, context) {
    FirebaseFirestore.instance.collection('sales').doc(id).update(
      {
        'status': status,
        'date': DateTime.now(),
      },
    ).then((value) => {
      success(context, 'Pedido finalizado com sucesso')
    }).catchError((e) {
      error(context, 'Ocorreu um erro ao finalizar o pedido ${e.code.toString()}');
    });
  }

  void updateTotal(id, total) {
    FirebaseFirestore.instance.collection('sales').doc(id).update(
      {
        'total': total,
      },
    );
  }

  Future<String> idSale() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var res;
    await FirebaseFirestore.instance
        .collection('sales')
        .where('uid', isEqualTo: uid)
        .where('status', isEqualTo: 0)
        .get()
        .then(
      (q) {
        
        if (q.docs.isNotEmpty) {
          res = q.docs[0].id;
          return res;
        } else {
          add();
          idSale();
        }
      },
    );
    
    if (res == null) {
      return idSale();
    } else {
      return res;
    }
  }

  Future<num> getTotal() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var res;
    await FirebaseFirestore.instance
        .collection('sales')
        .where('uid', isEqualTo: uid)
        .where('status', isEqualTo: 0)
        .get()
        .then(
      (q) {
        if (q.docs.isNotEmpty) {
          res = q.docs[0].data()['total'];
        }
      },
    );
    
    if (res == null) {
      return getTotal();
    } else {
      return res;
    }
  }

  listSalesFinalize() {
    var uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
      .collection('sales')
      .where('uid', isEqualTo: uid)
      .where('status', isEqualTo: 1);
  }

  listSalesOnDemand() {
    var uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
      .collection('sales')
      .where('uid', isEqualTo: uid)
      .where('status', isEqualTo: 0);
  }
}