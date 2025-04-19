import 'package:chillsync/components/custom_main_app_bar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomMainAppbar(title: "Privacy Policy", showLeading: true,),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Effecive Date: 10 February 2025",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),

              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(text: "Welcome to ChillSync. We value your privacy and are committed to safeguarding your personal information. This Privacy Policy outlines how we collect, use, and protect your data when you use our app.\n\n"),

                    _boldText("1. Information We Collect\n"),
                    TextSpan(text: "\t\t• Usage Data: We collect information on how you interact with the app, including device activity logs, environmental monitoring data, alerts reviewed, and reporting features accessed.\n"),
                    TextSpan(text: "\t\t• Device Information: Information such as the model, operating system, and unique identifiers of the device you use may be collected.\n\n"),

                    _boldText("2. How We Use Your Information\n"),
                    TextSpan(text: "\t\t• To Provide Services: Your data enables us to offer accurate cold chain monitoring, environmental alerts, and access to reporting tools for food safety management.\n"),
                    TextSpan(text: "\t\t• To Improve Our App: We analyze usage patterns to refine and enhance the performance, functionality, and reliability of the app.\n"),
                    TextSpan(text: "\t\t• Communication: Your contact information may be used to send updates, notifications, and relevant messages about app features and performance.\n\n"),

                    _boldText("3. Sharing Your Information\n"),
                    TextSpan(text: "\t\t• Third-Party Services: We may share data with trusted third parties, such as cloud storage providers or IoT platform integrators, to ensure seamless functionality. These partners are obligated to protect your data and use it only for agreed purposes.\n"),
                    TextSpan(text: "\t\t• Legal Requirements: We may disclose data when required by law or in response to legitimate legal processes.\n\n"),

                    _boldText("4. Data Security\n"),
                    TextSpan(text: "We implement industry-standard security measures to protect your personal information against unauthorized access, alteration, or disclosure. While every effort is made to secure data, we cannot guarantee absolute safety during transmission.\n\n"),

                    _boldText("5. Changes to This Privacy Policy\n"),
                    TextSpan(text: "This Privacy Policy may be updated periodically. Changes will be communicated through our app with an updated effective date.\n\n"),

                    _boldText("6. Contact Us\n"),
                    TextSpan(text: "If you have questions or concerns about this Privacy Policy, please contact us at chillsync@gmail.com.",),
                  ],
                ),
              ),
              SizedBox(height: 30),

              Text(
                "©2025 ChillSync All right reserved. Developed by Group AA (Batch 12 UOP-NSBM)",
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan _boldText(String text) {
    return TextSpan(
      text: text,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}