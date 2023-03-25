import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SwitchListTileWidget extends StatefulWidget {
  Widget title;
  bool value = true;
  void Function(bool)? onChanged;

  SwitchListTileWidget({
    super.key,
    required this.title,
    required this.onChanged,
    required this.value,
  });

  @override
  State<SwitchListTileWidget> createState() => _SwitchListTileWidgetState();
}

class _SwitchListTileWidgetState extends State<SwitchListTileWidget> {
  @override
  Widget build(BuildContext context) {

    return SwitchListTile(
      value: widget.value, 
      
      onChanged: widget.onChanged,

      activeColor: Colors.green,
      inactiveThumbColor: Colors.red,
      inactiveTrackColor: Colors.red[100],
      activeTrackColor: Colors.green[100],
      
      title: widget.title,
    );
  }
}