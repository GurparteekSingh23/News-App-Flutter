import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  bool isDartModeChecked= true;
  void updateMode({required bool darkMode})
  async {
    isDartModeChecked=darkMode;
    final SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setBool("isDartModeChecked", isDartModeChecked);
    notifyListeners();
  }
  void LoadMode() async {

    final SharedPreferences pref=await SharedPreferences.getInstance();
    isDartModeChecked=pref.getBool("isDartModeChecked")??true;
    notifyListeners();
  }
}