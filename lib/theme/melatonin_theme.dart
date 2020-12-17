import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mussabihati/utils/constants.dart';

ThemeData darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  backgroundColor: darkPrimary,
  dialogBackgroundColor: darkPrimary,
  scaffoldBackgroundColor: darkPrimary,
  bottomAppBarColor: darkPrimary,
  cardColor: darkPrimary,
  accentColor: darkAccent,
  primaryColor: darkPrimary,
  toggleableActiveColor: darkAccent,
  hoverColor: darkAccent.withOpacity(0.15),
  cursorColor: darkAccent,
  focusColor: darkAccent,
  indicatorColor: darkAccent,
  highlightColor: darkAccent.withOpacity(0.15),
  selectedRowColor: darkAccent.withOpacity(0.15),
  accentIconTheme: IconThemeData(color: darkPrimary, size: 24),
  primaryIconTheme: IconThemeData(color: darkText, size: 24),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: darkAccent,
    actionTextColor: darkPrimary,
    contentTextStyle: TextStyle(color: darkPrimary.withOpacity(0.8)),
    behavior: SnackBarBehavior.floating,
  ),
  cardTheme: CardTheme(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: darkText,
        letterSpacing: 1.2,
        fontFamily: GoogleFonts.poppins().fontFamily),
    bodyText2: TextStyle(
        color: darkPrimary,
        letterSpacing: 1.2,
        fontFamily: GoogleFonts.poppins().fontFamily),
    subtitle2: TextStyle(
        color: darkText,
        letterSpacing: 1.2,
        fontFamily: GoogleFonts.poppins().fontFamily),
    subtitle1: TextStyle(
        color: darkPrimary,
        letterSpacing: 1.2,
        fontFamily: GoogleFonts.poppins().fontFamily),
    button: TextStyle(
        color: darkPrimary, fontFamily: GoogleFonts.cabin().fontFamily),
    caption: TextStyle(
        color: darkText, fontFamily: GoogleFonts.poppins().fontFamily),
    headline1:
        TextStyle(color: darkText, fontFamily: GoogleFonts.cabin().fontFamily),
    headline2:
        TextStyle(color: darkText, fontFamily: GoogleFonts.cabin().fontFamily),
    headline3:
        TextStyle(color: darkText, fontFamily: GoogleFonts.cabin().fontFamily),
    headline4:
        TextStyle(color: darkText, fontFamily: GoogleFonts.cabin().fontFamily),
    headline5:
        TextStyle(color: darkText, fontFamily: GoogleFonts.cabin().fontFamily),
    headline6: TextStyle(
        color: darkText,
        fontFamily: GoogleFonts.cabin().fontFamily,
        fontWeight: FontWeight.w800),
  ),
  buttonBarTheme: ButtonBarThemeData(),
  buttonTheme: ButtonThemeData(
    buttonColor: darkAccent,
    textTheme: ButtonTextTheme.primary,
    colorScheme: ColorScheme.dark(),

    disabledColor: darkText.withOpacity(0.8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  timePickerTheme: TimePickerThemeData(
    dialHandColor: darkAccent,
    backgroundColor: darkPrimary,
    hourMinuteColor: darkAccent.withOpacity(0.3),
    dayPeriodColor: darkAccent.withOpacity(0.3),
    dayPeriodTextColor: darkAccent,
    hourMinuteTextColor: darkAccent,
    entryModeIconColor: darkText,
    helpTextStyle: TextStyle(
        color: darkText,
        fontFamily: GoogleFonts.cabin().fontFamily,
        fontSize: 19,
        fontWeight: FontWeight.w800),
    dayPeriodTextStyle: TextStyle(
        color: darkText,
        fontFamily: GoogleFonts.cabin().fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w800),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkAccent.withOpacity(0.3),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkAccent)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      isDense: true,
    ),
    hourMinuteTextStyle: TextStyle(
        fontSize: 24,
        color: darkText,
        fontFamily: GoogleFonts.cabin().fontFamily),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    dayPeriodShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    hourMinuteShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(),
  buttonColor: darkAccent,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: darkAccent,
    disabledElevation: 0,
  ),
  appBarTheme: AppBarTheme(
      elevation: 0,
      color: darkPrimary,
      iconTheme: IconThemeData(color: darkText, size: 25),
      textTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.white70,
            fontSize: 20,
            fontFamily: GoogleFonts.poppins().fontFamily),
      )),
  dividerTheme: DividerThemeData(
    color: darkAccent,
    thickness: 0.5,
    indent: 20,
    endIndent: 20,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: darkPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 4,
      type: BottomNavigationBarType.fixed,
      backgroundColor: darkPrimary,
      unselectedLabelStyle: TextStyle(color: darkText),
      showUnselectedLabels: false,
      showSelectedLabels: true,
      unselectedIconTheme: IconThemeData(color: darkAccent.withOpacity(0.5)),
      selectedIconTheme: IconThemeData(color: darkAccent),
      selectedLabelStyle:
          TextStyle(color: darkAccent, fontWeight: FontWeight.bold)),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: darkText.withOpacity(0.4),
    labelStyle: TextStyle(
      color: darkText,
    ),
    alignLabelWithHint: true,
    counterStyle: TextStyle(color: darkText),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: darkText)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red.shade400)),
  ),
);
