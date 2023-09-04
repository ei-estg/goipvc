import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuListTile<T> extends StatelessWidget {
  final Icon icon;
  final Text text;
  final void Function() onTap;

  const MenuListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: this.onTap,
      leading: this.icon,
      title: this.text,
    );
  }
}