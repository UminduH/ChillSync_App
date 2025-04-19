import 'package:chillsync/components/custom_main_app_bar.dart';
import 'package:chillsync/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          backgroundColor: Colors.white,
          title: const Text("Logout Confirmation"),
          content: const SizedBox(
            width: 300,
            child: Text("Are you sure you want to logout from this app?")),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No")),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blueAccent,
              ),
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/enter-id', (Route<dynamic> route) => false);
              },
              child: const Text("Yes"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              final user = userProvider.user;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  Text(user!.name, style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 30),
                  _buildItemCard(Icons.info_outline, 'About Us', "/about-us"),
                  _buildItemCard(Icons.privacy_tip_outlined, 'Privacy Policy', "/privacy-policy"),
                  _buildLogout(),
                  const SizedBox(height: 60),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      "©2025 ChillSync All right reserved. Developed by Group AA (Batch 12 UOP-NSBM) \nApp Version - 1.0.0",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),
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
          child: const Row(
            children: [
              Icon(Icons.logout, color: Colors.blue),
              SizedBox(width: 16),
              Text('Logout'),
            ],
          ),
        ),
      ),
    );
  }
}