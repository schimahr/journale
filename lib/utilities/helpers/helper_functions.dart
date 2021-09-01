import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelperFunctions {
  static bool isDarkModeOn(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    if (brightness == Brightness.light) {
      return false;
    } else {
      return true;
    }
  }

  static String getFormattedDate(int time) {
    return DateFormat('dd.MM.yyyy').format(
      DateTime.fromMillisecondsSinceEpoch(time),
    );
  }
}
