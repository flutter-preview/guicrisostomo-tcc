

import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenCategories extends StatefulWidget {
  const ScreenCategories({super.key});

  @override
  State<ScreenCategories> createState() => _ScreenCategoriesState();
}

class _ScreenCategoriesState extends State<ScreenCategories> {
  var txtCategoryAdd = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Categorias de Produtos', 
          context: context,
          withoutIcons: true,
        )
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: Icon(Icons.category, size: 40, color: globals.primary),
                    title: Text('Categoria $index'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        navigator('categories/category', index+1)
                      );
                    },
                  ),
                );
              },
              itemCount: 10
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: globals.primary,
        onPressed: () {
          showDialog(
            context: context, 
            builder: (context) {
              return AlertDialog(
                title: const Text('Adicionar categoria'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFieldGeneral(
                      label: 'Nome', 
                      variavel: txtCategoryAdd, 
                      context: context, 
                      keyboardType: TextInputType.text,
                      ico: Icons.category,
                    )
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text('Cancelar')
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text('Adicionar')
                  ),
                ],
              );
            }
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const Bottom(),
    );
  }
}