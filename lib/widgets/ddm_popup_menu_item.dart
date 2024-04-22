import 'package:flutter/material.dart';

class DDMPopupMenuItem extends PopupMenuItem {
  DDMPopupMenuItem({
    super.key,
    required String text,
    required int value,
    required IconData icon,
  }) : super(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 28,
          value: value,
          child: ListTile(
            trailing: Icon(
              icon,
              size: 18,
            ),
            leading: Text(text),
          ),
        );
}
