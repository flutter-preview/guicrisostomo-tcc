import 'package:flutter/material.dart';
import 'package:tcc/model/StandardCheckBox.dart';
import 'package:tcc/globals.dart' as globals;
import 'package:tcc/view/widget/snackBars.dart';

class CheckBoxWidget extends StatefulWidget {
  final List<CheckBoxList> list;
  final int limitCheck;
  final void Function(String, bool)? onChanged;

  const CheckBoxWidget({
    super.key,
    required this.list,
    required this.limitCheck,
    this.onChanged,
  });

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  int getCheckBoxSelected() {
    int count = 0;
    for (var item in widget.list) {
      if (item.isChecked) count++;
    }
    return count;
  }
  
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith((states) => globals.primaryBlack),
        ),
      ),

      child: ListView.builder(
        itemCount: widget.list.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return CheckboxListTile(
            value: widget.list[index].isChecked,
            onChanged: (value) {
              getCheckBoxSelected();

              if (widget.limitCheck > getCheckBoxSelected() || widget.list[index].isChecked || widget.limitCheck == 0) {
                setState(() {
                  widget.list[index].isChecked = value!;
                });
              } else {
                error(context, 'Selecione no máximo ${widget.limitCheck} opções.');
              }

              if (widget.onChanged != null) {
                widget.onChanged!(widget.list[index].value, widget.list[index].isChecked);
              }
            },
            title: Text(widget.list[index].value),
            subtitle: (widget.list[index].description != null) ? Text(
              widget.list[index].description!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ) : null,

            controlAffinity: ListTileControlAffinity.leading,
          );
        },
      ),
    );
  }
}