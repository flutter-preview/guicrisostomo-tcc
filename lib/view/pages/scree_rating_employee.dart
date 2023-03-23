import 'package:flutter/material.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/customer/bottonNavigationCustomer.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenRatingEmployee extends StatefulWidget {
  final String? idEmployee;
  const ScreenRatingEmployee({
    super.key,
    required this.idEmployee,
  });

  @override
  State<ScreenRatingEmployee> createState() => _ScreenRatingEmployeeState();
}

class _ScreenRatingEmployeeState extends State<ScreenRatingEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Avaliações - ${widget.idEmployee}',
        context: context,
        withoutIcons: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Avaliações',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Nome do cliente'),
                subtitle: const Text('Descrição'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    const Text(
                      '4.5',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 5,),

                    Icon(Icons.star, color: globals.primary, size: 30,),
                    
                  ],
                )
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: const BottomCustomer(),
    );
  }
}