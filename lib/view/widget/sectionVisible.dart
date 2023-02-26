import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

class SectionVisible extends StatefulWidget {
  final Widget child;
  final String nameSection;
  bool isShowPart = false;

  SectionVisible({
    super.key,
    required this.nameSection,
    required this.child,
    this.isShowPart = false,
  });

  @override
  State<SectionVisible> createState() => _SectionVisibleState();
}

class _SectionVisibleState extends State<SectionVisible> {
  
  @override
  Widget build(BuildContext context) {
    Icon iconPart = widget.isShowPart ? const Icon(Icons.arrow_right_rounded, size: 30,) : const Icon(Icons.arrow_drop_down_rounded, size: 30,);
    return Column(
      children: [
        sectionVisible(),
        if (widget.isShowPart) ...[
          widget.child,
        ],
      ],
    );
  }

  Widget sectionVisible() {
    Icon iconPart = widget.isShowPart ? const Icon(Icons.arrow_right_rounded, size: 30,) : const Icon(Icons.arrow_drop_down_rounded, size: 30,);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                widget.nameSection,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
    
          IconButton(
            icon: iconPart,
            color: globals.primary,

            onPressed: () {
              setState(() {
                widget.isShowPart = !widget.isShowPart;
              });
                
              if (widget.isShowPart) {
                setState(() {
                  iconPart = const Icon(Icons.arrow_drop_down_rounded, size: 30,);
                });
              } else {
                setState(() {
                  iconPart = const Icon(Icons.arrow_right_rounded, size: 30,);
                });
              }
            },
          ),
        ],
      ),
    );
  }
}