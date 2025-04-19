import 'package:chillsync/utils/formatters.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${Formatters.formatDate(DateTime.now())} ${Formatters.formatDay(DateTime.now())}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Hello , @Username",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _progressCard('Current Temperature', 20,100,'F', 'Temperature status'),
                SizedBox(height: 20),
                _progressCard('Current Humidity', 50, 100,'% RH','Humidity status'),
                SizedBox(height: 10),
                Text(
                  "Quick Access",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildQuickAccessButton(context, 'View Map', Icons.map, ''),
                    SizedBox(width: 20),
                    _buildQuickAccessButton(context, 'Set temperature', Icons.thermostat, '/control-temperature'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _progressCard(String title,double value,double totalValue,String unit, String status){
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0099FF), Color(0xFF0147FC)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 27,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${value.toString()} $unit' ,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            //progress bar
            LinearProgressIndicator(
              value: value/ totalValue,
              backgroundColor: Color(0xFF0147FC),
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              minHeight: 15,
              borderRadius: BorderRadius.circular(100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessButton(BuildContext context, String label, IconData icon, String route) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Card(
        color: Colors.grey[100],
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, route),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                SizedBox(height: 8),
                Icon(icon, size: 50, color: Colors.blue[700]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}