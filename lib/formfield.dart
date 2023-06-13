import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_app/middlepanel.dart';
import 'package:sample_app/style/colors.dart';
import 'package:sample_app/style/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Contact {
  // int? id;

  String? rolecode;
  String? rolename;
  String? roletype;
  // String? createdon;
  // boolean? status;
  Contact(this.rolecode, this.rolename, this.roletype);
}

List<Contact> list = List.empty(growable: true);
List<String> mappedItems = [];
Set items = {};

List<DropdownMenuItem<String>>? distinctItems;

class FormField extends StatefulWidget {
  const FormField({Key? key}) : super(key: key);

  @override
  State<FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<FormField> {
  @override
  void initState() {
    readAdvisorRolePosData();
    super.initState();
  }

  createAdvisorRolePosData(String? rolename, String? roletype) async {
    Map data = {"rolename": rolename, "roletype": roletype};

    var body = json.encode(data);
    var response = await http.post(
        Uri.parse(
            "https://advisordevelopment.azurewebsites.net/api/Advisor/InsertAdvisorRoleM"),
        headers: {"Content-Type": "application/json"},
        body: body);
    var receivedData = json.decode(response.body);
    print(receivedData);
    setState(() {
      readAdvisorRolePosData();
    });
  }

  void showCustomSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Role Created',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  readAdvisorRolePosData() async {
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
    print(receivedData);
    for (var d in receivedData) {
      Contact c = Contact(d["rolecode"], d["rolename"], d["roletype"]);
      items.add(d["roletype"]);
      list.add(c);
    }
    mappedItems = [];
    items.forEach((item) {
      mappedItems.add(item);
    });
    print(items);
    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
      createRoletype = mappedItems.first;
    }

    // print(response.body);
  }

  List<DropdownMenuItem<String>> dropdownItems = mappedItems.map((String item) {
    return DropdownMenuItem<String>(
      value: item,
      child: Text(item),
    );
  }).toList();
  String? createRolename;
  String? createRoletype;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 16,
        ),
        SizedBox(height: 16),
        ExpansionTile(
          title: Center(child: PrimaryText(text: "Create Role")),
          children: [
            SizedBox(height: 16),
            ListTile(
              title: Row(children: [
                Expanded(flex: 1, child: Text('Rolename')),
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Type your Role",
                    ),
                    onChanged: (value) {
                      setState(() {
                        createRolename = value;
                      });
                    },
                  ),
                ),
              ]),
            ),
            // const SizedBox(width: 16),
            ListTile(
              title: Row(children: [
                Expanded(flex: 1, child: Text('Roletype')),
                Expanded(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: createRoletype,
                    items: mappedItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        createRoletype = newValue ?? '';
                        print(createRoletype);
                      });
                    },
                  ),
                ),
              ]),
            ),
            ListTile(
              title: Row(children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    child: Text('Create'),
                    onPressed: () {
                      print(createRolename);
                      print(createRoletype);
                      createAdvisorRolePosData(createRolename, createRoletype);
                      showCustomSnackbar(context);
                    },
                  ),
                ),
              ]),
            ),
          ],
        ),
        const ListTile(
          title: Row(
            children: [
              // const SizedBox(width: 16),
              Expanded(
                  flex: 1,
                  child: PrimaryText(
                    text: 'Rolename',
                    size: 16,
                  )),
              Expanded(
                  flex: 1,
                  child: PrimaryText(
                    text: 'Roletype',
                    size: 16,
                  )),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => updatingUI(
            index: index,
            notifyParent: refresh,
          ),
        )),
      ],
    );
  }

  void refresh() {
    readAdvisorRolePosData();
    setState(() {});
    showCustomSnackbar(context);
  }
}

class FormFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormField();
  }
}

class updatingUI extends StatefulWidget {
  final int index;
  final VoidCallback notifyParent;
  const updatingUI({Key? key, required this.index, required this.notifyParent})
      : super(key: key);

  @override
  State<updatingUI> createState() => _updatingUIState(index: index);
}

class _updatingUIState extends State<updatingUI> {
  int? index = 0;
  // final VoidCallback notifyParent;
  updateAdvisorRolePosData(
      String? rolecode, String? rolename, String? roletype) async {
    Map data = {
      "rolecode": rolecode,
      "rolename": rolename,
      "roletype": roletype,
      "status": "1",
    };
    var body = json.encode(data);
    var response = await http.post(
        Uri.parse(
            "https://advisordevelopment.azurewebsites.net/api/Advisor/UpdateAdvisorRoleM"),
        headers: {"Content-Type": "application/json"},
        body: body);

    print(response.body);
  }

  _updatingUIState({this.index});

  String? dropdownValue = mappedItems.first;
  String? updateRolename;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(children: [
        Expanded(flex: 1, child: Text(list[index!].rolename!)),
        Expanded(
          flex: 1,
          child: Text(list[index!].roletype!),
        )
      ]),
      children: [
        ListTile(
          title: Row(children: [
            Expanded(flex: 1, child: Text('Rolename')),
            Expanded(
              flex: 1,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Type your Role",
                ),
                onChanged: (value) {
                  setState(() {
                    updateRolename = value;
                  });
                },
              ),
            ),
          ]),
        ),
        // const SizedBox(width: 16),
        ListTile(
          title: Row(children: [
            Expanded(flex: 1, child: Text('Roletype')),
            Expanded(
              flex: 1,
              child: DropdownButton<String>(
                value: dropdownValue,
                items:
                    mappedItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue ?? '';
                    print(dropdownValue);
                  });
                },
              ),
            ),
          ]),
        ),
        ListTile(
          title: Row(children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                child: Text('Update'),
                onPressed: () async {
                  print(list[index!].rolecode);
                  print(updateRolename);
                  print(dropdownValue);
                  await updateAdvisorRolePosData(
                    list[index!].rolecode,
                    updateRolename,
                    dropdownValue,
                  );
                  widget.notifyParent(); // Call the parent's refresh method
                },
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({super.key});

  @override
  State<CustomDropDownButton> createState() => _CustomDropStateDownButton();
}

class _CustomDropStateDownButton extends State<CustomDropDownButton> {
  String dropdownValue = mappedItems.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      items: mappedItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue ?? '';
          // print(dropdownValue);
        });
      },
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String? text;
  final Function()? onPress;
  const CustomElevatedButton({super.key, this.text, this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: PrimaryText(
        text: text!,
        size: 17,
      ),
      onPressed: () {
        onPress!();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: TextStyle(fontSize: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
