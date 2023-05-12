import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/switchListTile.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenEmployees extends StatefulWidget {
  const ScreenEmployees({super.key});

  @override
  State<ScreenEmployees> createState() => _ScreenEmployeesState();
}

class _ScreenEmployeesState extends State<ScreenEmployees> {
  
  var txtNameEmployeeFilter = TextEditingController();
  var txtFunctionFilter = TextEditingController();
  var txtStarFilter = TextEditingController();

  bool isActivateFilter = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Funcionários', 
          context: context,
          withoutIcons: true,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            SectionVisible(
              nameSection: 'Filtros', 
              child: Column(
                children: [
                  TextFieldGeneral(
                    label: 'Nome', 
                    variavel: txtNameEmployeeFilter, 
                    context: context, 
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      validatorString(value!);
                    },
                    ico: Icons.person,
                  ),

                  const SizedBox(height: 20),

                  TextFieldGeneral(
                    label: 'Cargo', 
                    variavel: txtFunctionFilter, 
                    context: context, 
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      validatorString(value!);
                    },
                    ico: Icons.work,
                  ),

                  const SizedBox(height: 20),

                  TextFieldGeneral(
                    label: 'Avaliação', 
                    variavel: txtStarFilter, 
                    context: context, 
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      validatorNumber(value!);
                    },
                    ico: Icons.star,
                  ),

                  const SizedBox(height: 20),

                  StatefulBuilder(
                    builder: ((context, setState) {
                      return SwitchListTileWidget(
                        title: const Text('Ativo', style: TextStyle(fontSize: 20)), 
                        onChanged: (value) {
                          setState(() {
                            isActivateFilter = value;
                          });
                        }, 
                        value: isActivateFilter,
                      );
                    }),
                  ),

                  button(
                    'Filtrar', 
                    MediaQuery.of(context).size.width * 0.8, 
                    70, 
                    Icons.filter_alt_rounded, 
                    () => null
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SectionVisible(
              nameSection: 'Lista de funcionários',
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.person, color: globals.primary, size: 30,),
                      title: const Text('Nome do funcionário'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Cargo'),
                          const Text('Pedidos hoje: 0'),
                          const Text('Avaliação: 0'),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: globals.primary, size: 30,),
                      onTap: () {
                        Navigator.push(context, navigator('employee/info', '1'));
                      },
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, navigator('employee/register')), 
        backgroundColor: globals.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      bottomNavigationBar: const Bottom(),
    );
  }
}