import 'package:chillsync/components/custom_main_app_bar.dart';
import 'package:flutter/material.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({super.key});

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  void _logoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout Confirmation"),
          content: SizedBox(
            width: 300,
            child: Text("Are you sure you want to logout from this app ?")),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No")),
            TextButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/enter-id');
              },
              child: Text("Yes")
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMainAppbar(title: 'User Profile', showLeading: false),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            SizedBox(height: 30),
            Text('@UserName', style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            _buildItemCard(Icons.info_outline, 'About Us', "/about-us"),
            _buildItemCard(Icons.privacy_tip_outlined, 'Privacy Policy', "/privacy-policy"),
            _buildLogout(),
            SizedBox(height: 60),
            Text(
              "©2025 ChillSync All right reserved. Developed by Group AA (Batch 12 UOP-NSBM) \nApp Version - 1.0.0",
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(IconData icon, String title, String route){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 16),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogout(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: InkWell(
        onTap: () {
          _logoutConfirmation(context);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.blue),
              const SizedBox(width: 16),
              Text('Logout'),
            ],
          ),
        ),
      ),
    );
  }
}