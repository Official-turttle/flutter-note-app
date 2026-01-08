import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String mode; // 'view', 'edit', 'add', or 'home'
  final int? totalNotes;
  final Function()? onSave;
  final Function()? onClose;
  final Function()? onLogout; // New parameter for logout action
  final Function()? onAddNote; // New parameter for adding a note in home mode

  CustomAppBar({
    required this.mode,
    this.totalNotes,
    this.onSave,
    this.onClose,
    this.onLogout, // Added logout parameter
    this.onAddNote, // Added add note parameter for home mode
  });

  Widget _buildIconButton(Icon icon, Function()? onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 32.0,
        height: 32.0,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.65), // Fixed opacity
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
                : mode == 'add'
                    ? 'Add New Note'
                    : mode == 'home'
                        ? 'Home' // Title for home mode
                        : 'Notes', // Default title
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

        // Circular badge for totalNotes (only in Home mode)
        if (mode == 'home' && totalNotes != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.65),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$totalNotes',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
          ),

        // Logout button (added)
        if (onLogout != null)
          _buildIconButton(
            Icon(Icons.exit_to_app),
            onLogout, // Call the logout function
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
