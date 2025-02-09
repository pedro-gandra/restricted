// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

Future storeDeviceInfo(int deviceId) async {
  // Add your function code here!
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final sdk = androidInfo.version.sdkInt;
    final model = androidInfo.model;

    final supabase = SupaFlow.client;

    await supabase
        .from('devices')
        .update({'model': model, 'sdk': sdk}).eq('id', deviceId);
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
