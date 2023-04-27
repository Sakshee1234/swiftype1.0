import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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