import 'package:flutter/material.dart';
import 'package:sample_app/style/colors.dart';

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
        ElevatedButton(
          onPressed: toggleExpanded,
          child: Text(
            'Toggle List View',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        SlideTransition(
          position: _slideAnimation!,
          child: Container(
            height: 200,
            width: double.infinity,
            color: AppColors.primaryBg,
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: [
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
                ListTile(title: Text('Item 3')),
                ListTile(title: Text('Item 4')),
                ListTile(title: Text('Item 5')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
