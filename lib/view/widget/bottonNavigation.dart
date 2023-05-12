// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/controller/postgres/Lists/table.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/Variation.dart';
import 'package:tcc/view/widget/cartInfo.dart';
import '../../globals.dart' as globals;

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  Widget cancelSelection() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(globals.primary),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),

      onPressed: () {
        Navigator.pop(context);
        Navigator.push(context, navigator('products/add_product', ProductItemList(id: 0, name: '', description: '', link_image: null, price: 0, variation: Variation(), isFavorite: false,)));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        
        children: const [
          Icon(
            Icons.close,
            size: 15,
          ),

          SizedBox(width: 5),

          Text(
            'Cancelar seleção',
            style: TextStyle(
              fontSize: 13,
            ),
          ),

          // 
        ],
      ),
    );
  }

  Widget selectNewItem() {
    return FutureBuilder(
      future: getListItemCurrent(),
      builder: (context, builder) {
        if (builder.data == true || globals.isSelectNewItem) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Selecione novo item',
                  style: TextStyle(
                    color: globals.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                cancelSelection(),
              ],
            )
          );
        } else {
          return CartInfo();
        }
      }
    );
  }

  Future<bool> getListItemCurrent() async {
    return await SalesController().idSale().then((value) async {
      print('idSale: $value');
      if (value != 0) {
        return await ProductsCartController().listItemCurrent(value).then((products) {
          if (products.isNotEmpty) {
            return true;
          } else {
            return false;
          }
        });
      } else {
        return false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getListItemCurrent().then((value) {
      if (value) {
        setState(() {
          globals.isSelectNewItem = true;
        });
      }
    });

    if (globals.numberTable == null) {
      TablesController().userVinculatedToTable().then((value) {
        if (value != 0) {
          setState(() {
            globals.numberTable = value;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    const String iconMenu = 'lib/images/iconMenu.svg';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        
        globals.globalSelectedIndexBotton == 2 ? 
          selectNewItem() 
          : CartInfo(),
        
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
              fontSize: 14,
            ),

            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
                label: 'Inicio',
              ),

              const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
                label: 'Pedidos',
              ),

              globals.userType != 'manager' ?
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(iconMenu, height: 25, fit: BoxFit.fill,),
                  label: 'Cardápio',
                ) : BottomNavigationBarItem(
                  icon: SvgPicture.asset(iconMenu, height: 25, fit: BoxFit.fill,),
                  label: 'Produtos',
                ),

              globals.numberTable != null && globals.userType == 'customer' ?
                const BottomNavigationBarItem(
                  icon: Icon(Icons.room_service_outlined, color: Colors.white),
                  label: 'Sua mesa',
                ) :
                const BottomNavigationBarItem(
                  icon: Icon(Icons.table_restaurant, color: Colors.white),
                  label: 'Mesa',
                ),
      
              globals.userType != 'manager' ?
                const BottomNavigationBarItem(
                  icon: Icon(Icons.perm_identity, color: Colors.white),
                  label: 'Perfil',
                ) : const BottomNavigationBarItem(
                  icon: Icon(Icons.more_vert_rounded, color: Colors.white),
                  label: 'Mais',
                )
            ],
        
            currentIndex: globals.globalSelectedIndexBotton,
            onTap: (int index) {
              switch (index) {
                case 0:
                  Navigator.of(context).pop();
                  if (globals.userType == 'manager') {
                    Navigator.push(context, navigator('home_manager'));
                    break;
                  } else if (globals.userType == 'employee') {
                    Navigator.push(context, navigator('home_employee'));
                    break;
                  } else {
                    Navigator.push(context, navigator('home'));
                    break;
                  }
                case 1:
                  Navigator.of(context).pop();
                  // Navigator.pushNamed(context, 'order');
                  Navigator.push(context, navigator('order'));
                  break;
                case 2:
                  Navigator.of(context).pop();
                  if (globals.userType == 'manager') {
                    Navigator.push(context, navigator('list_products'));
                    break;
                  } else {
                    Navigator.push(context, navigator('products'));
                    break;
                  }

                case 3:
                  globals.userType == 'customer' ?
                    globals.numberTable != null ? {
                      Navigator.of(context).pop(),
                      Navigator.push(context, navigator('waiter'))
                    } : {
                    Navigator.of(context).pop(),
                    Navigator.push(context, navigator('table'))
                  } : {
                  
                    if (globals.numberTable != null) {
                      Navigator.of(context).pop(),
                      Navigator.push(context, navigator('waiter'))
                    } else {
                      Navigator.of(context).pop(),
                      Navigator.push(context, navigator('table_manager'))
                    }
                  };

                  break;
                case 4:
                  Navigator.of(context).pop();
                  
                  if (globals.userType == 'manager') {
                    Navigator.push(context, navigator('more'));
                    break;
                  } else if (globals.userType == 'employee') {
                    Navigator.push(context, navigator('profile/edit_datas'));
                    break;
                  } else {
                    Navigator.push(context, navigator('profile'));
                    break;
                  }
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