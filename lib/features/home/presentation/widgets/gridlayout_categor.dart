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
        height: 80,
        width: 90,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(249, 249, 249, 1),
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Stack(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 90,
                //width: 128.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
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
                  height: 26,
                  margin: EdgeInsets.only(top: 64),
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 3),
                  // width: 128,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    border: Border.all(
                      width: 0.1,
                    ),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Text(layout.title!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppTextStyles.categoryTextStyle)),
            ],
          ),
        ),
      ),
    );
  }
}
