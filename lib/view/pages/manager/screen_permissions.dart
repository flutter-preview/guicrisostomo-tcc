import 'package:flutter/material.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/switchListTile.dart';

class ScreenPermissions extends StatefulWidget {
  final String? id;
  const ScreenPermissions({
    super.key,
    required this.id,
  });

  @override
  State<ScreenPermissions> createState() => _ScreenPermissionsState();
}

class _ScreenPermissionsState extends State<ScreenPermissions> {
  bool hasPermissionOpenCashRegister = false;
  bool hasPermissionCloseTable = false;
  bool hasPermissionCloseOrder = false;
  bool hasPermissionRegisterProduct = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Permissões',
        context: context,
        withoutIcons: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Permissões - funcionário ${widget.id}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Aqui você pode ver as permissões do funcionário ${widget.id}.',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            SwitchListTileWidget(
              title: const Text(
                'Abrir/fechar caixa',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  hasPermissionOpenCashRegister = value;
                });
              },
              value: hasPermissionOpenCashRegister,
            ),

            const SizedBox(height: 20),

            SwitchListTileWidget(
              title: const Text(
                'Fechar mesa',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  hasPermissionCloseTable = value;
                });
              },
              value: hasPermissionCloseTable,
            ),

            const SizedBox(height: 20),

            SwitchListTileWidget(
              title: const Text(
                'Fechar conta',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  hasPermissionCloseOrder = value;
                });
              },
              value: hasPermissionCloseOrder,
            ),

            const SizedBox(height: 20),

            SwitchListTileWidget(
              title: const Text(
                'Cadastrar produto',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  hasPermissionRegisterProduct = value;
                });
              },
              value: hasPermissionRegisterProduct,
            ),

            const SizedBox(height: 20),

            button(
              'Salvar',
              MediaQuery.of(context).size.width * 0.8,
              70,
              Icons.save,
              () => null
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}