import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenListPromotions extends StatefulWidget {
  const ScreenListPromotions({super.key});

  @override
  State<ScreenListPromotions> createState() => _ScreenListPromotionsState();
}

class _ScreenListPromotionsState extends State<ScreenListPromotions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Promoções', 
        context: context,
        withoutIcons: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            SectionVisible(
              nameSection: 'Lista de Promoções', 
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Promoção $index'),
                      leading: Icon(Icons.local_offer, color: globals.primary),
                      subtitle: Text('Descrição da promoção $index'),
                      trailing: Icon(Icons.arrow_forward_ios, color: globals.primary),
                    ),
                  );
                },
              )
            ),

            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ]
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, navigator('screen_add_promotion'));
        }, 
        backgroundColor: globals.primary,
        child: Icon(Icons.add)
      ),
      bottomNavigationBar: const Bottom(),
    );
  }
}