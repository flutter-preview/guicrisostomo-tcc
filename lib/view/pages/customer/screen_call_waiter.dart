import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/productsCart.dart';
import 'package:tcc/controller/firebase/sales.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';
import 'package:tcc/view/widget/listCart.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/sectionVisible.dart';

class ScreenCallWaiter extends StatefulWidget {
  const ScreenCallWaiter(Object arguments, {super.key});

  @override
  State<ScreenCallWaiter> createState() => _ScreenCallWaiterState();
}

class _ScreenCallWaiterState extends State<ScreenCallWaiter> {
  var list;
  var listSale;
  String? idSale;

  void getIdSale() async {
    await SalesController().idSale().then((value){
      setState(() {
        idSale = value;
        list = ProductsCartController().list(idSale);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    list = ProductsCartController().list(idSale);
    listSale = SalesController().listSalesOnDemand();
  }
  
  @override
  Widget build(BuildContext context) {
    if (idSale == null) {
      getIdSale();
    }

    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Mesa',
        context: context,
        icon: Icons.room_service,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            imgCenter('lib/images/imgTable.svg'),

            const SizedBox(height: 30),

            button('Chamar garçom', 300, 50, Icons.person, () => null),

            const SizedBox(height: 20),

            button('Fazer novo pedido', 300, 50, Icons.add_shopping_cart_rounded, () => null),

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

                      const Text(
                        'Mesa: 1',
                        style: TextStyle(
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

                      const Text(
                        'Total: R\$ 0,00',
                        style: TextStyle(
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
              child: ProductsCart(list),
            ),

            const SizedBox(height: 20),

            button('Fechar mesa', 300, 50, Icons.check, () => globals.isSaleInTable = false),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}