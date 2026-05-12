import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  // Removed the required onThemeChanged parameter to fix your error!
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('System Settings')),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            _buildSettingsTile(Icons.notifications_active, 'Notifications', 'Manage AI alert preferences'),
            _buildSettingsTile(Icons.security, 'Security', 'Authentication and access levels'),
            _buildSettingsTile(Icons.data_usage, 'Data Sync', 'Network and local storage limits'),
            _buildSettingsTile(Icons.memory, 'Neural Engine', 'Configure processing power'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6C63FF).withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(vertical: 15),
                side: BorderSide(color: Color(0xFF6C63FF).withOpacity(0.5)),
              ),
              child: Text('Return to Dashboard', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // A custom widget to make the settings list look premium
  Widget _buildSettingsTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF6C63FF), size: 30),
        title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.white54)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
        onTap: () {
          // Placeholder for future functionality
        },
      ),
    );
  }
}