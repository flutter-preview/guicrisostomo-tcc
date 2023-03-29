import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/button.dart';

class ScreenSmartphoneEmployee extends StatefulWidget {
  final String? id;
  const ScreenSmartphoneEmployee({
    super.key,
    required this.id,
  });

  @override
  State<ScreenSmartphoneEmployee> createState() => _ScreenSmartphoneEmployeeState();
}

class _ScreenSmartphoneEmployeeState extends State<ScreenSmartphoneEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Smartphones do funcionário', 
        context: context,
        withoutIcons: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Smartphones do funcionário ${widget.id}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            button('Avançar', 150, 70, Icons.arrow_forward_ios, () {
              Navigator.pop(context);
              Navigator.push(
                context,
                navigator('employee/work_time', widget.id),
              );
            }, false),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: const Text('Smartphone'),
                    subtitle: const Text('Modelo: Samsung Galaxy S20\nIMEI: 123456789012345\nNúmero: (11) 99999-9999'),
                    leading: Icon(Icons.smartphone, size: 40, color: globals.primary),
                    trailing: ElevatedButton(
                      child: Icon(Icons.delete, size: 20, color: Colors.white,),
                      onPressed: () => null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(2),
                        backgroundColor: globals.primary,
                        shape: const CircleBorder(),
                      ),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        navigator('smartphone'),
                      )
                    },
                  ),
                );
              }
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            navigator('smartphone'),
          )
        },
        child: const Icon(Icons.add),
        backgroundColor: globals.primary,
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}