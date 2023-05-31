import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenInfoCategory extends StatefulWidget {
  final String id;
  const ScreenInfoCategory({
    super.key,
    required this.id,
  });

  @override
  State<ScreenInfoCategory> createState() => _ScreenInfoCategoryState();
}

class _ScreenInfoCategoryState extends State<ScreenInfoCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Categoria ${widget.id}', 
          context: context,
          withoutIcons: true,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              'Informações da categoria',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Icon(Icons.restaurant_menu, size: 30, color: globals.primary),
                const SizedBox(width: 10),
                const Text(
                  'Produtos cadastrados na categoria: 10',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.category, size: 30, color: globals.primary),
                const SizedBox(width: 10),
                const Text(
                  'Tamanhos cadastrados: 10',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: Icon(Icons.category, size: 40, color: globals.primary),
                    title: Text('Tamanho $index'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      GoRouter.of(context).pushNamed('/size/info', extra: index + 1);
                    },
                  ),
                );
              },
              itemCount: 10
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}