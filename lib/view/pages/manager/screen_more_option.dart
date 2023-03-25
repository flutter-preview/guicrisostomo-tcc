import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';

class ScreenMoreOption extends StatefulWidget {
  const ScreenMoreOption({super.key});

  @override
  State<ScreenMoreOption> createState() => _ScreenMoreOptionState();
}

class _ScreenMoreOptionState extends State<ScreenMoreOption> {
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
                title: const Text('Funcionário'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.push(
                    context,
                    navigator('manager/employees'),
                  )
                },
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Categoria'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.push(
                    context,
                    navigator('manager/categories'),
                  )
                },
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Promoção'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.push(
                    context,
                    navigator('manager/promotions'),
                  )
                },
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Cliente'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.push(
                    context,
                    navigator('manager/customers'),
                  )
                },
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Fornecedor'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.push(
                    context,
                    navigator('manager/suppliers'),
                  )
                },
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Permissões de acesso'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.push(
                    context,
                    navigator('manager/permissions'),
                  )
                },
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Dados da empresa'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.push(
                    context,
                    navigator('manager/products'),
                  )
                },
              ),
            ),
            
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Dados do usuário'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.push(
                    context,
                    navigator('manager/products'),
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