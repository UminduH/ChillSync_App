import 'package:chillsync/components/custom_button.dart';
import 'package:chillsync/components/custom_text_field.dart';
import 'package:chillsync/providers/user_provider.dart';
import 'package:chillsync/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EnterIdScreen extends StatefulWidget {
  const EnterIdScreen({super.key});

  @override
  State<EnterIdScreen> createState() => _EnterIdScreenState();
}

class _EnterIdScreenState extends State<EnterIdScreen> {
  final _deviceIdController = TextEditingController();

  @override
  void dispose() {
    _deviceIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.blueAccent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 70),
                      const Text(
                        'Welcome to \n ChillSync !',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.asset("assets/images/login.png", height: 300),
                      CustomTextField(
                        textName: 'Device ID',
                        hintText: 'Enter Device ID',
                        controller: _deviceIdController,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                label: 'Continue',
                isLoading: userProvider.isLoading,
                onPressed: userProvider.isLoading ? null : () async {
                  String deviceId = _deviceIdController.text.trim();

                  if (deviceId.isNotEmpty) {
                    await userProvider.fetchUser(deviceId);

                    if (userProvider.user == null) {
                      Helpers.showMessage(context, "Invalid Device ID. Please try again.");
                      return;
                    }
                  
                    Navigator.pushNamed(
                      context, 
                      "/enter-otp",
                      arguments: {"deviceId": deviceId},
                    );
                  } else {
                    Helpers.showMessage(context, "Device ID is required");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
