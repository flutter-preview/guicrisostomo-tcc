import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/addressExistent.dart';
import 'package:tcc/view/widget/bottonNavigationCustomer.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenEditDatas extends StatefulWidget {
  const ScreenEditDatas(Object arguments, {super.key});

  @override
  State<ScreenEditDatas> createState() => _ScreenEditDatasState();
}

class _ScreenEditDatasState extends State<ScreenEditDatas> {

  var txtEmail = TextEditingController();
  var txtName = TextEditingController();
  var txtPhone = TextEditingController();
  var txtAddress = TextEditingController();
  var txtNumberHome = TextEditingController();
  var txtComplement = TextEditingController();
  var txtNeighborhood = TextEditingController();

  bool autoValidation = false;

  var formKey = GlobalKey<FormState>();
  var formKeyAddress = GlobalKey<FormState>();
  
  @override
  void initState() {
    autoValidation = false;
    super.initState();
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.eager,
  );


    // txtName.text = user.data()['name'];
    // txtEmail.text = user.data()['email'];

    // if (user.data()['phone'] != null) {
    //   txtPhone.text = user.data()['phone'];
    // }

  @override
  Widget build(BuildContext context) {
    // var user = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar dados'),
        centerTitle: true,
        backgroundColor: globals.primary,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            SectionVisible(
              nameSection: 'Dados pessoais',
              child: 
                Form(
                  key: formKey,
                  autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                
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
                
                      const SizedBox(height: 10,),
                
                      TextFieldGeneral(
                        label: 'E-mail', 
                        variavel: txtEmail,
                        context: context, 
                        keyboardType: TextInputType.emailAddress,
                        ico: Icons.email_outlined,
                        validator: (value) {
                          validatorEmail(value!);
                        },
                      ),
                
                      const SizedBox(height: 10,),
                
                      TextFieldGeneral(
                        label: 'Telefone', 
                        variavel: txtPhone,
                        context: context, 
                        keyboardType: TextInputType.number,
                        ico: Icons.phone,
                        inputFormatter: [maskFormatter],

                        validator: (value) {
                          validatorPhone(value!);
                        },
                        onChanged: (value) => {
                          if (value.length <= 14) {
                            txtPhone.value = maskFormatter.updateMask(mask: "(##) ####-#####")
                          } else {
                            txtPhone.value = maskFormatter.updateMask(mask: "(##) #####-####")
                          }
                        }
                      ),
                
                      const SizedBox(height: 50,),
                
                      button('Salvar', 280, 50, Icons.save, () {
                
                        if (formKey.currentState!.validate()) {
                  
                          // LoginController().updateUser(user.id, txtName.text, txtEmail.text, txtPhone.text, context);
                
                        } else {
                          setState(() {
                            autoValidation = true;
                          });
                        }
                
                      })
                    ]
                  ),
                ),
            ),

            const SizedBox(height: 20,),

            Form(
              key: formKeyAddress,
              autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,
              child: Column(
                children: [
            
                  AddressExistent(txtAddress: txtAddress, txtNumberHome: txtNumberHome, txtNeighborhood: txtNeighborhood, txtComplement: txtComplement)
                ]
              ),
            ),

            // Form(
            //   key: formKey,
            //   autovalidateMode: autoValidation ? AutovalidateMode.always : AutovalidateMode.disabled,

            //   child: Column(
            //     children: [
            //       TextFieldGeneral(
            //         label: 'Nome', 
            //         variavel: txtName,
            //         context: context, 
            //         keyboardType: TextInputType.name,
            //         ico: Icons.person,
            //         validator: (value) {
            //           validatorString(value!);
            //         },
            //       ),

            //       const SizedBox(height: 10,),

            //       TextFieldGeneral(
            //         label: 'E-mail', 
            //         variavel: txtEmail,
            //         context: context, 
            //         keyboardType: TextInputType.emailAddress,
            //         ico: Icons.person,
            //         validator: (value) {
            //           validatorEmail(value!);
            //         },
            //       ),

            //       const SizedBox(height: 10,),

            //       TextFieldGeneral(
            //         label: 'Telefone', 
            //         variavel: txtPhone,
            //         context: context, 
            //         keyboardType: TextInputType.number,
            //         ico: Icons.person,
            //         validator: (value) {
            //           validatorPhone(value!);
            //         },
            //         onChanged: (value) => {
            //           if (value.length <= 14) {
            //             txtPhone.value = maskFormatter.updateMask(mask: "(##) ####-#####")
            //           } else {
            //             txtPhone.value = maskFormatter.updateMask(mask: "(##) #####-####")
            //           }
            //         }
            //       ),

            //       const SizedBox(height: 50,),

            //       button('Salvar', 280, 50, Icons.save, () {

            //         if (formKey.currentState!.validate()) {
              
            //           // LoginController().updateUser(user.id, txtName.text, txtEmail.text, txtPhone.text, context);

            //         } else {
            //           setState(() {
            //             autoValidation = true;
            //           });
            //         }

            //       })
            //     ]
            //   ),
            // ),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}