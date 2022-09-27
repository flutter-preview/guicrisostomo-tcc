import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          margin: EdgeInsets.all(16),
          
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
              
              Expanded(
                child: (
                  productItem()
                )
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
              
              Container(
                child :Column(children: [
                  Icon(Icons.timer_outlined, size: 20, color: Color.fromRGBO(242, 169, 34, 1)),
                ],)
              )
              
            ]
          )
        )
      ),

      bottomNavigationBar: Bottom(),
    );
  }
}
