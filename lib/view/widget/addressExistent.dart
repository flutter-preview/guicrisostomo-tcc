import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/utils.dart';

import 'textFieldGeneral.dart';

class AddressExistent extends StatefulWidget {
  String groupLocals;
  final TextEditingController txtAddress;
  final TextEditingController txtNumberHome;
  final TextEditingController txtNeighborhood;
  final TextEditingController txtComplement;

  AddressExistent({
    super.key,
    required this.txtAddress,
    required this.txtNumberHome,
    required this.txtNeighborhood,
    required this.txtComplement,
    this.groupLocals = 'Casa',
  });

  @override
  State<AddressExistent> createState() => _AddressExistentState();
}

class _AddressExistentState extends State<AddressExistent> {
  bool isShowAddressExistent = false;
  Icon iconAddressExistent = const Icon(Icons.arrow_right_rounded);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        TextButton(
          onPressed: () => {
            setState(() {
              isShowAddressExistent = !isShowAddressExistent;
            }),
              
            if (isShowAddressExistent) {
              setState(() {
                iconAddressExistent = const Icon(Icons.arrow_drop_down_rounded);
              }),
            } else {
              setState(() {
                iconAddressExistent = const Icon(Icons.arrow_right_rounded);
              }),
            }
          },

          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Endereços cadastrados',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
        
              IconButton(
                icon: iconAddressExistent,
                color: globals.primary,
                onPressed: () {
                  setState(() {
                    isShowAddressExistent = !isShowAddressExistent;
                  });
                    
                  if (isShowAddressExistent) {
                    setState(() {
                      iconAddressExistent = const Icon(Icons.arrow_drop_down_rounded);
                    });
                  } else {
                    setState(() {
                      iconAddressExistent = const Icon(Icons.arrow_right_rounded);
                    });
                  }
                },
              ),
            ],
          ),
        ),

        if (isShowAddressExistent)
          Column(
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
                          groupValue: widget.groupLocals,
                          onChanged: (value) => {
                            setState(() {
                              widget.groupLocals = value!;
                            }),
                          },
                          
                          title: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Casa',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),

                              Icon(
                                Icons.house,
                                color: globals.primary,
                              ),
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
                          groupValue: widget.groupLocals,
                          onChanged: (value) => {
                            setState(() {
                              widget.groupLocals = value!;
                            }),
                          },
                          
                          title: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Trabalho',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),

                              Icon(
                                Icons.work,
                                color: globals.primary,
                              ),
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
                          groupValue: widget.groupLocals,
                          onChanged: (value) => {
                            setState(() {
                              widget.groupLocals = value!;
                            }),
                          },
                          
                          title: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        
        if (widget.groupLocals == 'New address')
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
            ],
          ),
      ],
    );
  }
}