import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class InstallMentWidget extends StatelessWidget {
  const InstallMentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: AppColors.kPrimaryColor,
// borderRadius: BorderRadius.circular(4)
          ),
          child: const Text(
            '3 мес',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.kPrimaryColor),
// borderRadius: BorderRadius.circular(4)
          ),
          child: const Text(
            '6 мес',
            style: TextStyle(
                color: AppColors.kPrimaryColor),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.kPrimaryColor),
            // color: Col,
// borderRadius: BorderRadius.circular(4)
          ),
          child: const Text(
            '12 мес',
            style: TextStyle(
                color: AppColors.kPrimaryColor),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.kPrimaryColor),
            // color: AppColors.kPrimaryColor,
// borderRadius: BorderRadius.circular(4)
          ),
          child: const Text(
            '24 мес',
            style: TextStyle(
                color: AppColors.kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
