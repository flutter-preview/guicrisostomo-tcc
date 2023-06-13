import 'package:flutter/material.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/model/ProductItemList.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/listCart.dart';
import 'package:tcc/view/widget/productItem.dart';
import 'package:tcc/view/widget/sectionVisible.dart';

class ScreenInfoTable extends StatefulWidget {
  final Object? arguments;
  const ScreenInfoTable({
    super.key,
    this.arguments,
  });

  @override
  State<ScreenInfoTable> createState() => _ScreenInfoTableState();
}

class _ScreenInfoTableState extends State<ScreenInfoTable> {
  // Future<void> getInfoTable() async {
  //   SalesController.instance.(widget.arguments);
  // }

  Future<List<ProductsCartList>> getItemsProduct() async {
    return await ProductsCartController.instance.listTable(widget.arguments as int);
  }
  
  @override
  Widget build(BuildContext context) {
    print(widget.arguments as int);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Informações da mesa ${widget.arguments as int}',
          context: context,
          withoutIcons: true,
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Informações importantes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.room_service, color: globals.primary),
                        const SizedBox(width: 10),
                        const Text(
                          'Garçom: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.people, color: globals.primary),
                        const SizedBox(width: 10),
                        const Text(
                          'Clientes: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.timer, color: globals.primary),
                        const SizedBox(width: 10),
                        const Text(
                          'Tempo de espera do pedido atual: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.timer, color: globals.primary),
                        const SizedBox(width: 10),
                        const Text(
                          'Chegada: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.attach_money_outlined, color: globals.primary),
                        const SizedBox(width: 10),
                        const Text(
                          'Valor: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    SectionVisible(
                      nameSection: 'Itens pedidos',
                      isShowPart: true,
                      child: FutureBuilder<List<ProductsCartList>>(
                        future: getItemsProduct(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                            return ProductsCart(product: snapshot.data!);
                          } else if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const Center(
                              child: Text('Erro ao carregar os itens'),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}