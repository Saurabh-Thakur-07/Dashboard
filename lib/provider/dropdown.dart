import 'package:flutter/material.dart';
import 'package:sample_app/formfield.dart';
import 'create_model.dart';

class DropDownProvider extends ChangeNotifier {
  String? selectedItem = '';
  String get getSelectedItem => selectedItem!;
  void setSelectedItem(String item) {
    selectedItem = item;
    notifyListeners();
  }
}
