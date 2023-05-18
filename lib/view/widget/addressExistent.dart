import 'package:flutter/material.dart';
import 'package:tcc/controller/firebase/auth.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/main.dart';
import 'package:tcc/model/Address.dart';
import 'package:tcc/view/widget/sectionVisible.dart';

class AddressExistent extends StatefulWidget {
  Address? addressSelected;
  AddressExistent({
    super.key,
    this.addressSelected,
  });

  @override
  State<AddressExistent> createState() => _AddressExistentState();
}

class _AddressExistentState extends State<AddressExistent> {
  bool isShowAddressExistent = true;
  Icon iconAddressExistent = const Icon(Icons.arrow_drop_down_rounded);

  String groupLocals = '';
  List<Address> listAddress = [];

  Future<List<Address>> getAddress() async {
    return await LoginController().getAddress();
  }

  Widget newAddress() {
    return Theme(
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

          Navigator.push(context, navigator('create_edit_address')).then((value) {
            setState(() {
              getAddress().then((value) {
                setState(() {
                  listAddress = value;
                  groupLocals = listAddress[0].nickname;
                });
              });
            });
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
    );
  }

  @override
  void initState() {
    super.initState();
    getAddress().then((value) {
      setState(() {
        listAddress = value;
        groupLocals = value[0].nickname;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (groupLocals == '') {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
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
                    itemCount: listAddress.length,
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
                                      value: listAddress[i].nickname,
                                      groupValue: groupLocals,
                                      onChanged: (value) => {
                                        setState(() {
                                          groupLocals = value!;
                                          widget.addressSelected = listAddress[i];
                                        }),
                                      },
                                      
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,

                                            children: [
                                              Icon(
                                                Icons.house,
                                                color: globals.primary,
                                              ),
              
                                              const SizedBox(width: 10),
              
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.3,
                                                child: Text(
                                                  listAddress[i].nickname,
                                                  style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),

                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                Navigator.push(context, navigator('create_edit_address', listAddress[i])).then((value) async {
                                                  await getAddress().then((value) {

                                                    setState(() {
                                                      listAddress = value;
                                                      groupLocals = listAddress[i].nickname;
                                                    });

                                                  });
                                                });
                                              });
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: globals.primary,
                                          ),
              
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                Navigator.push(context, navigator('create_edit_address', listAddress[i])).then((value) async {
                                                  await getAddress().then((value) {

                                                    setState(() {
                                                      listAddress = value;
                                                      groupLocals = listAddress[i].nickname;
                                                    });

                                                  });
                                                });
                                              });
                                            },
                                            icon: const Icon(Icons.edit),
                                            color: globals.primary,
                                          ),
                                        ],
                                      ),
              
                                      subtitle: Text(
                                        '${listAddress[i].street}, ${listAddress[i].number}',
                                        style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                        ),
                                        overflow: TextOverflow.ellipsis,
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

                  newAddress(),
                ],
              ),
            ),
        ],
      );
    }
  }
}