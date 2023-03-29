import 'package:flutter/material.dart';
import 'package:tcc/main.dart';
import 'package:tcc/model/standardListDropDown.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenRegisterEmployee extends StatefulWidget {
  const ScreenRegisterEmployee({super.key});

  @override
  State<ScreenRegisterEmployee> createState() => _ScreenRegisterEmployeeState();
}

class _ScreenRegisterEmployeeState extends State<ScreenRegisterEmployee> {
  var txtNameEmployee = TextEditingController();
  var txtFunction = TextEditingController();
  var txtSalary = TextEditingController();
  var txtPhone = TextEditingController();
  var txtEmail = TextEditingController();

  List<DropDownList> itemsDropDownButton = [
    DropDownList(
      name: 'Gerente',
      icon: Icons.manage_accounts,
    ),
    DropDownList(
      name: 'Caixa',
      icon: Icons.attach_money_sharp,
    ),
    DropDownList(
      name: 'Cozinheiro',
      icon: Icons.restaurant,
    ),
    DropDownList(
      name: 'Atendente', 
      icon: Icons.person,
    ),
    DropDownList(
      name: 'Garçom',
      icon: Icons.local_bar,
    ),
    DropDownList(
      name: 'Entregador', 
      icon: Icons.delivery_dining,
    )
  ];

  String txtDropDownEmployee = 'Gerente';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Registrar funcionário', 
        context: context,
        withoutIcons: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFieldGeneral(
              label: 'Nome', 
              variavel: txtNameEmployee, 
              context: context, 
              keyboardType: TextInputType.name,
              validator: (value) {
                validatorString(value!);
              },
              ico: Icons.person,
            ),

            const SizedBox(height: 20),

            DropDown(
              text: 'Cargo', 
              itemsDropDownButton: itemsDropDownButton, 
              variavel: txtDropDownEmployee, 
              callback: (value) {
                setState(() {
                  txtDropDownEmployee = value;
                });
              },
            ),

            const SizedBox(height: 20),

            TextFieldGeneral(
              label: 'Salário', 
              variavel: txtSalary, 
              context: context, 
              keyboardType: TextInputType.number,
              ico: Icons.monetization_on,
            ),

            const SizedBox(height: 20),

            TextFieldGeneral(
              label: 'Telefone', 
              variavel: txtPhone, 
              context: context, 
              keyboardType: TextInputType.phone,
              validator: (value) {
                validatorPhone(value!);
              },
              ico: Icons.phone,
            ),

            const SizedBox(height: 20),

            TextFieldGeneral(
              label: 'E-mail', 
              variavel: txtEmail, 
              context: context, 
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                validatorEmail(value!);
              },
              ico: Icons.email,
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.bottomRight,
              child: button('Registrar', 
                150, 
                70, 
                Icons.add, 
                () {
                  Navigator.pop(context);
                  Navigator.push(context, navigator('employee/smartphone', '1'));
                }
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}