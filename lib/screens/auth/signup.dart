import 'package:chillsync/components/custom_button.dart';
import 'package:chillsync/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _deviceIdController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _driverNameController = TextEditingController();
  final _driverIdController = TextEditingController();
  final _contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.blueAccent,
        systemNavigationBarIconBrightness: Brightness.light, 
      ),
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      SizedBox(height: 35),
                      Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomTextField(
                        textName: 'Device ID',
                        hintText: 'Enter device id ',
                        controller: _deviceIdController,
                      ),
                      CustomTextField(
                        textName: 'Vehicle Number',
                        hintText: 'Enter vehicle number ',
                        controller: _vehicleNumberController,
                      ),
                      CustomTextField(
                        textName: 'Driver Name',
                        hintText: 'Enter driver name ',
                        controller: _driverNameController,
                      ),
                      CustomTextField(
                        textName: 'Driver ID',
                        hintText: 'Enter driver id ',
                        controller: _driverIdController,
                      ),
                      CustomTextField(
                        textName: 'Contact Number',
                        hintText: 'Enter contact number ',
                        controller: _contactNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/enter-id');
                            },
                            child: Text(
                              'Back to Login',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              CustomButton(label: 'Signup', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}