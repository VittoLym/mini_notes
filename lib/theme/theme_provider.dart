import 'package:mini_notes/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // initially
  ThemeData _themeData = lightMode;

  // getter method to access the themme from other parts of the code
  ThemeData get themeData => _themeData;

  // getter method to see if we are in dark or not
  bool get isDarkMode => _themeData == darkMode;

  // setter methoed to set the new theme 
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }
  // use this toggle in a switchlater on..
  void toggleTheme() {
    if(_themeData == lightMode){
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
  }


}