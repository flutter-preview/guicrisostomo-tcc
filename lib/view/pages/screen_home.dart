import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/products.dart';
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

  @override
  void initState() {
    super.initState();
    list = ProductsController().list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            
            imgCenter(imgHome),
            const SizedBox(height: 10,),

            const Text(
              'Informações do seu último pedido',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10,),
            
            Column(
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

                ProductItem(list),
              ]
            ),
          ]
        )
      ),

      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}