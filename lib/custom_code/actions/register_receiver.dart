// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

Future registerReceiver() async {
  // Add your function code here!
  const platform = MethodChannel('com.nemesis.restricted/native');
  try {
    await platform.invokeMethod('registerSmsReceiver');
  } on PlatformException catch (e) {
    print("Failed to call native method: '${e.message}'.");
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
