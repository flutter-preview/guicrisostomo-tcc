import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/controller/auth/auth.dart';
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
                  GoRouter.of(context).go('/employees'),
                },
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Categoria'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  GoRouter.of(context).go('/categories'),
                },
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Tamanho'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  GoRouter.of(context).go('/size'),
                },
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Dados da empresa'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  GoRouter.of(context).go('/business'),
                },
              ),
            ),
            
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Dados do usuário'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  GoRouter.of(context).go('/profile/edit_datas', extra: {}),
                },
              ),
            ),
            
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: const Text('Sobre'),

                trailing: const Icon(Icons.arrow_right, size: 20),

                onTap: () => {
                  GoRouter.of(context).go('/profile/about'),
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