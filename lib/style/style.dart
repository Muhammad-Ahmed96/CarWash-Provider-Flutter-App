import 'package:flutter/material.dart';

ThemeData uiTheme() {
  return ThemeData(
    unselectedWidgetColor: Colors.grey[800],
    fontFamily: 'Roboto',
    accentColor: Colors.white,
    tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: Colors.grey),
    appBarTheme:
        AppBarTheme(iconTheme: IconThemeData(size: 10, color: Colors.white)),
    scaffoldBackgroundColor: Color(0xff1e1e29),
    dividerColor: Colors.grey[800],
    primaryColor: Color(0xff1e1e29),
    backgroundColor: Color(0xff262533),
    primarySwatch: Colors.grey,
    textTheme: TextTheme(
        button: TextStyle(color: Colors.white),
        bodyText1: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        bodyText2: TextStyle(color: Colors.grey, fontSize: 12),
        headline5: TextStyle(color: Colors.white, fontSize: 20),
        subtitle1: TextStyle(color: Colors.white)),
  );
}
