import 'package:flutter/material.dart';

class DropDownProvider extends ChangeNotifier {
  String _selectedItem = '';
  String get getSelectedItem => _selectedItem;
  void setSelectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }
}
