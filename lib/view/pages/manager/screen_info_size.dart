import 'package:flutter/material.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenInfoSize extends StatefulWidget {
  final String id;
  const ScreenInfoSize({
    super.key,
    required this.id
  });

  @override
  State<ScreenInfoSize> createState() => _ScreenInfoSizeState();
}

class _ScreenInfoSizeState extends State<ScreenInfoSize> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Tamanho ${widget.id}', 
          context: context,
          withoutIcons: true,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categoria ${widget.id}', style: TextStyle(fontSize: 20)),
                Icon(Icons.category, size: 20, color: globals.primary),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Produtos cadastrados ${widget.id}', style: const TextStyle(fontSize: 20)),
                Icon(Icons.fastfood, size: 20, color: globals.primary),
              ],
            ),

            const SizedBox(height: 10),

            SectionVisible(
              nameSection: 'Lista de produtos cadastrados', 
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: const Icon(Icons.fastfood, size: 40, color: Colors.green),
                      title: Text('Produto ${index + 1}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit, color: globals.primary),
                          const SizedBox(width: 10),
                          Icon(Icons.delete, color: globals.primary),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 10, 
                shrinkWrap: true
              ),
            ),
            
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}