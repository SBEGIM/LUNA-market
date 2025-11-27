import 'package:flutter/material.dart';
import 'package:haji_market/src/core/theme/resources.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    if (text == null) return const SizedBox();

    return Text(text!, style: AppTextStyles.body14Regular.copyWith(color: AppColors.red));
  }
}
