import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/provider/create_model.dart';
import 'package:sample_app/style/colors.dart';
import 'package:sample_app/style/style.dart';

// class Contact {
//   String? rolecode;
//   String? rolename;
//   String? roletype;
//   Contact(this.rolecode, this.rolename, this.roletype);
// }

List<Contact> list = List.empty(growable: true);
List<String> mappedItems = [];
Set items = {};

List<DropdownMenuItem<String>>? distinctItems;

class FormField extends StatefulWidget {
  const FormField({Key? key}) : super(key: key);

  @override
  State<FormField> createState() => _FormFieldState();
}

void showCustomSnackbar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(
      '$text',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class _FormFieldState extends State<FormField> {
  @override
  void initState() {
    Provider.of<CreateModel>(context, listen: false).readData();
    super.initState();
  }

  List<DropdownMenuItem<String>> dropdownItems = mappedItems.map((String item) {
    return DropdownMenuItem<String>(
      value: item,
      child: Text(item),
    );
  }).toList();
  String createRolename = '';
  String createRoletype = '';

  @override
  Widget build(BuildContext context) {
    if (Provider.of<CreateModel>(context).mappedItems.isNotEmpty) {
      createRoletype = Provider.of<CreateModel>(context).mappedItems.first;
      mappedItems = Provider.of<CreateModel>(context).mappedItems;
      list = Provider.of<CreateModel>(context).list;
    }
    // print('roletype value: $createRoletype');
    // print('mapped items');
    print(mappedItems);
    return Container(
      child: Consumer<CreateModel>(
        builder: (context, value, child) {
          if (value.list.isEmpty) {
            return Container(
              child: CircularProgressIndicator(),
            );
          } else {
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
                              createRolename = value;
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
                              createRoletype = newValue!;
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
                              print('passed rolename value is $createRolename');
                              print('passed roletype value is $createRoletype');
                              Provider.of<CreateModel>(context, listen: false)
                                  .roleName = createRolename;
                              Provider.of<CreateModel>(context, listen: false)
                                  .roleType = createRoletype;
                              Provider.of<CreateModel>(context, listen: false)
                                  .createData();
                              showCustomSnackbar(context, "Role Created");
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
                    notifyParent: () {},
                  ),
                )),
              ],
            );
          }
        },
      ),
    );
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
  _updatingUIState({required this.index});

  String? updateRolename;
  @override
  Widget build(BuildContext context) {
    String? dropdownValue = mappedItems.first;
    return ExpansionTile(
      title: Row(children: [
        Expanded(
            flex: 1,
            child:
                Text(list[index!].rolename!)),
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
                  updateRolename = value;
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
                items: Provider.of<CreateModel>(context)
                    .mappedItems
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newValue) {
                  dropdownValue = newValue ?? '';
                  print('drop down value is $dropdownValue');
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
                  // print(list[index!].rolecode);
                  // print();
                  String? rolecode =
                      Provider.of<CreateModel>(context, listen: false)
                          .list[index!]
                          .rolecode;
                  print(updateRolename);
                  print(dropdownValue);

                  Provider.of<CreateModel>(context, listen: false).roleCode =
                      rolecode!;
                  Provider.of<CreateModel>(context, listen: false).roleName =
                      updateRolename!;
                  Provider.of<CreateModel>(context, listen: false).roleType =
                      dropdownValue!;
                  Provider.of<CreateModel>(context, listen: false).updateData();

                  showCustomSnackbar(context, "Role Updated");
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
