import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/sectionVisible.dart';

import 'textFieldGeneral.dart';

class AddressExistent extends StatefulWidget {
  final TextEditingController txtAddress;
  final TextEditingController txtNumberHome;
  final TextEditingController txtNeighborhood;
  final TextEditingController txtComplement;

  const AddressExistent({
    super.key,
    required this.txtAddress,
    required this.txtNumberHome,
    required this.txtNeighborhood,
    required this.txtComplement,
  });

  @override
  State<AddressExistent> createState() => _AddressExistentState();
}

class _AddressExistentState extends State<AddressExistent> {
  bool isShowAddressExistent = true;
  Icon iconAddressExistent = const Icon(Icons.arrow_drop_down_rounded);

  String groupLocals = 'Casa';

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        if (groupLocals.split('-')[0] != 'Edit')
          SectionVisible(
            nameSection: 'Endereços cadastrados',
            isShowPart: true,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Theme(
                          data: ThemeData(
                            radioTheme: RadioThemeData(
                              fillColor: MaterialStateColor.resolveWith((states) => globals.primaryBlack),
                            )
                          ),
                          child: RadioListTile(
                            value: 'Casa',
                            groupValue: groupLocals,
                            onChanged: (value) => {
                              setState(() {
                                groupLocals = value!;
                              }),
                            },
                            
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.house,
                                      color: globals.primary,
                                    ),

                                    const SizedBox(width: 10),

                                    const Text(
                                      'Casa',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),

                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.txtAddress.text = 'Rua dos Bobos, 0';
                                      widget.txtNumberHome.text = '0';
                                      widget.txtNeighborhood.text = 'Bairro dos Bobos';
                                      widget.txtComplement.text = 'Sem complemento';
                                    

                                      groupLocals = 'Edit-Casa';
                                    });
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: globals.primary,
                                )
                              ],
                            ),

                            subtitle: const Text(
                              'Rua dos Bobos, 0',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                    
                        const SizedBox(height: 10),
                    
                        Theme(
                          data: ThemeData(
                            radioTheme: RadioThemeData(
                              fillColor: MaterialStateColor.resolveWith((states) => globals.primaryBlack),
                            )
                          ),
                          child: RadioListTile(
                            value: 'Trabalho',
                            groupValue: groupLocals,
                            onChanged: (value) => {
                              setState(() {
                                groupLocals = value!;
                              }),
                            },
                            
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,

                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.work,
                                      color: globals.primary,
                                    ),

                                    const SizedBox(width: 10),

                                    const Text(
                                      'Trabalho',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),

                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.txtAddress.text = 'Rua dos Bobos, 0';
                                      widget.txtNumberHome.text = '0';
                                      widget.txtNeighborhood.text = 'Bairro dos Bobos';
                                      widget.txtComplement.text = 'Sem complemento';

                                      groupLocals = 'Edit-Trabalho';
                                    });
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: globals.primary,
                                )
                              ],
                            ),

                            subtitle: const Text(
                              'Rua dos Bobos, 0',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Theme(
                          data: ThemeData(
                            radioTheme: RadioThemeData(
                              fillColor: MaterialStateColor.resolveWith((states) => globals.primaryBlack),
                            )
                          ),
                          child: RadioListTile(
                            value: 'New address',
                            groupValue: groupLocals,
                            onChanged: (value) => {
                              setState(() {
                                groupLocals = value!;
                              }),
                            },
                            
                            title: Row(
                              children: [
                                const Flexible(
                                  child: Text(
                                    'Cadastrar novo endereço',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                            
                                Icon(
                                  Icons.add,
                                  color: globals.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
        
        if (groupLocals == 'New address' || groupLocals.split('-')[0] == 'Edit')
          Column(
            children: [
              const SizedBox(height: 20),

              TextFieldGeneral(
                label: 'Endereço',
                variavel: widget.txtAddress,
                context: context,
                keyboardType: TextInputType.streetAddress,
                ico: Icons.house_rounded,
                validator: (value) {
                  validatorString(value!);
                },
              ),

              const SizedBox(height: 20,),

              TextFieldGeneral(
                label: 'Nº',
                variavel: widget.txtNumberHome,
                context: context,
                keyboardType: TextInputType.number,
                ico: Icons.location_on_outlined,
                validator: (value) {
                  validatorNumber(value!);
                },
              ),

              const SizedBox(height: 20,),

              TextFieldGeneral(
                label: 'Bairro',
                variavel: widget.txtNeighborhood,
                context: context,
                keyboardType: TextInputType.streetAddress,
                ico: Icons.map_outlined,
                validator: (value) {
                  validatorString(value!);
                },
              ),

              const SizedBox(height: 20,),

              TextFieldGeneral(
                label: 'Complemento',
                variavel: widget.txtComplement,
                context: context,
                keyboardType: TextInputType.streetAddress,
                ico: Icons.info_outline_rounded,
                validator: (value) {
                  validatorString(value!);
                },
              ),

              if (groupLocals.split('-')[0] == 'Edit')
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      button('Cancelar', 170, 70, Icons.cancel, () => {
                        setState(() {
                          groupLocals = '';
                        }),
                      }),
                      button('Salvar', 170, 70, Icons.save, () => {
                        setState(() {
                          groupLocals = '';
                        }),
                      }, false),
                    ],
                  ),
                )
            ],
          ),
      ],
    );
  }
}