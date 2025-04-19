class SensorStatus {
  static String getAirQualityStatus(double ppm) {
    if (ppm < 50) {
      return 'Excellent';
    } else if (ppm < 150) {
      return 'Good';
    } else if (ppm < 170) {
      return 'Moderate';
    } else if (ppm < 190) {
      return 'Poor';    
    } else if (ppm < 210) {
      return 'Very Poor';
    } else {
      return 'Hazardous';
    }
  }

  static String getTemperatureStatus(double temperature) {
    if (temperature < 10) {
      return 'Very Cold';
    } else if (temperature < 20) {
      return 'Cold';
    } else if (temperature < 28) {
      return 'Comfortable';
    } else if (temperature < 35) {
      return 'Warm';
    } else {
      return 'Hot';
    }
  }

  static String getHumidityStatus(double humidity) {
    if (humidity < 30) {
      return 'Very Dry';
    } else if (humidity < 40) {
      return 'Dry';
    } else if (humidity < 60) {
      return 'Comfortable';
    } else if (humidity < 70) {
      return 'Slightly Humid';
    } else {
      return 'Very Humid';
    }
  }
}