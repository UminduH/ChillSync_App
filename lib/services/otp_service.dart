import 'package:chillsync/constants/app_credentials.dart';
import 'package:chillsync/utils/helpers.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class OtpService {
  final _accountSid = AppCredentials.twilioAccountSid;
  final _authToken = AppCredentials.twilioAuthToken;
  final _twilioNumber = AppCredentials.twilioPhoneNumber;

  Future<bool> sendSMSOtp(String phoneNumber, String otp) async {
    final TwilioFlutter twilio = TwilioFlutter(
      accountSid: _accountSid,
      authToken: _authToken,
      twilioNumber: _twilioNumber,
    );

    try {
      await twilio.sendSMS(
        toNumber: phoneNumber,
        messageBody: "ShuttleMaster OTP: $otp. Valid for 5 minutes. Do not share this code with anyone."
      );
      Helpers.debugPrintWithBorder("OTP sent successfully via SMS ($phoneNumber)");
      return true;

    } catch (e) {
      Helpers.debugPrintWithBorder("Failed to send OTP via SMS: $e");
      return false;
    }
  }
}