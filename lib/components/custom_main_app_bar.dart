import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomMainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeading;

  const CustomMainAppbar({super.key, required this.title,required this.showLeading });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blueAccent,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: showLeading ? 
        IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ) : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
