import 'package:chillsync/components/custom_main_app_bar.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomMainAppbar(title: "About Us", showLeading: true,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/images/about_us.png", height: 200),
                ),
                SizedBox(height: 20),
            
                Text(
                  "Our mission is to ensure the integrity of perishable goods throughout their journey by leveraging cutting-edge IoT technology. We aim to empower businesses and consumers with real-time data and insights, ensuring optimal conditions for food storage and transportation.\n\n"
            
                  "With ChillSync, monitor temperature, humidity, and other critical parameters effortlessly through our intuitive interface. Receive timely alerts, access detailed reports, and gain unparalleled visibility into the cold chain process. Our platform is designed to promote accountability, reduce waste, and uphold the highest standards of food safety.\n\n"
            
                  "Join us in revolutionizing food safety management, creating a world where every bite is as fresh and safe as intended. Let ChillSync be your ally in delivering quality and trust, one shipment at a time.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
            
                Divider(),
                SizedBox(height: 8),
            
                Text(
                  "For More Information",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset("assets/icons/facebook.png", height: 30),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Image.asset("assets/icons/google.png", height: 30),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20),
            
                Text(
                  "©2025 ChillSync All right reserved. Developed by Group AA (Batch 12 UOP-NSBM)",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}