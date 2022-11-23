// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controller/firebase/productsCart.dart';
import 'package:tcc/controller/firebase/sales.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/floatingButton.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';
import 'package:tcc/view/widget/listCart.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {

  final String iconOrder = 'lib/images/iconOrder.svg';
  final String iconMenu = 'lib/images/iconMenu.svg';

  final String imgHome = 'lib/images/imgHomeCustomer.svg';

  var list;
  var listSale;
  String? idSale;

  void getIdSale() async {
    await SalesController().idSale().then((value){
      setState(() {
        idSale = value;
        list = ProductsCartController().list(idSale);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    list = ProductsCartController().list(idSale);
    listSale = SalesController().listSalesOnDemand();
  }

  @override
  Widget build(BuildContext context) {
    if (idSale == null) {
      getIdSale();
    }

    Widget dataSales() {
      return StreamBuilder<QuerySnapshot>(
        stream: listSale.snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Text('Não foi possível conectar.'),
              );
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              final dados = snapshot.requireData;
              if (dados.size > 0) {
                dynamic item = dados.docs[0].data();
                Map<String, dynamic> map = item!;
                DateTime date = (map['date'] as Timestamp).toDate();
                String dateText = DateFormat("d 'de' MMMM 'de' y 'às' HH':'mm':'ss", "pt_BR").format(date);
                num total = item['total'];

                return Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 20, color: Color.fromRGBO(242, 169, 34, 1)),

                        const SizedBox(width: 5,),

                        Text(
                          // ignore: unnecessary_string_escapes
                          'Criado \às $dateText'
                        )
                      ],
                    ),
                    
                    const SizedBox(height: 10,),

                    /*Row(
                      children: [
                        const Icon(Icons.people_rounded, size: 20, color: Color.fromRGBO(242, 169, 34, 1)),

                        const SizedBox(width: 5,),

                        Text(
                          'Mesa criada pelo garçom José'
                        )
                      ],
                    ),

                    const SizedBox(height: 10,),*/

                    Row(
                      children: [
                        const Icon(Icons.attach_money, size: 20, color: Color.fromRGBO(242, 169, 34, 1)),

                        const SizedBox(width: 5,),

                        Text(
                          'TOTAL: R\$ $total'
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return const Text('Nenhuma venda iniciada');
              }
          }
        }
      );
    }
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            
            imgCenter(imgHome),
            const SizedBox(height: 10,),

            const Text(
              'Informações do seu pedido',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10,),
            
            dataSales(),

            ProductsCart(list)
          ]
        )
      ),

      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}