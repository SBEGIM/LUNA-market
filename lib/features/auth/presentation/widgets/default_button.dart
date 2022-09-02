import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {required this.text,
      required this.press,
      required this.color,
      required this.width});
  final String text;
  final Function? press;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 46,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          primary: AppColors.kPrimaryColor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text,
          style: AppTextStyles.defButtonTextStyle,
        ),
      ),
    );
  }
}
