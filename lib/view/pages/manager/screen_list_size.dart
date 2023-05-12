import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/standardListDropDown.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenListSize extends StatefulWidget {
  const ScreenListSize({super.key});

  @override
  State<ScreenListSize> createState() => _ScreenListSizeState();
}

class _ScreenListSizeState extends State<ScreenListSize> {
  var txtEditSize = TextEditingController();
  var txtSizeAdd = TextEditingController();

  String txtCategorySizeAdd = 'Pizza';
  List<DropDownList> itemCategory= [
    DropDownList(
      icon: Icons.local_pizza, 
      name: 'Pizza'
    ),
    DropDownList(
      icon: Icons.dinner_dining, 
      name: 'Comida'
    ),

    DropDownList(
      name: 'Lanche', 
      icon: Icons.fastfood,
    ),

    DropDownList(
      icon: Icons.local_drink, 
      name: 'Bebida'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Tamanhos de Produtos', 
          context: context,
          icon: Icons.category,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: Icon(Icons.category, size: 40, color: globals.primary),
                title: Text('Tamanho ${index + 1}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: globals.primary,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10)
                      ),
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Excluir'),
                              content: const Text('Deseja realmente excluir este tamanho?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, 
                                  child: const Text('Não')
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, 
                                  child: const Text('Sim')
                                ),
                              ],
                            );
                          }
                        );
                      },
                      child: Icon(Icons.delete, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 10),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: globals.primary,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10)
                      ),

                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Editar tamanho'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFieldGeneral(
                                    label: 'Nome', 
                                    variavel: txtEditSize, 
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
                      child: Icon(Icons.edit, color: Colors.white, size: 20),
                    ),

                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    navigator('size/info', index+1)
                  );
                },
              ),
            );
          },
          itemCount: 10,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context, 
            builder: (context) {
              return AlertDialog(
                title: const Text('Adicionar tamanho'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFieldGeneral(
                      label: 'Nome', 
                      variavel: txtEditSize, 
                      context: context, 
                      keyboardType: TextInputType.text,
                      ico: Icons.category,
                    ),

                    const SizedBox(height: 10),

                    DropDown(
                      text: 'Categoria', 
                      itemsDropDownButton: itemCategory, 
                      variavel: txtCategorySizeAdd, 
                      callback: (value) {

                      }
                    ),
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
        backgroundColor: globals.primary
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}