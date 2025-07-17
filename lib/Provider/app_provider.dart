
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
 
  AppProvider() {
   
      
  
  }
 int selectedTab = 0;

  void setTab(int index) {
    selectedTab = index;
    notifyListeners();
  }
}
