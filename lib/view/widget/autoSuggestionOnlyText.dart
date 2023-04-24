import 'package:flutter/material.dart';

class AutoSuggestionOnlyText extends StatefulWidget {
  final List<String> list;
  final void Function(String) onSelected;
  
  const AutoSuggestionOnlyText({
    super.key,
    required this.list,
    required this.onSelected,
  });

  @override
  State<AutoSuggestionOnlyText> createState() => _AutoSuggestionOnlyTextState();
}

class _AutoSuggestionOnlyTextState extends State<AutoSuggestionOnlyText> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return widget.list.where((String option) {
          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: widget.onSelected,

    );
  }
}