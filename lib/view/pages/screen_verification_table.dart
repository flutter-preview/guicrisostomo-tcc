import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/floatingButton.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:barcode_scan2/barcode_scan2.dart';

class ScreenVerificationTable extends StatefulWidget {
  const ScreenVerificationTable({super.key});

  @override
  State<ScreenVerificationTable> createState() => _ScreenVerificationTableState();
}

class _ScreenVerificationTableState extends State<ScreenVerificationTable> {
  var txtCodeTable = TextEditingController();

  ScanResult? scanResult;

  final _flashOnController = TextEditingController(text: 'Ligar flash');
  final _flashOffController = TextEditingController(text: 'Desligar flash');
  final _cancelController = TextEditingController(text: 'Cancelar');

  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      setState(() => {
        txtCodeTable.text = result.rawContent,
      });
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );

        txtCodeTable.text = scanResult!.rawContent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: appBarWidget(
        pageName: 'Vincular a uma mesa',
        context: context,
        icon: Icons.table_restaurant_rounded,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            imgCenter('lib/images/imgTable.svg'),

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

            button('Ler QR code', 250, 50, Icons.qr_code_scanner, () => {
              _scan(),
              globals.isSaleInTable = !globals.isSaleInTable,
              Navigator.popAndPushNamed(context, 'home')
            }),

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

            TextFieldGeneral(
              label: 'Código da mesa',
              variavel: txtCodeTable,
              context: context,
              keyboardType: TextInputType.text,
              ico: Icons.qr_code_2,
              validator: (value) {
                validatorString(value!);
              },
            ),

            const SizedBox(height: 20),

            button('Vincular', MediaQuery.of(context).size.width - 100, 50, Icons.check, () => globals.isSaleInTable = !globals.isSaleInTable),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      floatingActionButton: floatingButton(context),
    );
  }
}