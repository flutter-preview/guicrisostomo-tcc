import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/products.dart';
import 'package:tcc/controller/firebase/sales.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/floatingButton.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';
import 'package:tcc/view/widget/productItem.dart';

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

  @override
  void initState() {
    super.initState();
    list = ProductsController().list();
    listSale = SalesController().listSalesOnDemand().snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Widget? dataSales() {
      return StreamBuilder<QuerySnapshot>(
        stream: listSale,
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
                return Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.timer_outlined, size: 20, color: Color.fromRGBO(242, 169, 34, 1)),
                        SizedBox(width: 5,),
                        Text(
                          // ignore: unnecessary_string_escapes
                          'Criado \às 19:49 do dia 27/05/2022'
                        )
                      ],
                    ),
                    
                    const SizedBox(height: 10,),

                    Row(
                      children: const [
                        Icon(Icons.people_rounded, size: 20, color: Color.fromRGBO(242, 169, 34, 1)),
                        SizedBox(width: 5,),
                        Text(
                          'Mesa criada pelo garçom José'
                        )
                      ],
                    ),

                    const SizedBox(height: 10,),

                    Row(
                      children: const [
                        Icon(Icons.attach_money, size: 20, color: Color.fromRGBO(242, 169, 34, 1)),
                        SizedBox(width: 5,),
                        Text(
                          'TOTAL: R\$ 91,00'
                        )
                      ],
                    ),

                    const SizedBox(height: 10,),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Itens pedidos',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ),
                  ],
                );
              } else {
                return null;
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
            
            

            ProductItem(list)
          ]
        )
      ),

      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}