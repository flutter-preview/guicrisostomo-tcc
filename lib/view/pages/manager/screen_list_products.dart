import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/productItem.dart';
import 'package:tcc/view/widget/sectionVisible.dart';

class ScreenListProducts extends StatefulWidget {
  const ScreenListProducts({super.key});

  @override
  State<ScreenListProducts> createState() => _ScreenListProductsState();
}

class _ScreenListProductsState extends State<ScreenListProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Produtos',
        context: context,
        icon: Icons.restaurant_menu,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Lista de produtos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Aqui você pode ver todos os produtos cadastrados no sistema.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            button(
              'Cadastrar novo produto',
              MediaQuery.of(context).size.width - 100,
              70,
              Icons.add,
              () => Navigator.push(context, navigator('manager/products'))
            ),

            const SizedBox(height: 20),
            
            SectionVisible(
              nameSection: 'Produtos',
              isShowPart: true,
              child: const ProductItem({}),
            ),
            
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}