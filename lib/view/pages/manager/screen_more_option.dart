import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
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
                    navigator('employees'),
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
                    navigator('categories'),
                  )
                },
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Tamanho'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.push(
                    context,
                    navigator('size'),
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
                    navigator('business'),
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
                    navigator('profile/edit_datas', {}),
                  )
                },
              ),
            ),
            
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Sobre'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  Navigator.push(
                    context,
                    navigator('profile/about'),
                  )
                },
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Sair'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  LoginController().logout(context)
                },
              ),
            ),
          ]
        )
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}