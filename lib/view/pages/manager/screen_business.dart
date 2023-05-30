import 'package:flutter/material.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenBusiness extends StatefulWidget {
  const ScreenBusiness({super.key});

  @override
  State<ScreenBusiness> createState() => _ScreenBusinessState();
}

class _ScreenBusinessState extends State<ScreenBusiness> {
  final txtName = TextEditingController();
  final txtCnpj = TextEditingController();
  final txtAddress = TextEditingController();
  final txtNumber = TextEditingController();
  final txtComplement = TextEditingController();
  final txtNeighborhood = TextEditingController();
  final txtCity = TextEditingController();
  final txtState = TextEditingController();
  final txtZipCode = TextEditingController();
  final txtPhone = TextEditingController();
  final txtEmail = TextEditingController();
  final txtSite = TextEditingController();
  final txtDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Editar empresa', 
          context: context,
          withoutIcons: true,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFieldGeneral(
              label: 'Nome',
              variavel: txtName,
              validator: (value) {
                return validatorString(value!);
              },
              ico: Icons.business, 
              context: context,
              keyboardType: TextInputType.name,
            ),

            const SizedBox(height: 20),

            TextFieldGeneral(
              label: 'Descrição',
              variavel: txtDescription,
              validator: (value) {
                return validatorString(value!);
              },
              ico: Icons.description, 
              context: context,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            TextFieldGeneral(
              label: 'Telefone',
              variavel: txtPhone,
              validator: (value) {
                return validatorString(value!);
              },
              ico: Icons.phone, 
              context: context,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 10),

            SectionVisible(
              nameSection: 'Lista de telefones', 
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          title: const Text('Telefone'),
                          trailing: const Icon(Icons.delete, size: 20),
                          onTap: () => {},
                        ),
                      );
                    },
                  ),
                ]
              ),
            ),

            const SizedBox(height: 20),

            TextFieldGeneral(
              label: 'CNPJ',
              variavel: txtCnpj,
              validator: (value) {
                return validatorString(value!);
              },
              ico: Icons.numbers, 
              context: context,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            TextFieldGeneral(
              label: 'Endereço',
              variavel: txtAddress,
              validator: (value) {
                return validatorString(value!);
              },
              ico: Icons.location_on, 
              context: context,
              keyboardType: TextInputType.streetAddress,
            ),

            const SizedBox(height: 20),

            TextFieldGeneral(
              label: 'Número',
              variavel: txtNumber,
              validator: (value) {
                return validatorString(value!);
              },
              ico: Icons.location_on, 
              context: context,
              keyboardType: TextInputType.streetAddress,
            ),

            const SizedBox(height: 20),

            TextFieldGeneral(
              label: 'Bairro',
              variavel: txtNeighborhood,
              validator: (value) {
                return validatorString(value!);
              },
              ico: Icons.location_on, 
              context: context,
              keyboardType: TextInputType.streetAddress,
            ),

            const SizedBox(height: 20),

            TextFieldGeneral(
              label: 'Cidade',
              variavel: txtCity,
              validator: (value) {
                return validatorString(value!);
              },
              ico: Icons.location_city, 
              context: context,
              keyboardType: TextInputType.streetAddress,
            ),

            const SizedBox(height: 20),

            TextFieldGeneral(
              label: 'Estado',
              variavel: txtState,
              validator: (value) {
                return validatorString(value!);
              },
              ico: Icons.location_city, 
              context: context,
              keyboardType: TextInputType.streetAddress,
            ),

            const SizedBox(height: 20),

            button('Salvar', 170, 70, Icons.save, () {
              Navigator.pop(context);
            })
          ]
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}