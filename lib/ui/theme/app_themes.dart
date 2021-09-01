import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colours.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColours.darkOliveGreen,
      selectionHandleColor: AppColours.persianOrange,
    ),
    splashColor: Color(0x5055693A),
    cardTheme: CardTheme(
      color: AppColours.honeydew,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    brightness: Brightness.light,
    textTheme: TextTheme(),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColours.honeydew,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColours.honeydew,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    dividerTheme: DividerThemeData(
      thickness: 1,
      color: AppColours.olivine,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.black54,
      ),
      hintStyle: TextStyle(color: Colors.black54),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: AppColours.olivine,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(
          color: AppColours.darkOliveGreen,
        ),
      ),
    ),
    scaffoldBackgroundColor: AppColours.mintCream,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Color(0x5055693A),
          ),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          )),
    ),
    primaryColor: AppColours.olivine,
    accentColor: AppColours.darkOliveGreen,
    primarySwatch: AppColours.lightThemePrimarySwatch,
    fontFamily: GoogleFonts.assistant().fontFamily,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColours.pineTree,
      contentTextStyle: TextStyle(
        color: AppColours.honeydew,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(),
    brightness: Brightness.dark,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColours.darkOliveGreen,
      selectionHandleColor: AppColours.coffee,
    ),
    splashColor: Color(0x5055693A),
    cardTheme: CardTheme(
      color: AppColours.pineTree,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColours.kombuGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColours.kombuGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    dividerTheme: DividerThemeData(
      thickness: 1,
      color: AppColours.darkOliveGreen,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.white70,
      ),
      hintStyle: TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: AppColours.darkOliveGreen,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(
          color: AppColours.maximumGreen,
        ),
      ),
    ),
    scaffoldBackgroundColor: AppColours.darkJungleGreen,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith(
          (states) => Color(0x5055693A),
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
    primaryColor: AppColours.kombuGreenV,
    accentColor: AppColours.maximumGreen,
    primarySwatch: AppColours.darkThemePrimarySwatch,
    fontFamily: GoogleFonts.assistant().fontFamily,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColours.honeydew,
      contentTextStyle: TextStyle(
        color: AppColours.darkJungleGreen,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
