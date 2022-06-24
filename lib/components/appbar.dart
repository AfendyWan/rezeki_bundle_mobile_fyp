import 'package:flutter/material.dart';
class appbar extends StatelessWidget implements PreferredSizeWidget{
  const appbar({
    Key? key,
    required this.title,
    required this.context,
  }) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(50.0);
  final BuildContext context;

final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Color.fromARGB(221, 255, 212, 253),
      automaticallyImplyLeading: false,

      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
