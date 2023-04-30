// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/ProductsCart.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/listCart.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenCart extends StatefulWidget {
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {

  List<ProductsCartList> list = [];
  int idSale = 0;
  
  double get largura => MediaQuery.of(context).size.width;
  Future<void> getList() async {
    await SalesController().idSale().then((value) async {
      idSale = value;
      await ProductsCartController().list(idSale).then((value) {
        list = value;
      });
    });
    print('a');
  }


  @override
  Widget build(BuildContext context) {

    print('a');
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Carrinho',
        context: context,
        withoutIcons: true,
      ),

      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            fillOverscroll: true,
            child: FutureBuilder(
              future: getList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (list.isNotEmpty) {
                    return ProductsCart(product: list);
                  } else {
                    return const Text('Carrinho vazio');
                  }
                } else {
                  return Expanded(child: const Center(child: CircularProgressIndicator()));
                }
              }
            ),
          ),
        ],
      ),

      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            button(
              'Voltar',
              170,
              0,
              Icons.arrow_back_ios,
              () => {
                Navigator.pop(context)
              },
            ),
      
            button(
              'Finalizar',
              170,
              0,
              Icons.arrow_forward_ios,
              () => {
                Navigator.push(context, navigator('finalize_order_customer'))
              },
              false,
            )
          ],
        ),
      ),

      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: () async => {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Deseja limpar o carrinho?'),
                  actions: [
                    TextButton(
                      onPressed: () => {
                        Navigator.pop(context)
                      },
                      child: const Text('Não'),
                    ),
                    TextButton(
                      onPressed: () async => {
                        await ProductsCartController().clearCart(idSale),
                        Navigator.pop(context),
                        setState(() {}),
                      },
                      child: const Text('Sim'),
                    ),
                  ],
                );
              }
            )
          },
          backgroundColor: globals.primary,
          child: const Icon(Icons.remove_shopping_cart),
        ),
      ),
    );
  }
}