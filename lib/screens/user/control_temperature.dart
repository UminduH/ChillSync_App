import 'package:chillsync/components/custom_button.dart';
import 'package:chillsync/components/custom_main_app_bar.dart';
import 'package:flutter/material.dart';

class ControlTemperature extends StatefulWidget {
  const ControlTemperature({super.key});

  @override
  State<ControlTemperature> createState() => _ControlTemperatureState();
}

class _ControlTemperatureState extends State<ControlTemperature> {
  String? _selectedMethod;

  String getStorageDetails() {
    //sample data
    switch (_selectedMethod) {
      case "fresh-products":
        return "- Dry Storage\nTemperature: 50°F to 70°F (10°C to 21°C)\nHumidity: Low (to prevent mold and bacteria growth)\n\n"
               "- Refrigerated Storage\nTemperature: 32°F to 40°F (0°C to 4°C)\nHumidity: Moderate (to retain food freshness)\n\n"
               "- Freezer Storage\nTemperature: 0°F (-18°C) or below\nHumidity: Minimal (to avoid freezer burn)";
      case "dairy-products":
        return "- Dry Storage\nTemperature: 60°F to 70°F (10°C to 21°C)\nHumidity: Low (to prevent mold and bacteria growth)\n\n"
               "- Refrigerated Storage\nTemperature: 32°F to 40°F (0°C to 4°C)\nHumidity: Moderate (to retain food freshness)\n\n"
               "- Freezer Storage\nTemperature: 0°F (-18°C) or below\nHumidity: Minimal (to avoid freezer burn)";
      case "meat-and-seafood":
        return "- Dry Storage\nTemperature: 40°F to 70°F (10°C to 21°C)\nHumidity: Low (to prevent mold and bacteria growth)\n\n"
               "- Refrigerated Storage\nTemperature: 32°F to 40°F (0°C to 4°C)\nHumidity: Moderate (to retain food freshness)\n\n"
               "- Freezer Storage\nTemperature: 0°F (-18°C) or below\nHumidity: Minimal (to avoid freezer burn)";
      case "packaged-foods":
        return "- Dry Storage\nTemperature: 30°F to 70°F (10°C to 21°C)\nHumidity: Low (to prevent mold and bacteria growth)\n\n"
               "- Refrigerated Storage\nTemperature: 32°F to 40°F (0°C to 4°C)\nHumidity: Moderate (to retain food freshness)\n\n"
               "- Freezer Storage\nTemperature: 0°F (-18°C) or below\nHumidity: Minimal (to avoid freezer burn)";
      default:
        return "Select a food type to display the storage instructions.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMainAppbar(title: 'Control temperature', showLeading: true),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Center(child: Text('Select Food Type',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
            SizedBox(height: 10),
            RadioListTile<String>(
              title: Text(
                "Fresh Products"
              ),
              value: "fresh-products",
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text(
                "Dairy Products"
              ),
              value: "dairy-products",
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text(
                "Meat and Seafood"
              ),
              value: "meat-and-seafood",
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text(
                "Packaged Foods"
              ),
              value: "packaged-foods",
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value;
                });
              },
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: _selectedMethod == "fresh-products"
                      ? "Fresh Products\n\n"
                      : _selectedMethod == "dairy-products"
                        ? "Dairy Products\n\n"
                        : _selectedMethod == "meat-and-seafood"
                          ? "Meat and Seafood\n\n"
                          : _selectedMethod == "packaged-foods"
                            ? "Packaged Foods\n\n"
                            : "None\n\n",
                    style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: getStorageDetails()),
                ],
              ),
            ),
            SizedBox(height: 50),
            CustomButton(label: 'Proceed', onPressed: (){})
          ]
        ),
      ),
    );
  }
}