import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Contact {
  String? rolecode;
  String? rolename;
  String? roletype;
  Contact(this.rolecode, this.rolename, this.roletype);
}

class CreateModel extends ChangeNotifier {
  List<Contact> list = List.empty(growable: true);
  List<String> mappedItems = [];
  Set items = {};
  String _roleName = '';
  String _roleType = '';
  String _roleCode = '';
  String get getroleCode => _roleCode;
  String get getroleName => _roleName;
  String get getroleType => _roleType;

  set roleName(String name) {
    _roleName = name;
  }

  set roleType(String type) {
    _roleType = type;
  }

  set roleCode(String code) {
    _roleCode = code;
  }

  Future<void> createData() async {
    Map data = {"rolename": _roleName, "roletype": _roleType};
    var body = json.encode(data);
    var response = await http.post(
        Uri.parse(
            "https://advisordevelopment.azurewebsites.net/api/Advisor/InsertAdvisorRoleM"),
        headers: {"Content-Type": "application/json"},
        body: body);
    var receivedData = json.decode(response.body);
    // print(receivedData);
    readData();
  }

  Future<void> readData() async {
    Map data = {"status": "1"};
    items = {};
    list = [];
    var body = json.encode(data);
    var response = await http.post(
        Uri.parse(
            "https://advisordevelopment.azurewebsites.net/api/Advisor/ReadAdvisorRoleM"),
        headers: {"Content-Type": "application/json"},
        body: body);
    var receivedData = json.decode(response.body);
    // print(receivedData);
    for (var d in receivedData) {
      Contact c = Contact(d["rolecode"], d["rolename"], d["roletype"]);
      items.add(d["roletype"]);
      list.add(c);
    }
    mappedItems = [];
    items.forEach((item) {
      mappedItems.add(item);
    });
    // print(items);
    notifyListeners();
  }

  Future<void> updateData() async {
    print(_roleCode);
    print(_roleName);
    print(_roleType);
    Map data = {
      "rolecode": _roleCode,
      "rolename": _roleName,
      "roletype": _roleType,
      "status": "1",
    };
    var body = json.encode(data);
    var response = await http.post(
        Uri.parse(
            "https://advisordevelopment.azurewebsites.net/api/Advisor/UpdateAdvisorRoleM"),
        headers: {"Content-Type": "application/json"},
        body: body);

    // print(response.body);
    readData();
  }
}
