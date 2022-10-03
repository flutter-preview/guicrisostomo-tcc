import 'package:flutter/material.dart';
import 'package:tcc/modal/bottonNavigationCustomer.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(50, 62, 64, 1),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Projeto de TCC',
              style: TextStyle(
                fontSize: 24,
              ),
            ),

            SizedBox(height: 10,),

            listViewStuff('Rodrigro Plotze', 'Desenvolvedor'),
            listViewStuff('Guilherme Crisostomo', 'Desenvolvedor'),
          ],
        ),
      ),

      bottomNavigationBar: Bottom(),
    );
  }

  listViewStuff(name, func) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(10),

        title: Text(
          name,
          style: TextStyle(
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