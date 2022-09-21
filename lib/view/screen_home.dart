import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  final String iconOrder = 'lib/images/iconOrder.svg';
  final String iconMenu = 'lib/images/iconMenu.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            
          ],
        ),

        
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(50, 62, 64, 1),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromRGBO(242, 169, 34, 1),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromRGBO(242, 169, 34, 1),),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(iconOrder, height: 25, fit: BoxFit.fill,),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(iconMenu, height: 25, fit: BoxFit.fill,),
            label: 'Cardápio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity, color: Color.fromRGBO(242, 169, 34, 1),),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}