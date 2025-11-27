import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.text,
    required this.press,
    required this.color,
    required this.backgroundColor,
    required this.width,
    this.textStyle,
  });
  final String text;
  final Function? press;
  final Color color;
  final double width;
  final Color backgroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: backgroundColor,
          elevation: 0,
        ),
        onPressed: press as void Function()?,
        child: Text(text, style: textStyle ?? AppTextStyles.defButtonTextStyle),
      ),
    );
  }
}
