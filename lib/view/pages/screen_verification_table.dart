import 'package:flutter/material.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';
import 'package:tcc/view/widget/textFieldNumberGeneral.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenVerificationTable extends StatefulWidget {
  const ScreenVerificationTable({super.key});

  @override
  State<ScreenVerificationTable> createState() => _ScreenVerificationTableState();
}

class _ScreenVerificationTableState extends State<ScreenVerificationTable> {

  var txtCodeTable = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [
            imgCenter('lib/images/imgTable.svg'),

            const SizedBox(height: 10),

            const Text(
              'Vincular a uma mesa',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Vincule a uma mesa, utilizando o código da mesa clicando no botão abaixo para ler o QR code.',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 10),

            button('Ler QR code', 250, 50, Icons.qr_code_scanner, () => null),

            const SizedBox(height: 20),

            const Text(
              'Se preferir, digite o código da mesa abaixo.',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 10),

            textFieldNumberGeneral('Código da mesa', txtCodeTable, context),

            const SizedBox(height: 20),

            button('Vincular', MediaQuery.of(context).size.width - 100, 50, Icons.check, () => globals.isSaleInTable = !globals.isSaleInTable),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}