import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenInfoPromotion extends StatefulWidget {
  final String id;
  const ScreenInfoPromotion({
    super.key,
    required this.id
  });

  @override
  State<ScreenInfoPromotion> createState() => _ScreenInfoPromotionState();
}

class _ScreenInfoPromotionState extends State<ScreenInfoPromotion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Promoção ${widget.id}', 
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
                Text('Categoria ${widget.id}', style: const TextStyle(fontSize: 20)),
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
                      subtitle: const Text('R\$ 10,00'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.green),
                    ),
                  );
                },
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Produtos em promoção ${widget.id}', style: const TextStyle(fontSize: 20)),
                Icon(Icons.fastfood, size: 20, color: globals.primary),
              ],
            ),

            const SizedBox(height: 10),

            SectionVisible(
              nameSection: 'Lista de produtos em promoção', 
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: const Icon(Icons.fastfood, size: 40, color: Colors.green),
                      title: Text('Produto ${index + 1}'),
                      subtitle: const Text('R\$ 10,00'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 20, color: globals.primary),
                    ),
                  );
                },
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Produtos fora de promoção ${widget.id}', style: const TextStyle(fontSize: 20)),
                Icon(Icons.fastfood, size: 20, color: globals.primary),
              ],
            ),

            const SizedBox(height: 10),

            SectionVisible(
              nameSection: 'Lista de produtos fora de promoção', 
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: const Icon(Icons.fastfood, size: 40, color: Colors.green),
                      title: Text('Produto ${index + 1}'),
                      subtitle: const Text('R\$ 10,00'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 20, color: globals.primary),
                    ),
                  );
                },
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Produtos com promoção expirada ${widget.id}', style: const TextStyle(fontSize: 20)),
                Icon(Icons.fastfood, size: 20, color: globals.primary),
              ],
            ),
          ],
        ),
      ), 

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push('/promotion/create', extra: widget.id);
        },
        backgroundColor: globals.primary,
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: const Bottom(),
    
    );
  }
}