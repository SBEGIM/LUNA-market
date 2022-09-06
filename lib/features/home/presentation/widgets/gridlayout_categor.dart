import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';

class GridLayoutCategory {
  String? title;
  String? icon;
  void Function()? onTap;

  GridLayoutCategory({
    this.title,
    this.icon,
    this.onTap,
  });
}

class GridOptionsCategory extends StatelessWidget {
  final GridLayoutCategory layout;
  const GridOptionsCategory({
    Key? key,
    required this.layout,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: layout.onTap,
      child: Container(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(15.0),
        // ),
        // elevation: 0,
        height: 80,
        decoration: BoxDecoration(
            color: AppColors.kBackgroundColor,
            borderRadius: BorderRadius.circular(10)),

        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                layout.icon!,
                color: AppColors.kPrimaryColor,
                // size: 30,
              ),
              const SizedBox(
                height: 13,
              ),
              Text(layout.title!, style: AppTextStyles.categoryTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}
