// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tcc/globals.dart' as globals;

class TextFieldGeneral extends StatefulWidget {
  String label;
  TextEditingController variavel;
  BuildContext? context;
  TextInputType keyboardType;
  IconData? ico;
  IconData? icoSuffix;
  double angleSufixIcon = 0;
  String? Function(String?)? validator = (value) {return null;};
  void Function(String)? onFieldSubmitted = (value) {};
  void Function(String)? onChanged = (value) {};
  void Function()? eventPressIconSuffix = () {};
  bool isPassword = false;
  bool isPasswordVisible = false;
  bool multipleDate = false;
  bool isHour = false;
  List<TextInputFormatter>? inputFormatter;

  TextFieldGeneral
    ({
      super.key,
      required this.label,
      required this.variavel,
      required this.keyboardType,
      this.context,
      this.validator,
      this.onFieldSubmitted,
      this.onChanged,
      this.eventPressIconSuffix,
      this.isPassword = false,
      this.isPasswordVisible = false,
      this.ico,
      this.icoSuffix,
      this.angleSufixIcon = 0,
      this.inputFormatter,
      this.multipleDate = true,
      this.isHour = false,
    });

  @override
  State<TextFieldGeneral> createState() => _TextFieldGeneralState();
}

class _TextFieldGeneralState extends State<TextFieldGeneral> {
  
  Future<void> onTapDate() async {
    String? transformDate;
    DateTime? date;
    DateTime? pickedDateSingle;
    DateTimeRange? pickedDate;

    setState(() {
      globals.isUserTyping = true;
    });
    
    if (widget.keyboardType == TextInputType.datetime) {
      widget.multipleDate ? {
        pickedDate = await showDateRangePicker(
          context: widget.context ?? context,
          firstDate: DateTime(2022),
          lastDate: DateTime.now(),
        ),

        if (pickedDate != null) {
          setState(() {
            pickedDate!.start == pickedDate.end ? {
              widget.variavel.text = DateFormat('dd/MM/yyyy').format(pickedDate.start),
            } : {
              widget.variavel.text = '${DateFormat('dd/MM/yyyy').format(pickedDate.start)} - ${DateFormat('dd/MM/yyyy').format(pickedDate.end)}',
            };
          })
        }
      }: {
        widget.variavel.text == '' ? date = DateTime.now() : {
          transformDate = widget.variavel.text.replaceAll('/', '-'),
          transformDate = '${transformDate.split('-')[2]}-${transformDate.split('-')[1]}-${transformDate.split('-')[0]}',
          date = DateTime.parse(transformDate),
        },

        pickedDateSingle = await showDatePicker(
          context: widget.context ?? context,
          initialDate: date,
          firstDate: DateTime(2022),
          lastDate: DateTime.now(),
        ),

        if (pickedDateSingle != null) {
          setState(() {
            widget.variavel.text = DateFormat('dd/MM/yyyy').format(pickedDateSingle!);
          })
        }
      };
    }
  }

  Future<void> onTapHour() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    
    if(pickedTime != null ){
      setState(() {
        widget.variavel.text = pickedTime.format(context).toString().trim();
      });
    }
  }

  Widget textField() {
    if (widget.keyboardType != TextInputType.none) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0,0, 10, 15),
        
        constraints: const BoxConstraints( 
          minWidth: 70,
        ),

        child: Center(
          child: TextFormField(
            controller: widget.variavel,
            inputFormatters: widget.inputFormatter,
            readOnly: widget.keyboardType == TextInputType.datetime ? true : false,
            keyboardType: widget.isPasswordVisible ? TextInputType.visiblePassword : widget.keyboardType,
            obscureText: widget.isPassword ? !widget.isPasswordVisible : false,
            autocorrect: !widget.isPassword,
            enableSuggestions: !widget.isPassword,
            
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),

            decoration: InputDecoration(
              isDense: true,
              labelText: widget.label,
              labelStyle: const TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),

              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide:  const BorderSide(color: Colors.black ),
              ),

              iconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? globals.primaryBlack
                    : globals.primary),

              icon: widget.ico != null ? Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Icon(
                  widget.ico,
                  size: 30
                ),
              ) : null,

              suffixIcon: widget.isPassword ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                  icon: Icon(
                    widget.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: MaterialStateColor.resolveWith((states) =>
                      states.contains(MaterialState.focused)
                          ? globals.primaryBlack
                          : globals.primary),
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.isPasswordVisible = !widget.isPasswordVisible;
                    });
                  },
                ),
              ) : widget.icoSuffix != null ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Transform.rotate(
                  angle: widget.angleSufixIcon,
                  child: IconButton(
                    icon: Icon(
                      widget.icoSuffix,
                      color: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.focused)
                            ? globals.primaryBlack
                            : globals.primary),
                      size: 30,
                    ),
                    onPressed: widget.eventPressIconSuffix,
                  ),
                ),
              ) : null
            ),

            validator: widget.validator,

            onFieldSubmitted: widget.onFieldSubmitted,

            onChanged: (value) {
              // setState(() {
                widget.onChanged!(value);
              // });
            },

            onTap: () async {
              if (widget.keyboardType == TextInputType.datetime) {
                await onTapDate();
              }

              if (widget.isHour) {
                await onTapHour();
              }
            },

            onEditingComplete: () {
              setState(() {
                globals.isUserTyping = false;
              });
            },

            onSaved: (value) {
              setState(() {
                globals.isUserTyping = false;
              });
            },

            onTapOutside: (event) {
              setState(() {
                globals.isUserTyping = false;
              });
            },
          )
        )
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.focused)
                  ? globals.primaryBlack
                  : globals.primary),
            spreadRadius: 1,
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: textField(),
      ),
    );
  }
}