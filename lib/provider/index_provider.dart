// import 'package:flutter/material.dart';
//
// class SelectedIndexProvider with ChangeNotifier {
//   int _selectedIndex = -1;
//
//   int get selectedIndex => _selectedIndex;
//
//   void setSelectedIndex(int index) {
//     _selectedIndex = index;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
class SelectedIndexProvider with ChangeNotifier {
  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void resetSelectedIndex() {
    _selectedIndex = -1;
    notifyListeners();
  }
}
