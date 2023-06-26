// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/controller/postgres/Lists/table.dart';
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
        
        GoRouter.of(context).go('/products/add_product', extra: ProductItemList(id: 0, name: '', description: '', linkImage: null, price: 0, variation: Variation(), isFavorite: false,));
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        
        children: [
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
    return (globals.isSelectNewItem) ? Container(
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
    ) : const CartInfo();
  }

  Future<int> getIdSale() async {
    return await SalesController.instance.idSale().then((value) {
      return value;
    });
  }

  Future<bool> getListItemCurrent() async {
    if (globals.idSaleSelected != 0 && globals.idSaleSelected != null) {
        return await ProductsCartController.instance.listItemCurrent(globals.idSaleSelected!).then((products) {
          return products.isNotEmpty;
        });
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    getIdSale().then((value) {
      setState(() {
        globals.idSaleSelected = value;
      });

      getListItemCurrent().then((value) {
        setState(() {
          globals.isSelectNewItem = value;
        });
      });
    });

    if (globals.numberTable == null) {
      TablesController.instance.userVinculatedToTable().then((value) {
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

    return FutureBuilder(
      future: getIdSale(),
      initialData: globals.idSaleSelected,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              globals.globalSelectedIndexBotton == 2 ? 
                selectNewItem() 
                : const CartInfo(),
              
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

                    globals.numberTable != null && globals.userType != 'manager' ?
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
                        if (globals.userType == 'manager') {
                          GoRouter.of(context).go('/home_manager');
                          break;
                        } else if (globals.userType == 'employee') {
                          GoRouter.of(context).go('/home_employee');
                          break;
                        } else {
                          GoRouter.of(context).go('/home');
                          break;
                        }
                      case 1:
                        // Navigator.pushNamed(context, 'order');
                        GoRouter.of(context).go('/order');
                        break;
                      case 2:
                        if (globals.userType == 'manager') {
                          GoRouter.of(context).go('/list_products');
                          break;
                        } else {
                          GoRouter.of(context).go('/products');
                          break;
                        }

                      case 3:
                        globals.userType == 'customer' ?
                          globals.numberTable != null ? {
                            GoRouter.of(context).go('/waiter')
                          } : {
                          GoRouter.of(context).go('/table')
                        } : {
                        
                          if (globals.numberTable != null) {
                            GoRouter.of(context).go('/waiter')
                          } else {
                            GoRouter.of(context).go('/table_manager')
                          }
                        };

                        break;
                      case 4:
                        
                        if (globals.userType == 'manager') {
                          GoRouter.of(context).go('/more');
                          break;
                        } else if (globals.userType == 'employee') {
                          GoRouter.of(context).go('/profile/edit_datas');
                          break;
                        } else {
                          GoRouter.of(context).go('/profile');
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
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: globals.primary,
            ),
          );
        } else {
          return const SizedBox();
        }
      }
    );
  }
}