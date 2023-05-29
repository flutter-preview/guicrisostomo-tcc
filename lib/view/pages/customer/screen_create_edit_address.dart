import 'package:flutter/material.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/model/Address.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenCreateEditAddress extends StatefulWidget {
  Address? addressSelected;

  ScreenCreateEditAddress({
    super.key,
    this.addressSelected,
  });

  @override
  State<ScreenCreateEditAddress> createState() => _ScreenCreateEditAddressState();
}

class _ScreenCreateEditAddressState extends State<ScreenCreateEditAddress> {
  var txtAddress = TextEditingController();
  var txtNumberHome = TextEditingController();
  var txtComplement = TextEditingController();
  var txtNeighborhood = TextEditingController();
  var txtNickName = TextEditingController();
  var txtReference = TextEditingController();
  GlobalKey<FormState> formKeyAddress = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    if (widget.addressSelected != null) {
      txtAddress.text = widget.addressSelected!.street;
      txtNumberHome.text = widget.addressSelected!.number.toString();
      txtComplement.text = widget.addressSelected!.complement ?? '';
      txtNeighborhood.text = widget.addressSelected!.district;
      txtNickName.text = widget.addressSelected!.nickname;
      txtReference.text = widget.addressSelected!.reference ?? '';
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: widget.addressSelected != null ? 'Editar endereço' : 'Cadastrar endereço',
          context: context,
          icon: Icons.house_rounded,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKeyAddress,
          child: Column(
            children: [
              const SizedBox(height: 10),
        
              TextFieldGeneral(
                label: 'Nome',
                variavel: txtNickName,
                context: context,
                keyboardType: TextInputType.text,
                ico: Icons.house_rounded,
                validator: (value) {
                  return validatorString(value!);
                },
                textCapitalization: TextCapitalization.sentences,
              ),
        
              const SizedBox(height: 20),
        
              TextFieldGeneral(
                label: 'Endereço',
                variavel: txtAddress,
                context: context,
                keyboardType: TextInputType.streetAddress,
                ico: Icons.house_rounded,
                validator: (value) {
                  return validatorString(value!);
                },
                textCapitalization: TextCapitalization.sentences,
              ),
        
              const SizedBox(height: 20,),
        
              TextFieldGeneral(
                label: 'Nº',
                variavel: txtNumberHome,
                context: context,
                keyboardType: TextInputType.number,
                ico: Icons.location_on_outlined,
                validator: (value) {
                  return validatorNumber(value!);
                },
              ),
        
              const SizedBox(height: 20,),
        
              TextFieldGeneral(
                label: 'Bairro',
                variavel: txtNeighborhood,
                context: context,
                keyboardType: TextInputType.streetAddress,
                ico: Icons.map_outlined,
                validator: (value) {
                  return validatorString(value!);
                },
                textCapitalization: TextCapitalization.sentences,
              ),
        
              const SizedBox(height: 20,),
        
              TextFieldGeneral(
                label: 'Complemento',
                variavel: txtComplement,
                context: context,
                keyboardType: TextInputType.streetAddress,
                ico: Icons.info_outline_rounded,
                textCapitalization: TextCapitalization.sentences,
              ),
        
              const SizedBox(height: 20,),
        
              TextFieldGeneral(
                label: 'Referência',
                variavel: txtReference,
                context: context,
                keyboardType: TextInputType.streetAddress,
                ico: Icons.info_outline_rounded,
                textCapitalization: TextCapitalization.sentences,
              )
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            button('Cancelar', 170, 70, Icons.cancel, () => {
              Navigator.pop(context),
            }),
            button(widget.addressSelected != null ? 'Salvar' : 'Cadastrar', 170, 70, Icons.save, () async => {
              if (formKeyAddress.currentState!.validate()) {
                if (widget.addressSelected != null) {
                  await LoginController().updateAddress(
                    context,
                    widget.addressSelected!,
                    txtAddress.text,
                    txtNeighborhood.text,
                    int.parse(txtNumberHome.text),
                    txtNickName.text,
                    null,
                    null,
                    null,
                    txtComplement.text == '' ? null : txtComplement.text,
                    txtReference.text == '' ? null : txtReference.text,
                  ),
                  
                  Navigator.pop(context),
                } else {
                  await LoginController().insertAddress(
                    context,
                    txtAddress.text,
                    txtNeighborhood.text,
                    int.parse(txtNumberHome.text),
                    txtNickName.text,
                    null,
                    null,
                    null,
                    txtComplement.text == '' ? null : txtComplement.text,
                    txtReference.text == '' ? null : txtReference.text,
                  ),
        
                  Navigator.pop(context),
                }
              }
            }, false),
          ],
        ),
      ),
    );
  }
}