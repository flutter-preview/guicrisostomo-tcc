// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/controller/firebase/productsCart.dart';
import 'package:tcc/controller/firebase/sales.dart';
import 'package:tcc/model/standardSlideShow.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/customer/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/listCart.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/slideShow.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {

  final String iconOrder = 'lib/images/iconOrder.svg';
  final String iconMenu = 'lib/images/iconMenu.svg';

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

    setState(() {
      globals.userType = 'customer';
    });

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
                        Icon(Icons.timer_outlined, size: 20, color: globals.primary),

                        const SizedBox(width: 5,),

                        Text(
                          // ignore: unnecessary_string_escapes
                          'Criado \às $dateText'
                        )
                      ],
                    ),
                    
                    const SizedBox(height: 10,),

                    Row(
                      children: [
                        Icon(Icons.room_service_outlined, size: 20, color: globals.primary),

                        const SizedBox(width: 5,),

                        const Text(
                          'Mesa criada pelo garçom José'
                        )
                      ],
                    ),

                    const SizedBox(height: 10,),

                    Row(
                      children: [
                        Icon(Icons.attach_money, size: 20, color: globals.primary),

                        const SizedBox(width: 5,),

                        Text(
                          'TOTAL: R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}'
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

    List<SlideShow> listSlideShow = [
      SlideShow(
        path: 'lib/images/imgPizza.jpg',
        title: 'Pizzas',
        onTap: () {
        },
      ),
      SlideShow(
        path: 'lib/images/imgFood.jpg',
        title: 'Comidas',
        onTap: () {
        },
      ),
    ];
    
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Inicio',
        context: context,
        icon: Icons.home
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // imgCenter(imgHome),
            SlideShowWidget(listSlideShow: listSlideShow,),
            
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SectionVisible(
                    nameSection: 'Informações do seu pedido atual',
                    isShowPart: true,
                    child: dataSales(),
                  ),
                  
                  
                  SectionVisible(
                    nameSection: 'Favoritos',
                    isShowPart: false,
                    child: ProductsCart(list),
                  ),

                  SectionVisible(
                    nameSection: 'Mais pedidos',
                    isShowPart: false,
                    child: ProductsCart(list),
                  ),

                ],
              ),
            ),
          ]
        )
      ),

      bottomNavigationBar: const BottomCustomer(),
    );
  }
}