import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mussabihati/utils/constants.dart';

ThemeData lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  backgroundColor: lightPrimary,
  dialogBackgroundColor: lightPrimary,
  scaffoldBackgroundColor: lightPrimary,
  bottomAppBarColor: lightPrimary,
  cardColor: lightPrimary,
  accentColor: lightAccent,
  primaryColor: lightPrimary,
  splashColor: lightAccent.withOpacity(0.15),
  hoverColor: lightAccent.withOpacity(0.15),
  cursorColor: lightAccent,
  focusColor: lightAccent,
  indicatorColor: lightAccent,
  highlightColor: lightAccent.withOpacity(0.15),
  accentIconTheme: IconThemeData(color: lightPrimary, size: 24),
  primaryIconTheme: IconThemeData(color: lightText, size: 24),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: lightAccent,
    actionTextColor: lightPrimary,
    contentTextStyle: TextStyle(color: lightPrimary, letterSpacing: 1.2),
    behavior: SnackBarBehavior.floating,
  ),
  toggleableActiveColor: lightAccent,
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: lightText,
        letterSpacing: 1.2,
        fontFamily: GoogleFonts.poppins().fontFamily),
    bodyText2: TextStyle(
        color: lightPrimary,
        letterSpacing: 1.2,
        fontFamily: GoogleFonts.poppins().fontFamily),
    subtitle2: TextStyle(
        color: lightText,
        letterSpacing: 1.2,
        fontFamily: GoogleFonts.poppins().fontFamily),
    subtitle1: TextStyle(
        color: lightPrimary,
        letterSpacing: 1.2,
        fontFamily: GoogleFonts.poppins().fontFamily),
    button: TextStyle(
        color: lightAccent.withOpacity(0.5),
        fontFamily: GoogleFonts.cabin().fontFamily),
    caption: TextStyle(color: lightText),
    headline1:
        TextStyle(color: lightText, fontFamily: GoogleFonts.cabin().fontFamily),
    headline2:
        TextStyle(color: lightText, fontFamily: GoogleFonts.cabin().fontFamily),
    headline3:
        TextStyle(color: lightText, fontFamily: GoogleFonts.cabin().fontFamily),
    headline4:
        TextStyle(color: lightText, fontFamily: GoogleFonts.cabin().fontFamily),
    headline5: TextStyle(
      color: lightText,
      fontFamily: GoogleFonts.cabin().fontFamily,
    ),
    headline6: TextStyle(
        color: lightText,
        fontFamily: GoogleFonts.cabin().fontFamily,
        fontWeight: FontWeight.w800),
  ),
  timePickerTheme: TimePickerThemeData(
    dialHandColor: lightAccent,
    backgroundColor: lightPrimary,
    hourMinuteColor: lightAccent.withOpacity(0.3),
    dayPeriodColor: lightAccent.withOpacity(0.3),
    dayPeriodTextColor: lightAccent,
    hourMinuteTextColor: lightAccent,
    entryModeIconColor: lightText,
    helpTextStyle: TextStyle(
        color: lightText,
        fontFamily: GoogleFonts.cabin().fontFamily,
        fontSize: 19,
        fontWeight: FontWeight.w800),
    dayPeriodTextStyle: TextStyle(
        color: lightText,
        fontFamily: GoogleFonts.cabin().fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w800),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightAccent.withOpacity(0.3),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: lightAccent)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      isDense: true,
    ),
    dialBackgroundColor: Colors.grey.shade300,
    hourMinuteTextStyle: TextStyle(
        fontSize: 24,
        color: lightText,
        fontFamily: GoogleFonts.cabin().fontFamily),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    dayPeriodShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    hourMinuteShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),

  buttonBarTheme: ButtonBarThemeData(
    buttonTextTheme: ButtonTextTheme.accent,
  
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: lightAccent,
    disabledColor: Colors.grey,
    colorScheme: ColorScheme.light(),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    color: lightAccent,
    fillColor: lightAccent,
  ),
  buttonColor: lightAccent,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(foregroundColor: lightAccent),
  appBarTheme: AppBarTheme(
      elevation: 0,
      actionsIconTheme: IconThemeData(color: lightText, size: 25),
      iconTheme: IconThemeData(color: lightText, size: 25),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightText,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 20,
        ),
      )),
  dividerTheme: DividerThemeData(
    color: lightAccent,
    thickness: 0.5,
    indent: 20,
    endIndent: 20,
  ),
  cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: lightPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: lightPrimary,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 4,
      type: BottomNavigationBarType.fixed,
      backgroundColor: lightPrimary,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      unselectedLabelStyle: TextStyle(color: lightText),
      unselectedIconTheme: IconThemeData(color: lightAccent.withOpacity(0.5)),
      selectedIconTheme: IconThemeData(color: lightAccent),
      selectedLabelStyle:
          TextStyle(color: lightAccent, fontWeight: FontWeight.bold)),
  selectedRowColor: lightAccent.withOpacity(0.15),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: lightText.withOpacity(0.15),
    labelStyle: TextStyle(
      color: lightAccent,
    ),
    alignLabelWithHint: true,
    counterStyle: TextStyle(color: lightAccent),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red.shade900)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: lightAccent)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red)),
  ),
);
