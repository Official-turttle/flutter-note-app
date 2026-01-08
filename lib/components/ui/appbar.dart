import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String mode; // 'view', 'edit', or 'add'
  final int? totalNotes;
  final Function()? onSave;
  final Function()? onClose;

  CustomAppBar({
    required this.mode,
    this.totalNotes,
    this.onSave,
    this.onClose,
  });

  Widget _buildIconButton(Icon icon, Function()? onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 32.0,
        height: 32.0,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.65),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: icon,
          onPressed: onPressed,
          color: Colors.blue,
          iconSize: 18.0,
          padding: EdgeInsets.zero, // Remove default padding around the icon
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text(
        mode == 'view'
            ? 'View Note'
            : mode == 'edit'
                ? 'Edit Note'
                : 'Add New Note',
        style: TextStyle(color: Colors.white),
      ),
      automaticallyImplyLeading: false,
      actions: [
        if (mode == 'edit' || mode == 'add')
          _buildIconButton(
            Icon(Icons.check),
            onSave,
          ),
        if (onClose != null)
          _buildIconButton(
            Icon(Icons.close),
            onClose,
          ),

        // Circular badge for totalNotes
        if (totalNotes != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.65),
                shape:
                    BoxShape.circle, // Circular shape for the total notes badge
              ),
              child: Center(
                child: Text(
                  '$totalNotes',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
