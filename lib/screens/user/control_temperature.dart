import 'package:chillsync/components/custom_button.dart';
import 'package:chillsync/components/custom_main_app_bar.dart';
import 'package:chillsync/providers/temperature_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlTemperature extends StatefulWidget {
  const ControlTemperature({super.key});

  @override
  State<ControlTemperature> createState() => _ControlTemperatureState();
}

class _ControlTemperatureState extends State<ControlTemperature> {
  String? _selectedFoodType;

  final Map<String, Map<String, dynamic>> _foodStorageSettings = {
    "fresh-products": {
      "minTemp": 4.0,
      "maxTemp": 10.0,
      "minHumidity": 90.0,
      "maxHumidity": 95.0,
    },
    "dairy-products": {
      "minTemp": 1.0,
      "maxTemp": 4.0,
      "minHumidity": 85.0,
      "maxHumidity": 95.0,
    },
    "meat-and-seafood": {
      "minTemp": -1.0,
      "maxTemp": 4.0,
      "minHumidity": 90.0,
      "maxHumidity": 95.0,
    },
    "packaged-foods": {
      "minTemp": 10.0,
      "maxTemp": 20.0,
      "minHumidity": 50.0,
      "maxHumidity": 60.0,
    },
    "general-test": {
      "minTemp": 20.0,
      "maxTemp": 30.0,
      "minHumidity": 40.0,
      "maxHumidity": 60.0,
    },
  };

  String getStorageDetails() {
    switch (_selectedFoodType) {
      case "fresh-products":
        return "- Refrigerated Storage\n"
              "Temperature: ${_foodStorageSettings['fresh-products']?['minTemp']}°C to ${_foodStorageSettings['fresh-products']?['maxTemp']}°C\n"
              "Humidity: ${_foodStorageSettings['fresh-products']?['minHumidity']}% to ${_foodStorageSettings['fresh-products']?['maxHumidity']}%\n\n"
              "- Freezer Storage\n"
              "Temperature: -18°C or below\n"
              "Humidity: Minimal (<30%)";

      case "dairy-products":
        return "- Refrigerated Storage\n"
              "Temperature: ${_foodStorageSettings['dairy-products']?['minTemp']}°C to ${_foodStorageSettings['dairy-products']?['maxTemp']}°C\n"
              "Humidity: ${_foodStorageSettings['dairy-products']?['minHumidity']}% to ${_foodStorageSettings['dairy-products']?['maxHumidity']}%\n\n"
              "- Freezer Storage\n"
              "Temperature: -18°C or below\n"
              "Humidity: Minimal (<30%)";

      case "meat-and-seafood":
        return "- Refrigerated Storage\n"
              "Temperature: ${_foodStorageSettings['meat-and-seafood']?['minTemp']}°C to ${_foodStorageSettings['meat-and-seafood']?['maxTemp']}°C\n"
              "Humidity: ${_foodStorageSettings['meat-and-seafood']?['minHumidity']}% to ${_foodStorageSettings['meat-and-seafood']?['maxHumidity']}%\n\n"
              "- Freezer Storage\n"
              "Temperature: -18°C or below\n"
              "Humidity: Minimal (<30%)";

      case "packaged-foods":
        return "- Dry Storage\n"
              "Temperature: ${_foodStorageSettings['packaged-foods']?['minTemp']}°C to ${_foodStorageSettings['packaged-foods']?['maxTemp']}°C\n"
              "Humidity: ${_foodStorageSettings['packaged-foods']?['minHumidity']}% to ${_foodStorageSettings['packaged-foods']?['maxHumidity']}%";
      
      case "general-test":
        return "- Room Temperature Conditions\n"
              "Temperature: ${_foodStorageSettings['general-test']?['minTemp']}°C to ${_foodStorageSettings['general-test']?['maxTemp']}°C\n"
              "Humidity: ${_foodStorageSettings['general-test']?['minHumidity']}% to ${_foodStorageSettings['general-test']?['maxHumidity']}%";

      default:
        return "Select a food type to display the storage instructions.";
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedFoodType = Provider.of<TemperatureSettingsProvider>(context, listen: false).selectedFoodType ?? 'fresh-products';
  }

  @override
  Widget build(BuildContext context) {
    final temperatureSettings = Provider.of<TemperatureSettingsProvider>(context, listen: false);
    
    return Scaffold(
      appBar: CustomMainAppbar(title: 'Control Temperature', showLeading: true),
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
              groupValue: _selectedFoodType,
              onChanged: (value) {
                setState(() {
                  _selectedFoodType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text(
                "Dairy Products"
              ),
              value: "dairy-products",
              groupValue: _selectedFoodType,
              onChanged: (value) {
                setState(() {
                  _selectedFoodType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text(
                "Meat and Seafood"
              ),
              value: "meat-and-seafood",
              groupValue: _selectedFoodType,
              onChanged: (value) {
                setState(() {
                  _selectedFoodType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text(
                "Packaged Foods"
              ),
              value: "packaged-foods",
              groupValue: _selectedFoodType,
              onChanged: (value) {
                setState(() {
                  _selectedFoodType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text("General Test Range (Room Temperature)"),
              value: "general-test",
              groupValue: _selectedFoodType,
              onChanged: (value) {
                setState(() {
                  _selectedFoodType = value;
                });
              },
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: _selectedFoodType == "fresh-products"
                      ? "Fresh Products\n\n"
                      : _selectedFoodType == "dairy-products"
                        ? "Dairy Products\n\n"
                        : _selectedFoodType == "meat-and-seafood"
                          ? "Meat and Seafood\n\n"
                          : _selectedFoodType == "packaged-foods"
                            ? "Packaged Foods\n\n"
                            : _selectedFoodType == "general-test"
                              ? "General Test Range\n\n"
                              : "None\n\n",
                    style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: getStorageDetails()),
                ],
              ),
            ),
            SizedBox(height: 50),
            CustomButton(
              label: 'Set Temperature', 
              onPressed: () {
                if (_selectedFoodType != null) {
                  final selectedRange = _foodStorageSettings[_selectedFoodType];
                  if (selectedRange != null) {
                    temperatureSettings.setMinTemperature(selectedRange['minTemp']!);
                    temperatureSettings.setMaxTemperature(selectedRange['maxTemp']!);
                    temperatureSettings.setMinHumidity(selectedRange['minHumidity']!);
                    temperatureSettings.setMaxHumidity(selectedRange['maxHumidity']!);
                    temperatureSettings.setSelectedFoodType(_selectedFoodType);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Temperature settings updated for $_selectedFoodType')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a food type')),
                  );
                }
              }
            ),
          ]
        ),
      ),
    );
  }
}