// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
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
    await SalesController.instance.idSale().then((value) async {
      idSale = value;
      await ProductsCartController.instance.list(idSale).then((value) {
        list = value;
      }).catchError((onError) {
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getList().then((value) {
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Carrinho',
          context: context,
          withoutIcons: true,
        ),
      ),

      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            fillOverscroll: true,
            child: (idSale != 0) ? (list.isNotEmpty) ?
              ProductsCart(product: list) :
              const Center(child: Text('Carrinho vazio'))
            : const Center(child: CircularProgressIndicator()),
              
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
              list.isNotEmpty ? 170 : MediaQuery.of(context).size.width - 40,
              0,
              Icons.arrow_back_ios,
              () => {
                Navigator.pop(context)
              },
            ),

            
            if (list.isNotEmpty)
              button(
                'Finalizar',
                170,
                0,
                Icons.arrow_forward_ios,
                () {
                  Navigator.pop(context);
                  GoRouter.of(context).go('/finalize_order_customer');
                },
                false,
              )
          ],
        ),
      ),

      floatingActionButton: (list.isNotEmpty) ? Container(
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
                        await ProductsCartController.instance.clearCart(idSale),
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
      ) : null,
    );
  }
}