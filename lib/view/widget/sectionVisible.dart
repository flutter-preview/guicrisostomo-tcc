import 'package:flutter/material.dart';
import 'package:tcc/globals.dart' as globals;

class SectionVisible extends StatefulWidget {
  final Widget child;
  final String nameSection;

  const SectionVisible({
    super.key,
    required this.nameSection,
    required this.child,
  });

  @override
  State<SectionVisible> createState() => _SectionVisibleState();
}

class _SectionVisibleState extends State<SectionVisible> {
  bool isShowPart = false;
  Icon iconPart = const Icon(Icons.arrow_right_rounded);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        sectionVisible(),
        if (isShowPart) ...[
          widget.child,
        ],
      ],
    );
  }

  Widget sectionVisible() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.nameSection,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),

        IconButton(
          icon: iconPart,
          color: globals.primary,
          onPressed: () {
            setState(() {
              isShowPart = !isShowPart;
            });
              
            if (isShowPart) {
              setState(() {
                iconPart = const Icon(Icons.arrow_drop_down_rounded);
              });
            } else {
              setState(() {
                iconPart = const Icon(Icons.arrow_right_rounded);
              });
            }
          },
        ),
      ],
    );
  }
}