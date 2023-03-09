import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/customer/partFinalizeOrder.dart';
import 'package:tcc/view/widget/cartInfo.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/view/widget/radioButton.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenFOMain extends StatefulWidget {
  const ScreenFOMain({super.key});

  @override
  State<ScreenFOMain> createState() => _ScreenFOMainState();
}

class _ScreenFOMainState extends State<ScreenFOMain> {
  String groupSaleType = 'Entrega';

  @override
  Widget build(BuildContext context) {
    var txtName = TextEditingController();
    var txtPhone = TextEditingController();
    var maskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####', 
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.eager,
      initialText: txtPhone.text,
    );
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(220),
        child: AppBar(
          title: const Text(
            'Finalizar pedido',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),

          centerTitle: true,
          backgroundColor: Colors.white,

          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: globals.primary,
              image: DecorationImage(
                image: const AssetImage('lib/images/imgPizza.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(globals.primary.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),

            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text(
                    'Dados pessoais - Etapa 1/3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                    
                  SizedBox(height: 5),
                      
                  Text(
                    'Informe seus dados pessoais para finalizar o pedido. Esses dados serão usados para identificar seu pedido e para que você possa acompanhar o status do mesmo.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const PartFinalizeOrder(partUser: 1),

            TextFieldGeneral(
              label: 'Nome',
              variavel: txtName,
              context: context,
              keyboardType: TextInputType.name,
              ico: Icons.person,
              validator: (value) {
                validatorString(value!);
              },
            ),

            const SizedBox(height: 20,),

            TextFieldGeneral(
              label: 'Telefone',
              variavel: txtPhone,
              context: context,
              keyboardType: TextInputType.phone,
              ico: Icons.phone,
              validator: (value) {
                validatorPhone(value!);
              },
              onChanged: (value) => {
                if (value.length <= 14) {
                  txtPhone.value = maskFormatter.updateMask(mask: "(##) ####-#####")
                } else {
                  txtPhone.value = maskFormatter.updateMask(mask: "(##) #####-####")
                }
              },
            ),

            const SizedBox(height: 20,),

            RadioButon(
              valueRadio: 'Entrega',
              group: groupSaleType,
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                button(
                  'Voltar',
                  180,
                  50,
                  Icons.arrow_back,
                  () => Navigator.pop(context)
                ),

                button(
                  'Avançar',
                  180,
                  50,
                  Icons.arrow_forward,
                  () => {
                    Navigator.pushNamed(context, 'finalize_order_customer/address'),
                  },
                  false
                ),
              ],
            ),
            
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}