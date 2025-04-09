import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          _buildSettingItem(context, Icons.person, "Account"),
          _buildSettingItem(context, Icons.notifications_none, "Notifications"),
          _buildSettingItem(context, Icons.lock_outline, "Privacy & Security"),
          _buildSettingItem(context, Icons.language, "Language"),
          _buildSettingItem(context, Icons.color_lens_outlined, "Theme"),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      leading: Icon(icon, color: Colors.purple),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        // Navigate or perform action
      },
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
    );
  }
}
