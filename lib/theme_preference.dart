import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class ThemePreferences{
//   static const PREF_KEY = 'pref_key';

//   setTheme(bool value) async{
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setBool(PREF_KEY, value);
//   }

//   getTheme() async{
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getBool(PREF_KEY);
//   }
// }

// class ThemeModel extends ChangeNotifier{
//   bool _isDark = false;
//   ThemePreferences _preferences = ThemePreferences();
//   bool get isDark => _isDark;

//   ThemeModel(){
//     _isDark = false;
//     _preferences = ThemePreferences();
//     getPreferences();
//   }

//   getPreferences() async{
//     _isDark = await _preferences.getTheme();
//     notifyListeners();
//   }

//   set isDark(bool value){
//     _isDark = value;
//     _preferences = _preferences.setTheme(value);
//     notifyListeners();
//   }
// }
  
  class ThemeSettings extends ChangeNotifier{
  ThemeData _currentTheme = ThemeData.light();
  ThemeData get currentTheme => _currentTheme;

  void toggleTheme(){
    if(_currentTheme == ThemeData.light()){
      _currentTheme = ThemeData.dark();
    }
    else{
      _currentTheme = ThemeData.light();
    }
    notifyListeners();
  }
}