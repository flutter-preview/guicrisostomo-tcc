import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/controller/postgres/Lists/table.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/model/Sales.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';
import 'package:tcc/view/widget/listCart.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/snackBars.dart';

class ScreenCallWaiter extends StatefulWidget {
  const ScreenCallWaiter({super.key});

  @override
  State<ScreenCallWaiter> createState() => _ScreenCallWaiterState();
}

class _ScreenCallWaiterState extends State<ScreenCallWaiter> {
  List<ProductsCartList> list = [];
  Sales? listSale = Sales(
    id: 0,
    date: DateTime.now(),
    total: 0,
    uid: '0',
    status: '0',
    cnpj: globals.businessId,
  );
  int idSale = 0;

  Future<void> getInfoTable() async {
    await SalesController.instance.listSalesOnDemand().then((value) {
      if (value == null) {
        // SalesController.instance.add().then((value) => getInfoTable());
      } else {
        setState(() {
          idSale = value.id;
          listSale = value;
          globals.idSaleSelected = value.id;
        });
      }
    }).then((value) {
      ProductsCartController.instance.listTable(globals.numberTable ?? 0).then((value) {
        setState(() {
          list = value;
        });
      });
    });
  }

  Future<num> getTotalTable() async {
    return await SalesController.instance.getTotalTable().then((value) {
      return value[0];
    });
  }

  @override
  void initState() {
    super.initState();

    if (globals.idSaleSelected != null) {
      getInfoTable().then((value) async {
        await getTotalTable().then((value) {
          setState(() {
            listSale!.total = value;
          });
        });
      });
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Mesa',
          context: context,
          icon: Icons.room_service,
        ),
      ),

      body: globals.idSaleSelected != null ? SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            imgCenter('lib/images/imgTable.svg'),

            if (globals.userType == 'customer')
              Column(
                children: [
                  const SizedBox(height: 30),

                  button('Chamar garçom', 300, 50, Icons.person, () {
                    TablesController.instance.callWaiter(context, idSale);
                  }),
                ],
              ),

            const SizedBox(height: 30),

            button('Desvincular da mesa', 300, 50, Icons.close, () async {
              GoRouter.of(context).push('/loading');
              
              await SalesController.instance.removeRelationUserOrder(idSale).then((value) async {
                setState(() {
                  globals.numberTable = null;
                  globals.idSaleSelected = null;
                });
                await SalesController.instance.idSale().then((value) {
                  setState(() {
                    idSale = value;
                  });
                });

                
                success(context, 'Desvinculado com sucesso');

                await LoginController.instance.redirectUser(context);
              });
            }),

            const SizedBox(height: 20),

            button('Fazer novo pedido', 300, 50, Icons.add_shopping_cart_rounded, () {
              
              GoRouter.of(context).go('/products');
            }),

            const SizedBox(height: 30),

            SectionVisible(
              nameSection: 'Dados da mesa',
              isShowPart: true,
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(Icons.table_restaurant, color: globals.primary),

                      const SizedBox(width: 10),

                      Text(
                        'Mesa: ${globals.numberTable}',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Icon(Icons.attach_money, color: globals.primary),

                      const SizedBox(width: 10),

                      Text(
                        'Total: R\$ ${listSale!.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ),

            const SizedBox(height: 10),

            SectionVisible(
              nameSection: 'Itens pedidos',
              isShowPart: list.isNotEmpty,
              child: ProductsCart(
                product: list,
                isShowButtonDelete: false,
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ) : const Center(child: CircularProgressIndicator()),

      bottomNavigationBar: const Bottom(),

      bottomSheet: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
          [Padding(
            padding: const EdgeInsets.all(20),
            child: button('Fechar mesa', 300, 50, Icons.check, () {
              SalesController.instance.finalizeSale();
              
              GoRouter.of(context).go('/home');
            }),
          ),
        ],
      ),
    );
  }
}