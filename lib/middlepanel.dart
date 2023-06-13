import 'package:flutter/material.dart';
import 'package:sample_app/style/colors.dart';
import 'package:sample_app/formfield.dart';
class MiddlePanel extends StatelessWidget {
  final bool isMenuSelected;

  const MiddlePanel({required this.isMenuSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryBg,
      child: Center(
        child: isMenuSelected ? FormFields() : SizedBox(),
      ),
    );
  }
}
