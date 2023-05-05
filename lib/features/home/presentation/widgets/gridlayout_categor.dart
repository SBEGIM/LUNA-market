import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class GridLayoutCategory {
  String? title;
  String? icon;
  String? image;
  void Function()? onTap;

  GridLayoutCategory({this.title, this.icon, this.onTap, this.image});
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
        height: 127,
        width: 128,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(249, 249, 249, 1),
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 98,
                // width: 128.05,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      "http://185.116.193.73/storage/${layout.image}"),
                  fit: BoxFit.cover,
                )),
              ),
              // const SizedBox(
              //   height: 13,
              // ),
              Container(
                  height: 37,
                  // width: 128,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 0.1,
                    ),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Text(layout.title!,
                      style: AppTextStyles.categoryTextStyle)),
            ],
          ),
        ),
      ),
    );
  }
}
