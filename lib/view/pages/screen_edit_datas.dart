import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/model/User.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/addressExistent.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/snackBars.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tcc/globals.dart' as globals;

class ScreenEditDatas extends StatefulWidget {
  Object? arguments;

  ScreenEditDatas({super.key, this.arguments});

  @override
  State<ScreenEditDatas> createState() => _ScreenEditDatasState();
}

class _ScreenEditDatasState extends State<ScreenEditDatas> {

  var txtEmail = TextEditingController();
  var txtName = TextEditingController();
  var txtPhone = TextEditingController();

  bool autoValidation = false;

  var formKey = GlobalKey<FormState>();
  var formKeyAddress = GlobalKey<FormState>();
  
  @override
  void initState() {
    autoValidation = false;
    super.initState();

    UserList user = widget.arguments as UserList;

    txtName.text = user.name;
    txtEmail.text = user.email;
    txtPhone.text = user.phone;
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
      appBar: (globals.userType != 'employee') ? PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
        pageName: 'Editar dados',
        context: context,
        withoutIcons: true,
      )) : PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
            pageName: 'Perfil', 
            context: context, 
            icon: Icons.person,
          ),
        ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            SectionVisible(
              nameSection: 'Dados pessoais',
              isShowPart: true,
              child: 
                Column(
                  children: [
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
                              return validatorString(value!);
                            },
                            textCapitalization: TextCapitalization.sentences,
                          ),
                    
                          const SizedBox(height: 10,),
                    
                          TextFieldGeneral(
                            label: 'E-mail', 
                            variavel: txtEmail,
                            context: context, 
                            keyboardType: TextInputType.emailAddress,
                            ico: Icons.email_outlined,
                            validator: (value) {
                              return validatorEmail(value!);
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
                              return validatorPhone(value!);
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
                      
                              LoginController().updateUser(FirebaseAuth.instance.currentUser!.uid, txtName.text, txtEmail.text, txtPhone.text, context, false).whenComplete(() async {
                                await FirebaseAuth.instance.currentUser!.updateDisplayName(txtName.text);
                                await FirebaseAuth.instance.currentUser!.updateEmail(txtEmail.text);
                              });
                    
                            } else {
                              setState(() {
                                autoValidation = true;
                              });
                            }
                    
                          })
                        ]
                      ),
                    ),
                  
                    const SizedBox(height: 20,),

                    button('Alterar senha', 280, 50, Icons.lock, () {
                      FirebaseAuth.instance.sendPasswordResetEmail(email: FirebaseAuth.instance.currentUser!.email!).whenComplete(() {
                        success(context, 'Foi enviado um e-mail para ${FirebaseAuth.instance.currentUser!.email} com as instruções para alterar a senha.');
                      });
                    }),
                  ],
                ),
            ),

            const SizedBox(height: 20,),

            const AddressExistent(),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}