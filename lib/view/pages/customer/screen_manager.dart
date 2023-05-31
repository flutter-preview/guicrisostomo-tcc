import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';

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
                  GoRouter.of(context).pushNamed('/manager/products')
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