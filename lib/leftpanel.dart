// import 'package:flutter/material.dart';

// class LeftPanel extends StatelessWidget {
//   final Function()? toggleMenu;

//   const LeftPanel({required this.toggleMenu});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
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


//using stateful components
import 'package:flutter/material.dart';

import 'style/colors.dart';
import 'style/style.dart';

class SideBar extends StatefulWidget {
  final Function()? toggleMenu;

  const SideBar({required this.toggleMenu});

  @override
  _SideBarState createState() => _SideBarState(toggleMenu: this.toggleMenu);
}

class _SideBarState extends State<SideBar> {
  Function()? toggleMenu;

  _SideBarState({this.toggleMenu});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: AppColors.primaryBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "Menus",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DrawerListTile(
              title: "Master",
              icon: "assets/menu_home.png",
              toggleMenu: toggleMenu,
            ),
            DrawerListTile(
              title: "Account Role",
              icon: "assets/menu_home.png",
              toggleMenu: toggleMenu,
            ),
            DrawerListTile(
              title: "Employer Role",
              icon: "assets/menu_home.png",
              toggleMenu: toggleMenu,
            ),
            DrawerListTile(
              title: "Employer Category",
              icon: "assets/menu_home.png",
              toggleMenu: toggleMenu,
            ),
            DrawerListTile(
              title: "Employer Master",
              icon: "assets/menu_home.png",
              toggleMenu: toggleMenu,
            ),
            DrawerListTile(
              title: "Payment Master",
              icon: "assets/menu_home.png",
              toggleMenu: toggleMenu,
            ),
          ],
        ),
      ),
    );
  }
}
 
//  class SideBar extends StatelessWidget {
//   final Function()? toggleMenu;
//   const SideBar({super.key,this.toggleMenu});
  
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       elevation: 0,
//       child: Container(
//         color: Colors.amber,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: Text(
//                 "MATRIX HR",
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             DrawerListTile(
//               title: "Dashboard",
//               icon: "assets/menu_home.png",
//               toggleMenu: toggleMenu,
//             ),
//             DrawerListTile(
//               title: "Recruitment",
//               icon: "assets/menu_home.png",
//               toggleMenu: toggleMenu,
//             ),
//             DrawerListTile(
//               title: "Onboarding",
//               icon: "assets/menu_home.png",
//               toggleMenu: toggleMenu,
//             ),
//             DrawerListTile(
//               title: "Reports",
//               icon: "assets/menu_home.png",
//               toggleMenu: toggleMenu,
//             ),
//             DrawerListTile(
//               title: "Calendar",
//               icon: "assets/menu_home.png",
//               toggleMenu: toggleMenu,
//             ),
//             DrawerListTile(
//               title: "Settings",
//               icon: "assets/menu_home.png",
//               toggleMenu: toggleMenu,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class DrawerListTile extends StatelessWidget {
  final String? title, icon;
  final Function()? toggleMenu;

  const DrawerListTile({Key? key, this.title, this.icon, this.toggleMenu})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0, right: 20),
      visualDensity: VisualDensity.standard,
      onTap: toggleMenu,
      // horizontalTitleGap: 0.0,
      leading: Container(
          width: 50,
          padding: EdgeInsets.symmetric(
              vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(
            icon!,
            width: 20,
          )),
      title: PrimaryText(
          text: title!,
          size: 14,
          fontWeight: FontWeight.w500),
      );
  }
}