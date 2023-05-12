import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tcc/view/widget/appBar.dart';
import 'package:tcc/view/widget/bottonNavigation.dart';
import 'package:tcc/view/widget/sectionVisible.dart';
import 'package:tcc/view/widget/switchListTile.dart';
import 'package:tcc/view/widget/textFieldGeneral.dart';

class ScreenTimeWorkEmployee extends StatefulWidget {
  final String? id;
  const ScreenTimeWorkEmployee({
    super.key,
    required this.id,
  });

  @override
  State<ScreenTimeWorkEmployee> createState() => _ScreenTimeWorkEmployeeState();
}

class _ScreenTimeWorkEmployeeState extends State<ScreenTimeWorkEmployee> {
  var txtSundayStart = TextEditingController();
  var txtSundayEnd = TextEditingController();
  var txtMondayStart = TextEditingController();
  var txtMondayEnd = TextEditingController();
  var txtTuesdayStart = TextEditingController();
  var txtTuesdayEnd = TextEditingController();
  var txtWednesdayStart = TextEditingController();
  var txtWednesdayEnd = TextEditingController();
  var txtThursdayStart = TextEditingController();
  var txtThursdayEnd = TextEditingController();
  var txtFridayStart = TextEditingController();
  var txtFridayEnd = TextEditingController();
  var txtSaturdayStart = TextEditingController();
  var txtSaturdayEnd = TextEditingController();

  bool isWorkSunday = false;
  bool isWorkMonday = false;
  bool isWorkTuesday = false;
  bool isWorkWednesday = false;
  bool isWorkThursday = false;
  bool isWorkFriday = false;
  bool isWorkSaturday = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          pageName: 'Horário de trabalho do funcionário ${widget.id}',
          context: context,
          withoutIcons: true,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SectionVisible(
              nameSection: 'Horário de trabalho do funcionário ${widget.id}', 
              isShowPart: true,
              child: Column(
                children: [
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          SwitchListTileWidget(
                            title: Text(
                              'Domingo',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ), 
                            onChanged: (value) {
                              setState(() {
                                isWorkSunday = value;
                              });
                            }, 
                            value: isWorkSunday,
                          ),

                          const SizedBox(height: 20),

                          if (isWorkSunday)
                            Column(
                              children: [
                                TextFieldGeneral(
                                  label: 'De', 
                                  variavel: txtSundayStart, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),

                                const SizedBox(height: 20),

                                TextFieldGeneral(
                                  label: 'Até', 
                                  variavel: txtSundayEnd, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),
                              ],
                            ),
                        ],
                      );
                    }
                  ),

                  const SizedBox(height: 20),

                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          SwitchListTileWidget(
                            title: Text(
                              'Segunda-feira',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ), 
                            onChanged: (value) {
                              setState(() {
                                isWorkMonday = value;
                              });
                            }, 
                            value: isWorkMonday,
                          ),

                          const SizedBox(height: 20),

                          if (isWorkMonday)
                            Column(
                              children: [
                                TextFieldGeneral(
                                  label: 'De', 
                                  variavel: txtMondayStart, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),

                                const SizedBox(height: 20),

                                TextFieldGeneral(
                                  label: 'Até', 
                                  variavel: txtMondayEnd, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),
                              ],
                            ),
                        ],
                      );
                    }
                  ),

                  const SizedBox(height: 20),

                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          SwitchListTileWidget(
                            title: Text(
                              'Terça-feira',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ), 
                            onChanged: (value) {
                              setState(() {
                                isWorkTuesday = value;
                              });
                            }, 
                            value: isWorkTuesday,
                          ),

                          const SizedBox(height: 20),

                          if (isWorkTuesday)
                            Column(
                              children: [
                                TextFieldGeneral(
                                  label: 'De', 
                                  variavel: txtTuesdayStart, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),

                                const SizedBox(height: 20),

                                TextFieldGeneral(
                                  label: 'Até', 
                                  variavel: txtTuesdayEnd, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),
                              ],
                            ),
                        ],
                      );
                    }
                  ),

                  const SizedBox(height: 20),

                  StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        children: [
                          SwitchListTileWidget(
                            title: Text(
                              'Quarta-feira',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ), 
                            onChanged: (value) {
                              setState(() {
                                isWorkWednesday = value;
                              });
                            }, 
                            value: isWorkWednesday,
                          ),

                          const SizedBox(height: 20),

                          if (isWorkWednesday)
                            Column(
                              children: [
                                TextFieldGeneral(
                                  label: 'De', 
                                  variavel: txtWednesdayStart, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),

                                const SizedBox(height: 20),

                                TextFieldGeneral(
                                  label: 'Até', 
                                  variavel: txtWednesdayEnd, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),
                              ],
                            ),
                        ],
                      );
                    }
                  ),

                  const SizedBox(height: 20),

                  StatefulBuilder(
                    builder: ((context, setState) {
                      return Column(
                        children: [
                          SwitchListTileWidget(
                            title: Text(
                              'Quinta-feira',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ), 
                            onChanged: (value) {
                              setState(() {
                                isWorkThursday = value;
                              });
                            }, 
                            value: isWorkThursday,
                          ),

                          const SizedBox(height: 20),

                          if (isWorkThursday)
                            Column(
                              children: [
                                TextFieldGeneral(
                                  label: 'De', 
                                  variavel: txtThursdayStart, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),

                                const SizedBox(height: 20),

                                TextFieldGeneral(
                                  label: 'Até', 
                                  variavel: txtThursdayEnd, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),
                              ],
                            ),
                        ],
                      );
                    })
                  ),

                  const SizedBox(height: 20),

                  StatefulBuilder(
                    builder: ((context, setState) {
                      return Column(
                        children: [
                          SwitchListTileWidget(
                            title: Text(
                              'Sexta-feira',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ), 
                            onChanged: (value) {
                              setState(() {
                                isWorkFriday = value;
                              });
                            }, 
                            value: isWorkFriday,
                          ),

                          const SizedBox(height: 20),

                          if (isWorkFriday)
                            Column(
                              children: [
                                TextFieldGeneral(
                                  label: 'De', 
                                  variavel: txtFridayStart, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),

                                const SizedBox(height: 20),

                                TextFieldGeneral(
                                  label: 'Até', 
                                  variavel: txtFridayEnd, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),
                              ],
                            ),
                        ],
                      );
                    })
                  ),

                  const SizedBox(height: 20),

                  StatefulBuilder(
                    builder: ((context, setState) {
                      return Column(
                        children: [
                          SwitchListTileWidget(
                            title: Text(
                              'Sábado',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ), 
                            onChanged: (value) {
                              setState(() {
                                isWorkSaturday = value;
                              });
                            }, 
                            value: isWorkSaturday,
                          ),

                          const SizedBox(height: 20),

                          if (isWorkSaturday)
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextFieldGeneral(
                                  label: 'De', 
                                  variavel: txtSaturdayStart, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),

                                const SizedBox(height: 20),

                                TextFieldGeneral(
                                  label: 'Até', 
                                  variavel: txtSaturdayEnd, 
                                  context: context, 
                                  keyboardType: TextInputType.number,
                                  isHour: true,
                                ),
                              ],
                            ),
                        ],
                      );
                    })
                  ),
                ]
              )
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Bottom(),
    );
  }
}