// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tcc/controller/mysql/Lists/productsCart.dart';
import 'package:tcc/controller/mysql/Lists/sales.dart';
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
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text('Adicionar itens selecionados'),
            content: Text('Deseja adicionar os itens selecionados?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Não'),
                  ),

                  TextButton(
                    onPressed: () {
                      globals.isSelectNewItem = false;
                      Navigator.pop(context);
                    },
                    child: Text('Sim'),
                  ),
                ],
              ),

              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(globals.primary),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, navigator('products/add_product', ProductItemList(id: 0, name: '', description: '', link_image: null, price: 0, variation: Variation())));
                }, 
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.shopping_cart,
                        size: 20,
                      ),
                
                      SizedBox(width: 5),
                      
                      Text(
                        'Visualizar carrinho',
                      ),
                    ],
                  ),
                ),
              ),
              
            ],
          )
        );
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
  }

  Future<void> getListItemCurrent() async {
    await SalesController().idSale().then((value) async {
      if (value != 0) {
        await ProductsCartController().listItemCurrent(value).then((products) {
          if (products.isNotEmpty) {
            setState(() {
              globals.isSelectNewItem = true;
            });
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (globals.globalSelectedIndexBotton == 2) {
      getListItemCurrent();
    }
  }

  @override
  Widget build(BuildContext context) {

    const String iconOrder = 'lib/images/iconOrder.svg';
    const String iconMenu = 'lib/images/iconMenu.svg';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        
        globals.isSelectNewItem && globals.globalSelectedIndexBotton == 2 ? 
          selectNewItem() 
          : FutureBuilder(
          future: cartInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data as Widget;
            } else if (snapshot.hasError) {
              return const Text('Erro ao carregar');
            } else {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        
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

              globals.isSaleInTable && globals.userType == 'customer' ?
                const BottomNavigationBarItem(
                  icon: Icon(Icons.room_service_outlined, color: Colors.white),
                  label: 'Garçom',
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
                    globals.isSaleInTable ? {
                      Navigator.of(context).pop(),
                      Navigator.push(context, navigator('table_info'))
                    } : {
                    Navigator.of(context).pop(),
                    Navigator.push(context, navigator('table'))
                  } : {
                  
                    if (globals.isSaleInTable) {
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