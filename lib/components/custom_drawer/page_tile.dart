import 'dart:ui';

import 'package:flutter/material.dart';

class PageTile extends StatelessWidget {
  //  PageTile({Key? key}) : super(key: key);

  PageTile({this.label = '', this.iconData, this.onTap, this.highlighted});

  final String label;
  final IconData? iconData;
  final VoidCallback? onTap;
  final bool? highlighted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData,
          color: highlighted == true ? Colors.purple : Colors.black54),
      title: Text(label,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: highlighted == true ? Colors.purple : Colors.black54)),
      onTap: onTap,
    );
  }
}
