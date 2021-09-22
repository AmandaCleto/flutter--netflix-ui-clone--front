import 'package:flutter/material.dart';

class BottomNavigationBarProvider extends ChangeNotifier {
  int _activeTab = 0;

  int get activeTab => _activeTab;

  void updateActiveTab(index) {
    _activeTab = index;
    notifyListeners();
  }
}
