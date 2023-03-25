import 'package:flutter/material.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/listViewTeam.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
        centerTitle: true,
        backgroundColor: globals.primary,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Aplicativo para controle de vendas para pizzaria',
              style: TextStyle(
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 5,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Objetivo: auxiliar clientes (facilitando na consulta e execução de pedidos), funcionários (facilitando na execução de pedidos e gerenciamento dos pedidos [como dos pedidos de mesa]) e gerentes (auxiliando no gerenciamento da pizzaria [podendo controlar as vendas/pedidos e gerando relatórios])',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10,),

            listViewTeam('Rodrigro Plotze', 'Desenvolvedor', 'lib/images/imgProfessor.png'),
            listViewTeam('Guilherme Crisostomo', 'Desenvolvedor', 'lib/images/imgMe.png'),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}