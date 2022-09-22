import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    @override
  State<Bottom> createState() => _BottomState();

  int _selectedIndex = 0;
  final String iconOrder = 'lib/images/iconOrder.svg';
  final String iconMenu = 'lib/images/iconMenu.svg';

  return BottomNavigationBar(
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

    currentIndex: _selectedIndex,
    onTap: (int index) {
      switch (index) {
        case 0:
          // only scroll to top when current index is selected.
          Navigator.pushNamed(context, 'home');
          break;
        case 1:
          Navigator.pushNamed(context, 'order');
          break;
        case 2:
          Navigator.pushNamed(context, 'product');
          break;
        case 3:
          Navigator.pushNamed(context, 'profile');
          break;
      }
      setState(
        () {
          _selectedIndex = index;
        },
      );
    },
  );
  }
}