import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/common/constants.dart';

// ignore: must_be_immutable
class TopMenu extends StatelessWidget {
  final String text;
  final String icon;
  void Function()? onTap;
  TopMenu({super.key, required this.text, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 4, top: 10, left: 0),
        decoration: BoxDecoration(
          color: AppColors.mainPurpleColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(12),
        ),
        //  color: AppColors.kBlueColor,
        height: 94,
        width: 127,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, color: Colors.white, height: 30),
            const SizedBox(height: 23),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
