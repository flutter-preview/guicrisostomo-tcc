import 'package:flutter/material.dart';
import 'package:tcc/widget/floatingButton.dart';

import '../widget/bottonNavigationCustomer.dart';

class ScreenOrder extends StatefulWidget {
  const ScreenOrder({super.key});

  @override
  State<ScreenOrder> createState() => _ScreenOrderState();
}

class _ScreenOrderState extends State<ScreenOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            listViewOrder(),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}

listViewOrder() {
  return ListView.builder(
    itemCount: 10,
    shrinkWrap:true,
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) {
    return Card(
      color: const Color.fromRGBO(50, 62, 64, 1),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        title: const Text(
          'Data: 01/12/2022 às 21:35',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Total: R\$ 52,00',
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            Text(
              'Tipo: entrega',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ]
        ),

        //EVENTO DE CLIQUE
        onTap: () {
          Navigator.pushNamed(
            context,
            'order/info',

            //Passagem de parâmetro
            arguments: index,

          );
        },
        
      ),
    );
      
    }
  );
}