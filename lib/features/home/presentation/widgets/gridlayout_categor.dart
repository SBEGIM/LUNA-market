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
        height: 80,
        decoration: BoxDecoration(
            color:const Color.fromRGBO(249,249,249,1),
            borderRadius: BorderRadius.circular(10)),

        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 20.05,
                width: 20.05,
                decoration: BoxDecoration(
                    image:  DecorationImage(
                      image: NetworkImage("http://80.87.202.73:8001/storage/${layout.icon!}"),
                      fit: BoxFit.cover,
                    )),
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
