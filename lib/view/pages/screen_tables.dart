

import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/switchListTile.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenTables extends StatefulWidget {
  const ScreenTables({super.key});

  @override
  State<ScreenTables> createState() => _ScreenTablesState();
}

class _ScreenTablesState extends State<ScreenTables> {
  bool valueShowMoney = false;
  double lucro = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (globals.userType == 'manager') ? PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: Column(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBarWidget(
                pageName: 'Mesas',
                context: context,
                icon: Icons.table_restaurant,
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    globals.primaryBlack,
                    globals.primary.withOpacity(0.9),
                  ]
                ),
              ),
              child: Column(
                children: [
                  Text(
                    (valueShowMoney == true) ?
                      'Dinheiro a receber das mesas: R\$ $lucro' : 'Dinheiro a receber das mesas: R\$ *,**',

                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SwitchListTileWidget(
                    title: const Text(
                      'Visualizar lucro do dia ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: valueShowMoney,
                    onChanged: (value) {
                      setState(() {
                        valueShowMoney = !valueShowMoney;
                        value = valueShowMoney;
                      });
                    },
                    icon: Icon(
                      (valueShowMoney == true) ?
                        Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ) : PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Mesas',
          context: context,
          icon: Icons.table_restaurant,
        ),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              'Selecione uma mesa para ver as informações',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text('Mesa ${index + 1}'),
                    trailing: const Icon(Icons.arrow_right, size: 20),
                    onTap: () => {
                      Navigator.push(
                        context,
                        navigator('table/info', index + 1),
                      )
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: const Bottom(),
    );
  }
}