import 'package:flutter/material.dart';

class SwitchListTileWidget extends StatefulWidget {
  Widget title;
  String? subtitle;
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
    this.subtitle,
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

      subtitle: (widget.subtitle != null) ? Text(
        widget.subtitle!,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ) : null,
    );
  }
}