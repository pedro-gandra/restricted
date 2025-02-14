import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/supabase/supabase.dart';

bool isSofia(String str) {
  str = str.toLowerCase();
  if (str.contains("sofia") ||
      str.contains("sophia") ||
      str.contains("soso") ||
      str.contains("dulac")) return true;
  return false;
}

DateTime changeDate(DateTime date) {
  return date.add(Duration(days: 2));
}

String calculateCountdown(DateTime available) {
  Duration difference = available.difference(DateTime.now());

  if (difference.isNegative) {
    return "00:00:00";
  }

  int hours = difference.inHours;
  int minutes = difference.inMinutes % 60;
  int seconds = difference.inSeconds % 60;

  return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}

String clearPhoneNumber(String str) {
  return str.replaceAll(RegExp(r'[^+\d]'), '');
}

bool isJohn(String str) {
  str = str.toLowerCase();
  if (str.contains("john") || str.contains("jon")) return true;
  return false;
}
