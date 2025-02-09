// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:permission_handler/permission_handler.dart';

Future<int> requestPermissions(int deviceId) async {
  // Request SMS and Contacts permissions
  var smsPermission = await Permission.sms.request();
  var contactsPermission = await Permission.contacts.request();
  final supabase = SupaFlow.client;

  if (smsPermission.isGranted && contactsPermission.isGranted) {
    await supabase
        .from('devices')
        .update({'permissions': true}).eq('id', deviceId);
    return 1;
  } else if (smsPermission.isPermanentlyDenied ||
      contactsPermission.isPermanentlyDenied) {
    return 3;
  } else {
    return 2;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
