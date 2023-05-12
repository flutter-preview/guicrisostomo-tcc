import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc/controller/postgres/Lists/productsCart.dart';
import 'package:tcc/controller/postgres/Lists/sales.dart';
import 'package:tcc/main.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/controller/postgres/Lists/table.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/imageMainScreens.dart';
import 'package:tcc/view/widget/snackBars.dart';
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
      await BarcodeScanner.scan(
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
      ).then((value) {
        setState(() {
          txtCodeTable.text = value.rawContent;
        });
      });
      
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'O usuário não concedeu acesso a câmera!'
              : 'Erro: $e',
        );

        txtCodeTable.text = scanResult!.rawContent;
      });
    }
  }

  Future<void> verifyCodeTable(String code) async {
    await TablesController().verifyCode(code).then((tableNumber) async {
      if (tableNumber != 0) {

        Navigator.pop(context);
        Navigator.push(context, navigator('waiter'));

        await SalesController().idSale().then((idOrder) async {
          await ProductsCartController().listItemCurrent(idOrder).then((value) async {
            if (value.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Mesa encontrada!'),
                  content: const Text('Deseja vincular os itens do carrinho a mesa ?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Não'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        int newIdOrder = 0;

                        globals.numberTable = tableNumber;

                        await SalesController().idSale().then((value) {
                          setState(() {
                            newIdOrder = value;
                          });
                        });

                        await ProductsCartController().updateAllItemsIdOrder(idOrder, newIdOrder);
                        
                      },
                      child: const Text('Sim'),
                    ),
                  ],
                ),
              );
            }
          }).then((value) async {
            globals.numberTable = tableNumber;
            await SalesController().idSale();
          });
        });

      } else {
        error(context, 'Mesa não encontrada!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Vincular a uma mesa',
          context: context,
          icon: Icons.table_restaurant_rounded,
        ),
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

            button('Ler QR code', 250, 50, Icons.qr_code_scanner, () async {
              await _scan().then((value) async {

                (txtCodeTable.text != 'O usuário não concedeu acesso a câmera!' && txtCodeTable.text.isNotEmpty && !txtCodeTable.text.startsWith('Erro')) ?
                await verifyCodeTable(txtCodeTable.text)
                : error(context, txtCodeTable.text);
              });

              
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
                return validatorString(value!);
              },
            ),

            const SizedBox(height: 20),

            button('Vincular', MediaQuery.of(context).size.width - 100, 50, Icons.check, () async {
              await verifyCodeTable(txtCodeTable.text);
            }),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
      
    );
  }
}