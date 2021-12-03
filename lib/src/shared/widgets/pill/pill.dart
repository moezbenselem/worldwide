import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pill extends StatefulWidget {
  const Pill({
    Key? key,
    required this.filtre,
    required this.color,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;
  final String filtre;
  final Color color;

  @override
  State<Pill> createState() => _PillState();
}

class _PillState extends State<Pill> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.filtre);
      },
      child: Chip(
        label: Text(
          widget.filtre,
          style: widget.theme.textTheme.subtitle2,
        ),
        backgroundColor: widget.color,
        elevation: 3,
      ),
    );
  }
}
