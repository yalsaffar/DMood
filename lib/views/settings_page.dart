import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For iOS style widgets

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10),
          //_buildProfileSection(context),
          Divider(height: 20, thickness: 1),
          _buildSettingsOption('Account', Icons.person, context),
          _buildSettingsOption('Notifications', Icons.notifications, context),
          _buildSettingsOption('Privacy', Icons.lock, context),
          _buildSettingsOption('Language', Icons.language, context),
          Divider(height: 20, thickness: 1),
          _buildSettingsOption('Help & Feedback', Icons.help, context),
          _buildSettingsOption('About', Icons.info_outline, context),
          _buildSettingsOption('Log Out', Icons.logout, context),
          _buildSettingsOption('Delete Account', Icons.delete, context),
          _buildSettingsOption('Terms of Service', Icons.description, context),
          _buildSettingsOption('Privacy Policy', Icons.description, context),
          _buildSettingsOption('Open Source Licenses', Icons.collections_bookmark, context),
          _buildSettingsOption('App Version', Icons.info_outline, context),
          
        ],
      ),
    );
  }

 

  Widget _buildSettingsOption(String title, IconData icon, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Handle ListTile tap
      },
    );
  }
}
