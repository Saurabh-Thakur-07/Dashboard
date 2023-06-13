import 'package:flutter/material.dart';
import 'package:sample_app/style/colors.dart';

import 'leftpanel.dart';
import 'middlepanel.dart';
import 'rightpanel.dart';
import 'style/style.dart';

void main() {
  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),  
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isMenuSelected = false;

  void toggleMenu() {
    setState(() {
      isMenuSelected = !isMenuSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Dashboard'),
      // ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            // child: LeftPanel(
            //   toggleMenu: toggleMenu,
            // )
            child: SideBar(
              toggleMenu: toggleMenu,
            ),
          ),
          Expanded(
            flex: 3,
            child: MiddlePanel(
              isMenuSelected: isMenuSelected,
            ),
          ),
          RightPanel(),
          // HomePage(),
        ],
      ),
    );
  }
}

// class LeftPanel extends StatelessWidget {
//   final Function()? toggleMenu;

//   const LeftPanel({required this.toggleMenu});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       color: Colors.blue,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListTile(
//             title: Text('Menu'),
//           ),
//           ListTile(
//             title: Text('Item 1'),
//             onTap: toggleMenu,
//           ),
//           ListTile(
//             title: Text('Item 2'),
//             onTap: toggleMenu,
//           ),
//           ListTile(
//             title: Text('Item 3'),
//             onTap: toggleMenu,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MiddlePanel extends StatelessWidget {
//   final bool isMenuSelected;

//   const MiddlePanel({required this.isMenuSelected});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey,
//       child: Center(
//         child: isMenuSelected ? FormFields() : SizedBox(),
//       ),
//     );
//   }
// }

class RightPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.primaryBg,
        child: ExpandableListView(),
      ),
    );
  }
}

// class FormFields extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextField(
//           decoration: InputDecoration(
//             labelText: 'Enter a value',
//           ),
//         ),
//         SizedBox(height: 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // Save button pressed
//               },
//               child: Text('Save'),
//             ),
//             SizedBox(width: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Cancel button pressed
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Navigation Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Handle the Home navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle the Settings navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Handle the About navigation
              },
            ),
          ],
        ),
      ),
      body: Container(
//         alignment: Alignment.topRight, // Align the container to the top right
        child: const Center(
          child: Text('Body content goes here'),
        ),
      ),
    );
  }
}

class ExpandableListView extends StatefulWidget {
  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? _slideAnimation;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void toggleExpanded() {
    setState(() {
      if (_animationController!.isCompleted) {
        _animationController!.reverse();
      } else {
        _animationController!.forward();
      }
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
        backgroundColor: Colors.grey,  
        child: IconButton.outlined(
            onPressed: toggleExpanded,
            icon: const Icon(Icons.arrow_back),
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 8.0),
        SlideTransition(
          position: _slideAnimation!,
          child: Container(
            height: 250,
            width: double.infinity,
            color: AppColors.primaryBg,
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: [
                DrawerListTile(
                  title: "Item 1 ",
                  toggleMenu: () {},
                ),
                DrawerListTile(
                  title: "Item 1 ",
                  toggleMenu: () {},
                ),
                DrawerListTile(
                  title: "Item 1 ",
                  toggleMenu: () {},
                ),
                DrawerListTile(
                  title: "Item 1 ",
                  toggleMenu: () {},
                ),
                DrawerListTile(
                  title: "Item 1 ",
                  toggleMenu: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String? title;
  final Function()? toggleMenu;

  const DrawerListTile({Key? key, this.title, this.toggleMenu})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0, right: 20),
      visualDensity: VisualDensity.standard,
      onTap: toggleMenu,
      // horizontalTitleGap: 0.0,
      leading:  Container(
       child: PrimaryText(text: title!, size: 14, fontWeight: FontWeight.w500),
       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      )
    );
  }
}
