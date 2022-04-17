import 'dart:ui';
import 'package:rapid/rapidProp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class RapidProp
{
  static bool darkMode = false;
  static bool dataSaver = true;
  static Map<String, dynamic> oldFavouriteList= {":":""};
  ///Dark mode
  static DarkMode darkModeProp= DarkMode();
  static LightMode lightModeProp= LightMode();
  static Settings settings= Settings();


}
class DarkMode
{
  Color logoNameBaseColor = Colors.white;
  Color appBarBackgroundColor = Colors.black;
  Color appBarIconColor = Colors.white;
  Color appBarTextColor = Colors.white;
  Color bodyBackgroundColor= Colors.black54;
  Color bodyTextColor= Colors.white;

}
class LightMode
{
  Color logoNameBaseColor = Colors.black;
  Color appBarBackgroundColor = Colors.white;
  Color appBarIconColor = Colors.black;
  Color appBarTextColor = Colors.black;
  Color bodyBackgroundColor= Colors.white70;
  Color bodyTextColor= Colors.black;

}

class Settings{
  void setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    RapidProp.darkMode= value;
  }
  Future<bool> getDarkMode() async{
    print("begin get darkmode");
    final prefs = await SharedPreferences.getInstance();
    bool value = false;
    value= prefs.getBool('darkMode')?? false;
    RapidProp.darkMode= value;
    print("get dark mode success");

    return value;
  }
}