import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tcc/controller/auth/auth.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenRegisterBusiness extends StatefulWidget {
  const ScreenRegisterBusiness({super.key});

  @override
  State<ScreenRegisterBusiness> createState() => _ScreenRegisterBusinessState();
}

class _ScreenRegisterBusinessState extends State<ScreenRegisterBusiness> {
  TextEditingController txtNameBusiness = TextEditingController();
  TextEditingController txtCNPJ = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtNumberHome = TextEditingController();
  TextEditingController txtNeighborhood = TextEditingController();
  TextEditingController txtComplement = TextEditingController();
  TextEditingController txtReference = TextEditingController();
  TextEditingController txtCity = TextEditingController();
  TextEditingController txtState = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  
  String groupValueCategory = 'Restaurant';

  var formKey = GlobalKey<FormState>();

  MaskTextInputFormatter phoneFormat = MaskTextInputFormatter(
    mask: '(##) #####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy,
  );

  MaskTextInputFormatter cnpjFormat = MaskTextInputFormatter(
    mask: '##.###.###/####-##', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Cadastro de empresa',
          context: context,
          withoutIcons: true,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Cadastro de empresa',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20,),

            const Text(
              'Preencha os dados abaixo para cadastrar sua empresa.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20,),

            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFieldGeneral(
                    label: 'Nome da empresa', 
                    variavel: txtNameBusiness, 
                    keyboardType: TextInputType.name,
                    validator: (p0) {
                      return validatorString(p0!);
                    },
                    textCapitalization: TextCapitalization.sentences,
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'CNPJ', 
                    variavel: txtCNPJ, 
                    keyboardType: TextInputType.number,
                    validator: (p0) {
                      return validatorString(p0!);
                    },
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      cnpjFormat,],
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'Telefone', 
                    variavel: txtPhone, 
                    keyboardType: TextInputType.number,
                    validator: (p0) {
                      return validatorPhone(p0!);
                    },
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      phoneFormat,],

                    onChanged: (value) {
                      setState(() {
                        if (value.length <= 14) {
                          txtPhone.value = phoneFormat.updateMask(mask: "(##) ####-#####");
                        } else {
                          txtPhone.value = phoneFormat.updateMask(mask: "(##) #####-####");
                        }
                      });
                    },
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'Endereço', 
                    variavel: txtAddress, 
                    keyboardType: TextInputType.text,
                    validator: (p0) {
                      return validatorString(p0!);
                    },
                    textCapitalization: TextCapitalization.sentences,
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'Número', 
                    variavel: txtNumberHome, 
                    keyboardType: TextInputType.number,
                    validator: (p0) {
                      return validatorString(p0!);
                    },
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'Bairro', 
                    variavel: txtNeighborhood, 
                    keyboardType: TextInputType.text,
                    validator: (p0) {
                      return validatorString(p0!);
                    },
                    textCapitalization: TextCapitalization.sentences,
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'Complemento', 
                    variavel: txtComplement, 
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'Referência', 
                    variavel: txtReference, 
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'Cidade', 
                    variavel: txtCity, 
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'Estado', 
                    variavel: txtState, 
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'E-mail', 
                    variavel: txtEmail, 
                    keyboardType: TextInputType.emailAddress,
                    validator: (p0) {
                      return validatorEmail(p0!);
                    },
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'Senha', 
                    variavel: txtPassword, 
                    keyboardType: TextInputType.text,
                    validator: (p0) {
                      return validatorPassword(p0!);
                    },
                    isPassword: true,
                  ),

                  const SizedBox(height: 20,),

                  TextFieldGeneral(
                    label: 'Confirmar senha', 
                    variavel: txtConfirmPassword, 
                    keyboardType: TextInputType.text,
                    validator: (p0) {
                      return validatorConfirmPassword(p0!, txtPassword);
                    },
                    isPassword: true,
                  ),

                  const SizedBox(height: 20,),

                  const Text(
                    'Selecione o tipo de empresa:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'Restaurant',
                            groupValue: groupValueCategory,
                            onChanged: (value) {
                              setState(() {
                                groupValueCategory = value!;
                              });
                            },
                          ),

                          const Row(
                            children: [
                              Icon(Icons.restaurant, size: 20, color: Colors.black,),

                              SizedBox(width: 5,),

                              Text(
                                'Restaurante',
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(width: 20,),

                      Row(
                        children: [
                          Radio(
                            value: 'pizzeria',
                            groupValue: groupValueCategory,
                            onChanged: (value) {
                              setState(() {
                                groupValueCategory = value!;
                              });
                            },
                          ),

                          const Row(
                            children: [
                              Icon(Icons.local_pizza, size: 20, color: Colors.black,),

                              SizedBox(width: 5,),

                              Text(
                                'Pizzaria',
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(width: 20,),

                      Row(
                        children: [
                          Radio(
                            value: 'bar',
                            groupValue: groupValueCategory,
                            onChanged: (value) {
                              setState(() {
                                groupValueCategory = value!;
                              });
                            },
                          ),

                          const Row(
                            children: [
                              Icon(Icons.local_bar, size: 20, color: Colors.black,),

                              SizedBox(width: 5,),

                              Text(
                                'Bar',
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(width: 20,),

                      Row(
                        children: [
                          Radio(
                            value: 'snack_bar',
                            groupValue: groupValueCategory,
                            onChanged: (value) {
                              setState(() {
                                groupValueCategory = value!;
                              });
                            },
                          ),

                          const Row(
                            children: [
                              Icon(Icons.local_dining, size: 20, color: Colors.black,),

                              SizedBox(width: 5,),

                              Text(
                                'Lanchonete',
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(width: 20,),

                      Row(
                        children: [
                          Radio(
                            value: 'coffee_shop',
                            groupValue: groupValueCategory,
                            onChanged: (value) {
                              setState(() {
                                groupValueCategory = value!;
                              });
                            },
                          ),

                          const Row(
                            children: [
                              Icon(Icons.local_cafe, size: 20, color: Colors.black,),

                              SizedBox(width: 5,),

                              Text(
                                'Cafeteria',
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(width: 20,),

                      Row(
                        children: [
                          Radio(
                            value: 'ice_cream_shop',
                            groupValue: groupValueCategory,
                            onChanged: (value) {
                              setState(() {
                                groupValueCategory = value!;
                              });
                            },
                          ),

                          const Row(
                            children: [
                              Icon(Icons.icecream, size: 20, color: Colors.black,),

                              SizedBox(width: 5,),

                              Text(
                                'Sorveteria',
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(width: 20,),

                      Row(
                        children: [
                          Radio(
                            value: 'other',
                            groupValue: groupValueCategory,
                            onChanged: (value) {
                              setState(() {
                                groupValueCategory = value!;
                              });
                            },
                          ),

                          const Row(
                            children: [
                              Icon(Icons.add, size: 20, color: Colors.black,),

                              SizedBox(width: 5,),

                              Text(
                                'Outro',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40,),

                  const Text(
                    'Ao clicar em cadastrar, você concorda com os termos de uso.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),


                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'terms');
                    }, 
                    child: const Text(
                      'Nossos termos de uso',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )

                ]
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: button('Cadastrar', 0, 0, Icons.check, () async {
          if (formKey.currentState!.validate()) {
            Navigator.pushNamed(context, 'loading');
            await LoginController.instance.updateTypeUser('Gerente').then((value) async {

              Navigator.pop(context);
              Navigator.pop(context);
              
              Navigator.pop(context);
              Navigator.pop(context);

              GoRouter.of(context).go('/home_manager');
              
              
            });
            
          }
        }),
      ),
    );
  }
}