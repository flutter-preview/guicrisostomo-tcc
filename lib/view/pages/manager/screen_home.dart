import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/customer/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/switchListTile.dart';

class ScreenHomeManager extends StatefulWidget {
  const ScreenHomeManager({super.key});

  @override
  State<ScreenHomeManager> createState() => _ScreenHomeManagerState();
}

class _ScreenHomeManagerState extends State<ScreenHomeManager> {
  String lucro = '0,00';
  bool valueShowMoney = false;
  bool valueOpen = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      globals.userType = 'manager';
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            appBarWidget(
              pageName: 'Home',
              context: context,
              icon: Icons.home,
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
                      'R\$ $lucro' : 'R\$ *,**',

                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SwitchListTileWidget(
                    title: const Text(
                      'Visualizar lucro ?',
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
                  ),

                  const SizedBox(height: 20),

                  SwitchListTileWidget(
                    title: Text(
                      'Aberto ?',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: valueOpen,
                    onChanged: (value) {
                      setState(() {
                        valueOpen = !valueOpen;
                        value = valueOpen;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const BottomCustomer(),
    );
  }
}