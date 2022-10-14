import 'package:flutter/material.dart';
import 'package:tcc/model/bottonNavigationCustomer.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(50, 62, 64, 1),
      ),

      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Projeto de TCC',
              style: TextStyle(
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 10,),

            listViewStuff('Rodrigro Plotze', 'Desenvolvedor'),
            listViewStuff('Guilherme Crisostomo', 'Desenvolvedor'),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }

  listViewStuff(name, func) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),

        title: Text(
          name,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),

        subtitle: Text(
          func,
        ),

      ),
    );
  }
}