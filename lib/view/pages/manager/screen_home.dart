import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/customer/bottonNavigationCustomer.dart';

class ScreenHomeManager extends StatefulWidget {
  const ScreenHomeManager({super.key});

  @override
  State<ScreenHomeManager> createState() => _ScreenHomeManagerState();
}

class _ScreenHomeManagerState extends State<ScreenHomeManager> {
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
                  const Text(
                    'R\$ 0,00',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SwitchListTile(
                    value: true,
                    onChanged: (value) {},
                    title: Row(
                      children: [
                        const Icon(Icons.visibility, color: Colors.white),
                        const SizedBox(width: 10),
                        const Text(
                          'Visualizar valor',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ),

                  SwitchListTile(
                    value: true,
                    onChanged: (value) {},
                    title: Row(
                      children: [
                        const Icon(Icons.store, color: Colors.white),
                        const SizedBox(width: 10),
                        const Text(
                          'Loja aberta',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
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