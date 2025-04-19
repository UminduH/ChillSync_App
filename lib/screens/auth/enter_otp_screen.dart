import 'dart:async';

import 'package:chillsync/components/custom_button.dart';
import 'package:chillsync/components/custom_text_field.dart';
import 'package:chillsync/providers/user_provider.dart';
import 'package:chillsync/services/otp_service.dart';
import 'package:chillsync/utils/formatters.dart';
import 'package:chillsync/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({super.key});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  final _otpController = TextEditingController();
  final OtpService _otpService = OtpService();

  bool _isLoading = false;
  bool _isOtpSent = false;
  int _remainingTime = 30;
  Timer? _timer;
  String? _generatedOtp;
  DateTime? _otpExpiryTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendOtp();
    });
  }

  Future<void> _sendOtp({bool isResend = false}) async {
    if (isResend && _isOtpSent) {
      Helpers.showMessage(context, "Please wait $_remainingTime seconds before requesting another OTP.");
      return;
    }

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String deviceId = args?['deviceId'];

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user == null && !userProvider.isLoading) {
      await userProvider.fetchUser(deviceId);
    }

    String otp = Helpers.generateOtp();
    bool isSuccess = await _otpService.sendSMSOtp(userProvider.user!.phone, otp);

    if (isSuccess) {
      setState(() {
        _generatedOtp = otp;
        _otpExpiryTime = DateTime.now().add(Duration(minutes: 5));
        _isOtpSent = true;
        _remainingTime = 30;
      });

      _startTimer();

      Helpers.showMessage(context, "OTP sent to your phone");

    } else if (isResend) {
      await Future.delayed(Duration(milliseconds: 250));
      Helpers.showMessage(context, "Failed to resend OTP. Please try again.");
    }
  }

  Future<bool> _verifyOtp(String enteredOtp) async {
    if (enteredOtp.isEmpty) {
      Helpers.showMessage(context, "Please enter OTP.");
      return false;
    }

    if (_generatedOtp == null || _otpExpiryTime == null) {
      await Future.delayed(Duration(seconds: 1));
      Helpers.showMessage(context, "OTP has expired. Please request a new one.");
      return false;
    }

    if (DateTime.now().isAfter(_otpExpiryTime!)) {
      await Future.delayed(Duration(seconds: 1));
      Helpers.showMessage(context, "OTP has expired. Please request a new one.");
      return false;
    }

    if (enteredOtp != _generatedOtp) {
      await Future.delayed(Duration(seconds: 1));
      Helpers.showMessage(context, "Invalid OTP. Please try again.");
      return false;
    }

    setState(() {
      _generatedOtp = null;
      _otpExpiryTime = null;
    });
    
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isOtpSent = false;
        });
      }
    });
  }

  Future<void> _handleOtpVerification(String? driverId) async {
    setState(() => _isLoading = true);
    bool isCorrectOtp = await _verifyOtp(_otpController.text);
    setState(() => _isLoading = false);

    if (isCorrectOtp) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/main-layout-screen",
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
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

                      if (userProvider.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else ...[
                        Text(
                          "We've sent an OTP to your phone (${Formatters.getMaskedPhoneNumber(userProvider.user!.phone)}). \nEnter it below to continue.",
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          textName: 'OTP',
                          hintText: 'Enter OTP',
                          controller: _otpController,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () async {
                                _sendOtp(isResend: true);
                              },
                              child: Text(
                                _isOtpSent
                                  ? "Resend OTP in $_remainingTime seconds"
                                  : "Resend OTP",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: _isOtpSent ? Colors.grey : const Color.fromARGB(223, 68, 137, 255),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                label: 'Login',
                isLoading: _isLoading,
                onPressed: _isLoading ? null : () async {
                  await _handleOtpVerification(userProvider.user!.userId);
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
