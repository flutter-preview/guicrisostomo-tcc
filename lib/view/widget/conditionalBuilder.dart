import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:tcc/view/widget/checkBox.dart';
import 'package:tcc/view/widget/dropDownButton.dart';
import 'package:tcc/view/widget/radioButton.dart';

class ConditionalBuilderWidget extends StatefulWidget {
  final int condition;
  final Widget Function(BuildContext) builder;
  final Widget Function(BuildContext) fallback;
  final DropDown? dropDown;
  final RadioButon? radioButton;
  final CheckBoxWidget? checkBox;
  
  const ConditionalBuilderWidget({
    super.key,
    required this.condition,
    required this.builder,
    required this.fallback,
    this.dropDown,
    this.radioButton,
    this.checkBox,
  });

  @override
  State<ConditionalBuilderWidget> createState() => _ConditionalBuilderWidgetState();
}

class _ConditionalBuilderWidgetState extends State<ConditionalBuilderWidget> {
  Map<int, bool> isSelectedSubvariation = {
    0: true,
  };
  
  @override
  Widget build(BuildContext context) {
    String? variavel = widget.dropDown?.variavel;
    
    bool getIsSelectedSubvariation(int index) {
      if (isSelectedSubvariation[index] == null) {
        isSelectedSubvariation[index] = false;
      }

      return isSelectedSubvariation[index]!;
      // return false;
    }

    void setIsSelectedSubvariation(int index) {
      isSelectedSubvariation.entries.forEach((element) {
        if (element.key != index) {
          isSelectedSubvariation[element.key] = false;
        } else {
          isSelectedSubvariation[element.key] = true;
        }
      });
    }

    void addSubVariation(int id) {
      final newEntries = <int, bool>{id: false};
      isSelectedSubvariation.addEntries(newEntries.entries);
    }

    // widget.dropDown?.callback = (value) {
    //   setState(() {
    //     // widget.dropDown!.callback;
    //     widget.dropDown!.variavel = value;
    //     setIsSelectedSubvariation(isSelectedSubvariation.keys.toList()[widget.dropDown!.itemsDropDownButton.indexWhere((element) => element.name == value)]);
    //   });
    // };

    // widget.radioButton!.callback = (value) {
      

    //   setState(() {
    //     widget.radioButton!.callback;
    //     setIsSelectedSubvariation(isSelectedSubvariation.keys.toList()[widget.radioButton!.list.indexWhere((element) => element.name == value)]);
    //   });
    // };

    // widget.checkBox?.callback = (value) {
    //   // widget.checkBox!.callback;

    //   setState(() {
    //     widget.checkBox!.callback;
    //     setIsSelectedSubvariation(isSelectedSubvariation.keys.toList()[widget.checkBox!.list.indexWhere((element) => element.value == value)]);
    //   });
    // };

    addSubVariation(0);

    widget.dropDown?.itemsDropDownButton.forEach((element) {
      if (!isSelectedSubvariation.values.toList().contains(element.name)) {
        addSubVariation(isSelectedSubvariation.keys.toList().last + 1);
      }
    });

    // widget.dropDown?.variavel = variavel;

    widget.radioButton?.list.forEach((element) {
      if (!isSelectedSubvariation.values.toList().contains(element.name)) {
        addSubVariation(isSelectedSubvariation.keys.toList().last + 1);
      }
    });

    widget.checkBox?.list.forEach((element) {
      if (!isSelectedSubvariation.values.toList().contains(element.value)) {
        addSubVariation(isSelectedSubvariation.keys.toList().last + 1);
      }
    });

    return Column(
      children: [
        if (widget.dropDown != null) 
          widget.dropDown!,

        if (widget.radioButton != null)
          widget.radioButton!,

        if (widget.checkBox != null)
          widget.checkBox!,

        ConditionalBuilder(
          condition: isSelectedSubvariation[widget.condition]!,
          builder: widget.builder,
          fallback: widget.fallback,
        ),
      ],
    );
  }
}