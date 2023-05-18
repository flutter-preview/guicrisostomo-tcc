import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/main.dart';
import 'package:tcc/model/Address.dart';
import 'package:tcc/utils.dart';
import 'package:tcc/view/widget/button.dart';
import 'package:tcc/view/widget/sectionVisible.dart';

import 'textFieldGeneral.dart';

class AddressExistent extends StatefulWidget {
  final TextEditingController txtAddress;
  final TextEditingController txtNumberHome;
  final TextEditingController txtNeighborhood;
  final TextEditingController txtComplement;
  final TextEditingController txtNickName;

  const AddressExistent({
    super.key,
    required this.txtAddress,
    required this.txtNumberHome,
    required this.txtNeighborhood,
    required this.txtComplement,
    required this.txtNickName,
  });

  @override
  State<AddressExistent> createState() => _AddressExistentState();
}

class _AddressExistentState extends State<AddressExistent> {
  bool isShowAddressExistent = true;
  Icon iconAddressExistent = const Icon(Icons.arrow_drop_down_rounded);

  String groupLocals = '';

  Address? addressSelected;

  Future<List<Address>> getAddress() async {
    return await LoginController().getAddress();
  }

  Widget newAddress([bool isUnique = false]) {
    
    return Column(
      children: [
        const SizedBox(height: 10),

        

        if (groupLocals == 'New address' || groupLocals.split('-')[0] == 'Edit')
          Column(
            children: [
              const SizedBox(height: 20),

              TextFieldGeneral(
                label: 'Nome',
                variavel: widget.txtNickName,
                context: context,
                keyboardType: TextInputType.text,
                ico: Icons.house_rounded,
                validator: (value) {
                  return validatorString(value!);
                },
              ),

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

              (groupLocals.split('-')[0] == 'Edit') ?
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
                        LoginController().updateAddress(
                          context,
                          addressSelected!,
                          widget.txtAddress.text,
                          widget.txtNeighborhood.text,
                          int.parse(widget.txtNumberHome.text),
                          widget.txtNickName.text,
                          null,
                          null,
                          null,
                          widget.txtComplement.text,
                        ),
                        addressSelected = null,
                        Navigator.pop(context),
                        Navigator.push(context, navigator('finalize_order_customer/address')),
                      }, false),
                    ],
                  ),
                )
              : Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: button('Salvar', 170, 70, Icons.save, () {
                  LoginController().insertAddress(
                    context,
                    widget.txtAddress.text,
                    widget.txtNeighborhood.text,
                    int.parse(widget.txtNumberHome.text),
                    widget.txtNickName.text,
                    null,
                    null,
                    null,
                    widget.txtComplement.text,
                  );

                  Navigator.pop(context);
                  Navigator.push(context, navigator('finalize_order_customer/address'));
                }),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getAddress(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return (snapshot.hasData && snapshot.data!.isNotEmpty) ?
            
            Builder(
              builder: (context) {
                if (groupLocals == '') {
                  groupLocals = snapshot.data![0].nickname;
                }

                return Column(
                  children: [

                    if (groupLocals.split('-')[0] != 'Edit')
                      SectionVisible(
                        nameSection: 'Endereços cadastrados',
                        isShowPart: true,
                        child: Column(
                          children: 
                            [ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return Column(
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
                                                value: snapshot.data![i].nickname,
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
                        
                                                        Text(
                                                          snapshot.data![i].nickname,
                                                          style: const TextStyle(
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
                                                          widget.txtNickName.text = snapshot.data![i].nickname;
                                                          widget.txtAddress.text = snapshot.data![i].street;
                                                          widget.txtNumberHome.text = snapshot.data![i].number.toString();
                                                          widget.txtNeighborhood.text = snapshot.data![i].district;
                                                          widget.txtComplement.text = snapshot.data![i].complement ?? '';
                        
                                                          addressSelected = snapshot.data![i];
                                                          groupLocals = 'Edit-${snapshot.data![i].nickname}';
                                                        });
                                                      },
                                                      icon: const Icon(Icons.edit),
                                                      color: globals.primary,
                                                    )
                                                  ],
                                                ),
                        
                                                subtitle: Text(
                                                  '${snapshot.data![i].street}, ${snapshot.data![i].number}',
                                                  style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            ),

                            const SizedBox(height: 20),

                            Theme(
                              data: ThemeData(
                                radioTheme: RadioThemeData(
                                  fillColor: MaterialStateColor.resolveWith((states) => globals.primaryBlack),
                                )
                              ),
                              child: RadioListTile(
                                value: 'New address',
                                groupValue: groupLocals,
                                onChanged: (value) {
                                  setState(() {
                                    groupLocals = value.toString();
                                  });
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

                      newAddress(),
                  ],
                );
              }
            ) : StatefulBuilder(
            builder: (context, setState) {
              setState(() {
                groupLocals = 'New address';
              });
              return newAddress(true);
            }
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}