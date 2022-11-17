import 'package:flutter/material.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/floatingButton.dart';

class ScreenAddItem extends StatefulWidget {
  const ScreenAddItem({super.key});

  @override
  State<ScreenAddItem> createState() => _ScreenAddItemState();
}

class _ScreenAddItemState extends State<ScreenAddItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar item'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
      ),

      body: Column(
        children: [

        ],
      ),
      
      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}