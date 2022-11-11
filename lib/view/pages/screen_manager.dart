import 'package:flutter/material.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Cadastrar produto'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    'manager/products',
                  )
                },
              ),
            ),

            const SizedBox(height: 10,),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Cadastrar pedido'),
                subtitle: const Text('Opção criada apenas fins de avaliação da disciplina de programação de dispositivos móveis, não sendo parte da versão final.'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.pushNamed(
                    context,
                    'manager/order',
                  )
                },
              ),
            )
          ]
        )
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}