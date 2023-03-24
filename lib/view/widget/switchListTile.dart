import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SwitchListTileWidget extends StatefulWidget {
  final String text;
  bool isEnabled = true;
  Function(bool)? onChanged;

  SwitchListTileWidget({
    super.key,
    required this.text,
    this.isEnabled = true,
    this.onChanged,
  });

  @override
  State<SwitchListTileWidget> createState() => _SwitchListTileWidgetState();
}

class _SwitchListTileWidgetState extends State<SwitchListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: widget.isEnabled, 
      onChanged: (value) {
        setState(() {
          widget.isEnabled = value;
        });

        widget.onChanged!(value);
      },

      activeColor: Colors.green,
      inactiveThumbColor: Colors.red,
      inactiveTrackColor: Colors.red[100],
      activeTrackColor: Colors.green[100],
      
      title: Text(
        widget.text,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}