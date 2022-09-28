import 'package:flutter/material.dart';
import 'package:tcc/modal/bottonNavigationCustomer.dart';
import 'package:tcc/modal/imageMainScreens.dart';
import 'package:tcc/modal/productItem.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {

  final String iconOrder = 'lib/images/iconOrder.svg';
  final String iconMenu = 'lib/images/iconMenu.svg';

  final String imgHome = 'lib/images/imgHomeCustomer.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          
          child: Column(
            children: [
              
              imgCenter(imgHome),
              SizedBox(height: 10,),

              Text(
                'Itens mais pedidos',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 10,),

              Text(
                'Informações da sua mesa',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              
              productItem(),

              SizedBox(height: 10,),

              
              Container(
                child :Column(children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.timer_outlined, size: 20, color: Color.fromRGBO(242, 169, 34, 1)),
                        Text(
                          'Criado \às 19:49 do dia 27/05/2022'
                        )
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 5,),

                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.people_rounded, size: 20, color: Color.fromRGBO(242, 169, 34, 1)),
                        Text(
                          'Mesa criada pelo garçom José'
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 5,),

                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.attach_money, size: 20, color: Color.fromRGBO(242, 169, 34, 1)),
                        Text(
                          'TOTAL: R\$ 91,00'
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Itens pedidos hoje',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ),

                  productItem(),
                ],)
              ),
            ]
          )
        )
      ),

      bottomNavigationBar: Bottom(),
    );
  }
}