// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/main.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/pages/screen_order.dart';
import 'package:tcc/view/widget/cartInfo.dart';
import '../../../globals.dart' as globals;

class BottomCustomer extends StatefulWidget {
  const BottomCustomer({super.key});

  @override
  State<BottomCustomer> createState() => _BottomCustomerState();
}

class _BottomCustomerState extends State<BottomCustomer> {

  @override
  Widget build(BuildContext context) {

    const String iconOrder = 'lib/images/iconOrder.svg';
    const String iconMenu = 'lib/images/iconMenu.svg';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        cartInfo(context),
        
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                globals.primaryBlack,
                globals.primary.withOpacity(0.9),
              ]
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.transparent,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
        
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
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
        
              globals.isSaleInTable ?
                const BottomNavigationBarItem(
                  icon: Icon(Icons.room_service_outlined, color: Colors.white),
                  label: 'Garçom',
                ) :
                const BottomNavigationBarItem(
                  icon: Icon(Icons.table_restaurant, color: Colors.white),
                  label: 'Mesa',
                ),
        
              
              const BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity, color: Colors.white),
                label: 'Perfil',
              ),
            ],
        
            currentIndex: globals.globalSelectedIndexBotton,
            onTap: (int index) {
              switch (index) {
                case 0:
                  Navigator.of(context).pop();
                  Navigator.push(context, navigator('home'));
                  break;
                case 1:
                  Navigator.of(context).pop();
                  // Navigator.pushNamed(context, 'order');

                  Navigator.push(context, navigator('order'));
                  break;
                case 2:
                  Navigator.of(context).pop();
                  Navigator.push(context, navigator('products'));
                  break;
                case 3:
                  
                  if (globals.isSaleInTable) {
                    Navigator.of(context).pop();
                    Navigator.push(context, navigator('waiter'));
                    break;
                  } else {
                    Navigator.of(context).pop();
                    Navigator.push(context, navigator('table'));
                    break;
                  }
        
                case 4:
                  Navigator.of(context).pop();
                  Navigator.push(context, navigator('profile'));
                  break;
              }
        
              setState(
                () {
                  globals.globalSelectedIndexBotton = index;
                },
              );
              
            },
          ),
        ),
      ],
    );
  }
}