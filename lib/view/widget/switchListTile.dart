import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SwitchListTileWidget extends StatefulWidget {
  Widget title;
  bool value = true;
  void Function(bool)? onChanged;
  Icon? icon;
  bool privateValue;

  SwitchListTileWidget({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
    this.icon,
    this.privateValue = false,
  });

  @override
  State<SwitchListTileWidget> createState() => _SwitchListTileWidgetState();
}

class _SwitchListTileWidgetState extends State<SwitchListTileWidget> {
  @override
  Widget build(BuildContext context) {

    return SwitchListTile(
      value: widget.value, 
      
      onChanged: (widget.privateValue == false) ? widget.onChanged : (value) {
        setState(() {
          widget.value = value;
        });
        widget.onChanged!(value);
      },

      activeColor: Colors.green,
      inactiveThumbColor: Colors.red,
      inactiveTrackColor: Colors.red[100],
      activeTrackColor: Colors.green[100],
      
      title: (widget.icon != null) ? Row(
        children: [
          widget.icon!,
          const SizedBox(width: 10),
          widget.title,
        ],
      ) : widget.title,
    );
  }
}